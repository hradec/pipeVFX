# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================

#=================================================================================
#
#   access gdrive and gather client data from clientes spreadsheet!
#
#   author: rhadec - march/2013
#
#=================================================================================
from __future__ import print_function

gdata = '2.0.17'
import sys, os, traceback
# add gdata to pythonpath so gdata can find atom!
sys.path.append( "%s/gdata-%s/src/" % (os.path.dirname( __file__ ), gdata) )


#set proxy if needed
if 'PIPE_PROXY_SERVER' in os.environ:
    os.environ['http_proxy']  = "http://%s" % os.environ['PIPE_PROXY_SERVER']
    os.environ['https_proxy'] = "http://%s" % os.environ['PIPE_PROXY_SERVER']


try:
  from xml.etree import ElementTree
except ImportError:
  from elementtree import ElementTree
import gdata.spreadsheet.service
import gdata.service
import atom.service
import gdata.spreadsheet
import atom
import getopt

import string

import os, time
def min2secs(mins):
    return mins*60.0;

class clients(object):
    def __init__(self, email='pipeline@atomovfx.com.br', password='3datomo0'):
        self.gd_client = gdata.spreadsheet.service.SpreadsheetsService()
        self.gd_client.email = email
        self.gd_client.password = password
        self.gd_client.source = 'Spreadsheets GData Sample'
        self.curr_key = ''
        self.curr_wksht_id = ''
        self.internet = False
        self.data = {}
        #if os.popen('ping -c 1 8.8.8.8 | grep 100%').readlines():
        #    self.internet = False
        if self.internet:
            try:
                self.gd_client.ProgrammaticLogin()
            except:
                self.internet = False

    def _PrintFeed(self, feed):
     ''' dump data - perfect for debugging '''
     for i, entry in enumerate(feed.entry):
      if isinstance(feed, gdata.spreadsheet.SpreadsheetsCellsFeed):
        print( '-%s %s\n' % (entry.title.text, entry.content.text) )
      elif isinstance(feed, gdata.spreadsheet.SpreadsheetsListFeed):
        print( '+%s %s %s' % (i, entry.title.text, entry.content.text) )
        # Print this row's value for each column (the custom dictionary is
        # built using the gsx: elements in the entry.)
        print( 'Contents:' )
        for key in entry.custom:
          print( '  %s: %s' % (key, entry.custom[key].text) )
        print( '\n', )
      else:
        print( '=%s %s\n' % (i, entry.title.text) )

    def _returnDict(self, feed):
        ''' convert xml data from google to a dictionary '''
        from acentos import remover_acentos
        tit = {}
        ret = {}
        for i, entry in enumerate(feed.entry):
            if isinstance(feed, gdata.spreadsheet.SpreadsheetsCellsFeed):
                l = int(entry.title.text[1:])
                # we use the first line as the title for each column
                if l == 1:
                    tit[remover_acentos(entry.title.text[0])] = remover_acentos(entry.content.text.lower())
                else:
                    col = remover_acentos(entry.title.text[0])
                    # we use column A as the index of our dict!
                    if col == 'A':
                        client = remover_acentos(entry.content.text)
                        if not ret.has_key(client):
                            ret[client] = []
                        ret[client].append({})
                        for each in tit.keys()[1:]:
                            each = tit[each]
                            ret[client][-1][each] = ""
                        ret[client][-1]['row'] = l
                    else:
                        ret[client][-1][tit[col]] = remover_acentos(entry.content.text)
        return ret

    def cellsUpdateAction(self, row, col, inputValue):
        if self.curr_wksht_id:
           entry = self.gd_client.UpdateCell(row=row, col=col, inputValue=inputValue,
            key=self.curr_key, wksht_id=self.curr_wksht_id)
#        if isinstance(entry, gdata.spreadsheet.SpreadsheetsCell):
#          print 'Updated!'

    def live(self):

        if self.internet and not self.curr_wksht_id:
            # Get the list of spreadsheets
            feed = self.gd_client.GetSpreadsheetsFeed()
#            self._PrintFeed(feed)
            input = '0'
            for i, entry in enumerate(feed.entry):
                if entry.title.text == 'clientes':
                    input = str(i)

            id_parts = feed.entry[string.atoi(input)].id.text.split('/')
            self.curr_key = id_parts[len(id_parts) - 1]

            # Get the list of worksheets
            feed = self.gd_client.GetWorksheetsFeed(self.curr_key)
#                self._PrintFeed(feed)
#                input = raw_input('\nSelection: ')
            input = '0'
            id_parts = feed.entry[string.atoi(input)].id.text.split('/')
            self.curr_wksht_id = id_parts[len(id_parts) - 1]

    def query(self, force=False, cacheLifetime=30):
        ''' Get the feed of cells!
        Caches the data locally in /usr/tmp/.cache_clientes.dat
        to avoid hammering google docs, which can block us in that case!
        The cache have a 30 mins lifetime!
        '''
        if not self.internet:
            return

        cache = "/usr/tmp/.%s_cache_clientes.dat" % os.environ['USER']
        refresh = True
        if os.path.exists(cache):
            (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(cache)
            if (time.time() - mtime) < min2secs(cacheLifetime):
                refresh = force

        ret = os.popen('/bin/ping  -c 1 8.8.8.8 | /bin/grep 100%').readlines()
        if ret:
            refresh = False

        try:
            if refresh:
                self.live()
                feed = self.gd_client.GetCellsFeed(self.curr_key, self.curr_wksht_id)

                self.data = self._returnDict(feed)

                f=open(cache, "w")
                f.write(str(self.data))
                f.close()
            else:
                raise

        except:
            if refresh:
                print( '='*80 )
                traceback.print_exc()
                print( '='*80 )

        finally:
            # if less than 30 mins, just grab the cached data
            if not os.path.exists(cache):
                f=open(cache, "w")
                f.write(str({ "Could not retrieve Clients - Connection Error!" :
                    {
                        'administrator' : '',
                        'row': -1,
                        'email': '',
                        'senha': '',
                        'contato': ''
                    }
                }))
                f.close()
            f=open(cache, "r")
            self.data = eval( ''.join(f.readlines()) )
            f.close()



def all(cacheLifetime=30):
    ''' return all clients in a dictionary.
    it caches the data locally in /usr/tmp/.cache_clientes.dat
    to avoid hammering google docs, which can block us.
    the cache have a 30 mins lifetime!
    '''
    clientes = clients()
    clientes.query( cacheLifetime=cacheLifetime )
    return clientes.data

def asPreset():
    names = map( lambda x: (x,x), ['no client','Could not retrieve Clients - Connection Error!']+all().keys() )
    names.sort()
    return tuple( names )
