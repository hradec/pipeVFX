#!/usr/bin/env python
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

# -----------------------------------------------------------------------------
# --   
# --   Qube Main GUI
# --
# --   Copyright. Pipelinefx L.L.C. 
# --
# -------------------------------------------------

#=======================================
#  $Revision: #3 $
#  $Change: 10009 $
#=======================================

import logging
import sys
import os
import os.path
import optparse
import getpass
import datetime
import operator
import time
import warnings
import glob
import math
import shutil
import traceback # for printing exception info
import imp
import socket    # for hostname
import platform  # for platform name
import tempfile # for getting the tempdir
from xml.sax.saxutils import escape   # For html/xml docs escape function
import re

# Common modules for SimpleCmds (dynamically loaded so need it explicitly listed here to be compiled in)
import xml.dom.minidom  # for houdini

sys.argv[0]="%s/qube.py" % os.environ['QB_ICONS']

# conditional import of deque for history if python 2.4 or above
#if sys.version_info >= (2,4):
#    from collections import deque

# Optional: Use a specific version of wxPython
#import wxversion
#wxversion.select('2.6')

import wx
#import wx.animate  # for animated gif
from wx.lib.stattext import GenStaticText as StaticText
import wx.lib.dialogs


if wx.VERSION >= (2,7): # use wordwrap if available (introduced in wxPython 2.7)
    import wx.lib.wordwrap

# Determine qbdir (currently used for locating qb module and docs)
if os.environ.get('QBDIR', '') != '':  # if QBDIR exists and is not empty
    qbdir = os.environ['QBDIR'].strip()
    print "Qube location (from QBDIR): '%s'" % qbdir
else:
    # Determine QBDIR from platform defaults
    if sys.platform == 'darwin': # mac
        qbdir = '/Applications/pfx/qube'
    elif sys.platform[:5] == 'linux': # matches linux*
        qbdir = '/usr/local/pfx/qube'
    elif sys.platform[:3] == 'win':
        qbdir = 'c:/Program Files/pfx/qube'
    else:
        print ("ERROR: Unknown platform %s" % sys.platform)
        sys.exit(-1)
    print "Qube location (default): %s" % qbdir

# add the "bin" dir to PATH
os.environ['PATH'] += os.pathsep + qbdir + os.sep + "bin"
print 'Appended "bin" folder[%s] to PATH' % (qbdir + os.sep + "bin")

#  Handle frozen (executable) and non-frozen (scripted) versions of app
if not hasattr(sys, 'frozen'): # only append to path if not frozen by py2exe or py2app
    # Add paths and import qb module
    sys.path.append('%s/api/python' % qbdir)
    print 'Appending to python sys.path "%s/api/python"' % qbdir
    import qb
    print "Using qb python module from %s" % qb.__path__
else: # if hasattr(sys, 'frozen')
    if sys.platform[:3] == 'win':
        sys.argv[0] = os.path.join(sys.prefix, os.path.basename(sys.executable))
        rootDir = os.path.dirname(sys.argv[0])
        if rootDir not in sys.path:
            print 'Appending to python sys.path: %s' % rootDir
            sys.path.append(rootDir)
    elif sys.platform[:5] == 'linux' and os.environ.has_key('_MEIPASS2'): # matches linux* and is --onefile exe
        # if using pyinstaller
        # Link local simplecmds/ to temp frozen location (Linux only)
        simplecmdsDir = os.path.abspath(os.path.dirname(sys.argv[0]))+"/simplecmds"
        simplecmdsDir_mei = os.environ['_MEIPASS2']+"simplecmds"
        if os.path.exists(simplecmdsDir):
            # WORKAROUND: using symlink to simplecmds/ dir caused main dir to be
            #       removed on Fedora 11, though worked on others. Copying instead.
            # Create a simplecmds temp copy for this instance
            #logging.info("Creating copy of simplecmds directory at '%s'"%simplecmdsDir_mei)
            try:
                os.mkdir(simplecmdsDir_mei, 0755)
            except (OSError), e:
                pass #logging.warning('Cannot create directory "%s". Error: %s' % (simplecmdsDir_mei, e))
            # Copy the simplecmds
            for f in glob.glob('%s/*'%simplecmdsDir):
                try:
                    #logging.debug("Copying file '%s' to %s"%(f, simplecmdsDir_mei))
                    shutil.copy(f, simplecmdsDir_mei)
                except (IOError), e:
                    pass #logging.error("Unable to copy file '%s'"%f)
                
        # Set exe root to the temp frozen location
        sys.argv[0] = os.environ['_MEIPASS2']+'qube'
        rootdir = os.path.dirname(sys.argv[0])
        print ("Setting exe root to "+sys.argv[0])

        # Extract icons from pkg carchive in the exe temp dir
        import carchive
        exePkg = carchive.CArchive(sys.executable)
        #print "Main Archive", exePkg.contents()
        iconsPkg = exePkg.openEmbedded('icons.pkg')
        targetdir = os.path.dirname(sys.argv[0]) #os.environ['_MEIPASS2']
        #print "Icons Archive", iconsPkg.contents()
        for fnm in iconsPkg.contents():
            stuff = iconsPkg.extract(fnm)[1]
            outnm = os.path.join(targetdir, fnm)
            dirnm = os.path.dirname(outnm)
            #print "Writing file", outnm
            if not os.path.exists(dirnm):
                os.makedirs(dirnm)
            open(outnm, 'wb').write(stuff)
        iconsPkg = None

        # Extract icons from pkg carchive in the exe temp dir
        import carchive
        exePkg = carchive.CArchive(sys.executable)
        #print "Main Archive", exePkg.contents()
        AppUIPkg = exePkg.openEmbedded('AppUI.pkg')
        targetdir = os.path.dirname(sys.argv[0]) #os.environ['_MEIPASS2']
        #print "AppUI Archive", AppUIPkg.contents()
        for fnm in AppUIPkg.contents():
            stuff = AppUIPkg.extract(fnm)[1]
            outnm = os.path.join(targetdir, fnm)
            dirnm = os.path.dirname(outnm)
            #print "Writing file", outnm
            if not os.path.exists(dirnm):
                os.makedirs(dirnm)
            open(outnm, 'wb').write(stuff)
        AppUIPkg = None

    # Import qb module
    import qb

import qbSignals
import qbCache
import qbPrefs
import jobLayout
import jobMetaList
import jobProcessesRunningList
import hostLayout
import userList
import chartsLayout
import prefsDialog
import simplecmd
import submit
import confDialog
import qbloginDialog
import qbUtils
import configWizard
from hostList import pingWorkerDialog
from hostLayout import getHostResources, determineHostState
from jobList import JobFilterDependsCB
import qbPlugins
import logPanel
import qbTimer

# GLOBALS -------------------------
VERSION = (6,4,0, 'b')   # (major, minor, point/build, ['release', 'dev', 'alpha', 'beta'])
VERSION_STRING = '.'.join([str(i) for i in list(VERSION) if i not in ['release']])


# ============================
# HELPERS
# ============================

def updateSearchFilterHistoryMenu(searchHistoryPrefsKey, searchWidget, setSearchFilterExternallyFunc, newValue=None):
    '''
    This ends up being called for both SearchCtrl and TextCtrl widgets (don't even get me started
    about this...).  But TextCtrl widgets don't support history, so this throws an exception.
    Instead of pulling on a dozen threads to try to clean this up, we'll just test to make sure
    we'll only do the deed for searchCtrl widgets, which ~do~ support history...
    '''
    if isinstance(searchWidget, wx.SearchCtrl):
        # Update Prefs History List
        if newValue != None:
            # Initialize pref if using a factory/studio default so not overwrite, since deque/list is mutable
            # NOTE: the type(a)(a) format handles both list and deque cases for creating a shallow copy of the instance
            if not qbPrefs.preferences.userPrefs.has_key(searchHistoryPrefsKey):
                qbPrefs.preferences.userPrefs[searchHistoryPrefsKey] = type(qbPrefs.preferences[searchHistoryPrefsKey])(qbPrefs.preferences[searchHistoryPrefsKey])
            # Remove value if already in the list
            try:
                qbPrefs.preferences[searchHistoryPrefsKey].remove(newValue)
            except ValueError:
                pass
            # Add value to the top(left) of the list
            # COMPATABILITY: deque() more efficient for pop, though using list for compatability with 6.0.x and python 2.3
            #qbPrefs.preferences[searchHistoryPrefsKey].appendleft(newValue)
            # list -- backwards compatible, though less efficient with insert at front
            qbPrefs.preferences[searchHistoryPrefsKey].insert(0, newValue) 
            # Clip list to max number of entries
            if len(qbPrefs.preferences[searchHistoryPrefsKey]) > qbPrefs.preferences['toolbar_searchFilter_historyMax']:
                qbPrefs.preferences[searchHistoryPrefsKey].pop()
        
        # Callback stub function to pass the string
        def factory_searchFilterHistoryMenuItemCB(s):
            return lambda event: setSearchFilterExternallyFunc(s)

        # Create the menu
        searchFilter_historyMenu = wx.Menu()
        for val in qbPrefs.preferences.get(searchHistoryPrefsKey, []):
            menuid = wx.NewId()
            searchFilter_historyMenu.Append(menuid, val)
            searchFilter_historyMenu.Bind(wx.EVT_MENU, factory_searchFilterHistoryMenuItemCB(val), id=menuid)
        # Attach the menu
        #searchFilter_historyMenu.SetNextHandler( wx.GetTopLevelParent(self).GetEventHandler()) # Not sure if this is needed
        searchWidget.SetMenu(searchFilter_historyMenu)

    else:
        logging.debug('updateSearchFilterHistoryMenu: skipped, control does not support this functionality')


# Main Frame -----------------------
class MyFrame(wx.Frame):
    """Main Frame for the Qube GUI"""
    def __init__(self, parent, ID, title,
                 pos=wx.DefaultPosition,
                 size=(1000,700), style=wx.DEFAULT_FRAME_STYLE):
                        
        wx.Frame.__init__(self, parent, ID, title, pos, size, style)

        # Init member variables
        self.file_JobtypesHelp = None

        # --------------------------------------------
        #  TITLE BAR
        # --------------------------------------------
        # path is relative to the main script
        rootdir = os.path.dirname(sys.argv[0])
        rootdir = os.environ['QB_ICONS']
        if rootdir == '': rootdir = '.'
        titleBarIconPath = rootdir+"/icons/qube_icon.ico"
        try:
            titleBarIcon = wx.Icon(titleBarIconPath, wx.BITMAP_TYPE_ICO)
            self.SetIcon(titleBarIcon)
        except:
            logging.error("Cannot load title icon '%s'" %titleBarIconPath)

        # Bind Signal -- Run when supervisor ping is made and info updated
        qbSignals.signalCacheChanged_supervisorPing.connect( self.updateTitleBar )

        # Request to ping supervisor (that will cause the title bar to update)
        request = qbCache.QbServerRequest(action='supervisorPing')
        qbCache.QbServerRequestQueue.put(request)
            
        #=========================================================
        # Requests that should be run at startup to populate the 
        # cache, and that only need to be run once.
        #=========================================================
        request = qbCache.QbServerRequest(action='clientConfig', value='defaultPriority')
        qbCache.QbServerRequestQueue.put(request)

        # --------------------------------------------
        #  MENU BAR
        # --------------------------------------------
        self.createMenuBar()

        # Populate the Jobtype menus (Submit and File->Install UI)
        # NOTE: This is called last since there is a Windows bind 
        #       workaround that needs to be the last menu Bind() called        
        self.populateJobtypeMenus()

        # Find
        self.findDialog = None
        self.updateAdminMenuStatus()

        # Set Admin menu visibility (hide)
        if qbPrefs.preferences['display_adminMenu'] == False:
            self.setAdminMenuVisibility(False)

        # Misc Bindings
        self.Bind(wx.EVT_FIND, self.OnFind)  # Last-ditch binding if no other child windows picked this up 
        self.Bind(wx.EVT_FIND_CLOSE, self.OnFindClose)
        self.Bind(wx.EVT_MENU_OPEN, self.OnMenuOpen)     # A menu is about to be opened.
        self.Bind(wx.EVT_MENU_CLOSE, self.OnMenuClose)   # A menu is about to be closed.
        self.Bind(wx.EVT_MENU_HIGHLIGHT_ALL, self.OnMenuHighlight) # For status bar help
        self.isMenuOpen = False                          # track state of menu open status (since Windows can open menus w/o closing them)

            
        #--------------------------------------------
        # STATUS BAR
        #--------------------------------------------	
        
        self.statusbar = self.CreateStatusBar(5)
        self.SetStatusWidths([-1, -1, 5, 180, 200])
        self.SetStatusText("Qube! WranglerView "+VERSION_STRING+", PipelineFX 2009", 0)  # For menu help
        self.SetStatusText("", 1)  # Last line of Log Output
        self.SetStatusText("", 2)  # buffer
        self.SetStatusText("", 3)  # farm status
        self.SetStatusText("", 4)  # progress gauge for request queue

        # ProgressBar
        self.requestGauge = wx.Gauge(self.statusbar, -1, range=100, pos=(2,2), size=(50, 10), style=wx.GA_HORIZONTAL|wx.GA_SMOOTH)
        self.requestGauge.SetToolTip( wx.ToolTip("Supervisor requests in queue") )
        self.requestGauge.SetValue(0)
        self.OnStatusBarSize(None)  # put progress gauge in right spot
        self.statusbar.Bind(wx.EVT_SIZE, self.OnStatusBarSize)
        

        # ===============================================================
        # FLOATING PANELS
        # ===============================================================
        self.metaJobFrame = None
        
        #================================================================
        # SPLITTER FOR MAIN NOTEBOOK AND LOG
        #================================================================
        self.notebookAndLogSplitter  = wx.SplitterWindow(self, wx.NewId())
        self.mainLayoutNotebook = wx.Notebook(self.notebookAndLogSplitter, wx.NewId(), style=wx.NB_TOP)
        self.logPanel = logPanel.LogPanel(self.notebookAndLogSplitter)
        self.notebookAndLogSplitter.SetMinimumPaneSize(2) # NOTE: Setting this < 40 can cause crashes on SuSE92 w/ certain widget themes
        self.notebookAndLogSplitter.SetSashGravity(1.0)
        #self.notebookAndLogSplitter.Initialize(self.mainLayoutNotebook )
        splitterSashPos = qbPrefs.preferences.get('logSplitterSashPos', 530)
        self.notebookAndLogSplitter.SplitHorizontally(self.mainLayoutNotebook , self.logPanel, splitterSashPos)
        def OnSplitterPosChanged_logCB(evt):
            wx.CallAfter(self.notebookAndLogSplitter.SetSashPosition, max(80, evt.GetSashPosition())) 
        self.notebookAndLogSplitter.Bind( wx.EVT_SPLITTER_SASH_POS_CHANGED, OnSplitterPosChanged_logCB, id=self.notebookAndLogSplitter.GetId() )
        # WORKAROUND: Issue on Linux not keeping sash sizes after init (works fine on Windows and OSX)
        if True: #sys.platform[:5] == 'linux':
            wx.CallAfter(self.notebookAndLogSplitter.SetSashPosition, max(80, self.notebookAndLogSplitter.GetSashPosition(), qbPrefs.preferences.get('logSplitterSashPos'))) # Note: using Get...() since neg numbers not usable by Set...()
        #self.notebookAndLogSplitter.Unsplit()
        
        #================================================================
        # MAIN NOTEBOOK LAYOUTS
        #================================================================
        # See above 
        #self.mainLayoutNotebook = wx.Notebook(self, wx.NewId(), style=wx.NB_TOP)
 
        # Add to layout
        self.jobLayout    = jobLayout.JobLayout(self.mainLayoutNotebook, -1)        
        self.jobProcessesRunningLayout = jobProcessesRunningList.JobProcessesRunningList(self.mainLayoutNotebook, -1)
        self.hostLayout   = hostLayout.HostLayout(self.mainLayoutNotebook, -1)
        self.adminLayout   = userList.UserList(self.mainLayoutNotebook, -1)
        self.chartsLayout   = chartsLayout.ChartsLayout(self.mainLayoutNotebook, -1)

        self.mainLayoutNotebook.AddPage(self.jobLayout , "Jobs")
        self.mainLayoutNotebook.AddPage(self.jobProcessesRunningLayout , "Running Tasks")
        self.mainLayoutNotebook.AddPage(self.hostLayout, "Workers")
        self.mainLayoutNotebook.AddPage(self.chartsLayout, "Performance Charts")
        self.mainLayoutNotebook.AddPage(self.adminLayout, "User Permissions")

        if qbPrefs.preferences['display_adminLayout'] == False:
            self.setAdminLayoutVisibility( False )

        if qbPrefs.preferences['display_chartsLayout'] == False:
            self.setChartsLayoutVisibility( False )
        
        # --------------------------------------------
        # CALLBACK BINDINGS
        # --------------------------------------------
        self.mainLayoutNotebook.Bind(wx.EVT_NOTEBOOK_PAGE_CHANGED, self.OnMainLayoutChanged, id=self.mainLayoutNotebook.GetId()  ) # QUESTION: Should this be on the self.mainLayoutNotebook?
        self.Bind(wx.EVT_CLOSE, self.closeCB )    # To exit app

        # Add Log Handler to direct logging info to LogPanel (since LogPanel is now created)
        global logPaneHandler
        logPaneHandler.connectControls(textctrl=self.logPanel, statusbarFrame=self, statusbarIndex=1)

        # Set Stdout/Stderr to go to log pane as well
        #sys.stdout = self.logPanel
        #sys.stderr = self.logPanel

        #-------------------------
        # Toolbar 
        #-------------------------
        self.toolbar  = MyToolBar(self, toolbarIndex=0)
        self.SetToolBar(self.toolbar)
        wx.CallAfter(self.toolbar.ApplyToolBar, 0) # FIX: OSX not always refreshing the toolbar, so doing an idle-call refresh
        self.toolbarSize = self.GetSize() - size  # WORKAROUND: needed since window is increased by toolbar size 

        #-------------------------
        # Refresh Timer
        #-------------------------
        self.refreshTimer = wx.Timer(self)
        self.Bind(wx.EVT_TIMER, self.menuQubeRefreshCB, self.refreshTimer)
        self.adjustRefreshTimer(self.refreshTimer, qbPrefs.preferences.RefreshEnabled, qbPrefs.preferences.RefreshInterval*1000, 'ALL items') # convert from seconds to milliseconds

        self.refreshTimer_selected = wx.Timer(self)
        self.Bind(wx.EVT_TIMER, self.menuQubeRefreshSelectedCB, self.refreshTimer_selected)
        self.adjustRefreshTimer(self.refreshTimer_selected, qbPrefs.preferences.RefreshSelectedEnabled, qbPrefs.preferences.RefreshSelectedInterval*1000, 'SELECTED items') # convert from seconds to milliseconds

        #---------------
        # Signals
        #---------------
        # Connnect up Save Preferences method to signal
        qbSignals.signalGatherPreferences.connect( self.savePreferences )
        # Connect up progress bar to "requests" signal
        qbSignals.signalCacheChanged_requests.connect( self.updateRequestGauge )
        # Connect up FarmSummary StatusBar to signal
        qbSignals.signalCacheChanged_host.connect( self.updateFarmSummaryStatusBar )
        qbSignals.signalCacheChanged_job.connect(  self.updateFarmSummaryStatusBar )
        

    def createMenuBar(self):
        menuBar = wx.MenuBar()
        
        self.popupMenuItems = qbPlugins.menus.get('Main', [])
        rootmenu = menuBar
        
        # Create an ID and then bind it
        for item in self.popupMenuItems:
            if (item['label'] == '-'): continue  # for separator
            item.setdefault('help', item['label']) # add default help if not present
            if not item.has_key('id'):
                item['id'] = wx.NewId()
            self.Bind(wx.EVT_MENU, self.factory_MenuItemCB(item['callback']), id=item['id'])

        # Add required menus (menus QubeGUI expecteds to be present.  See below creation block.)
        requiredMenus = [
                        'Main.&File.Install App UI',
                        'Main.&View',
                        'Main.&Submit',
                        'Main.&Administration',
                         ]
        requiredMenus = self.popupMenuItems.extend([{'menu':i, 'label':''} for i in requiredMenus])
        
        # Make a menu and populate from table in __init__
        submenus = {}
        menuitems = {}
        for item in self.popupMenuItems:
            menu = rootmenu
            # Create hierarchal submenus, splitting on '.'
            submenuNames = item['menu'].split('.')[1:]
            for i in xrange(len(submenuNames)):
                key = '.'.join(submenuNames[:i+1])
                if not submenus.has_key(key):
                    logging.debug("Creating main menu '%s'"%'.'.join(submenuNames))
                    submenus[key] = wx.Menu()
                    if menu == rootmenu:
                        menu.Append(submenus[key], submenuNames[i])
                    else:
                        menuId = wx.NewId()
                        menu.AppendMenu( menuId, submenuNames[i], submenus[key])
                        menuitems[item['menu']] = {'id':menuId}
                menu = submenus[key]
            if item.get('label','') == '-':
                menu.AppendSeparator()
            elif item.get('label','') != '':  # if label unspecified then skip item
                menuitemKey = '%s.%s'%(item['menu'],item['label'])
                menuitems[menuitemKey] = item
                menu.Append(item['id'], item['label'], item['help'])
                # EnabledCB
                enabledCB = item.get('enabledCB', None)
                if enabledCB != None:
                    try:
                        item['enabled'] = self.MenuItemCB(enabledCB) # pass in same params as a menu item callback
                    except Exception, e:
                        logging.error("Skipping. Menu enabledCB error: %s" % e)
                # Enabled
                if item.get('enabled', True) == False:
                    menu.Enable(item['id'], False)

        # Special menus that are dynamically added to or adjusted
        self.submitMenu    = submenus['&Submit']
        self.fileMenuAppUI = submenus['&File.Install App UI']
        self.adminMenu     = submenus['&Administration']
        
        # Special menu items that have feedback functions or toolbar buttons
        self.menuRefreshID             = menuitems.get('Main.&View.&Refresh (Only Get New/Changed Data)\tF5',{}).get('id', 0)
        self.menuClearAndRefreshID     = menuitems.get('Main.&View.Refresh (&Clear Cache)\tAlt+F5',{}).get('id', 0)
        self.menuRefreshSelID          = menuitems.get('Main.&View.Refresh &Selected\tShift-F5',{}).get('id', 0)
        self.menuInstallLicenseID      = menuitems.get('Main.&Administration.Install &License...',{}).get('id', 0)
        self.menuSupeLogID             = menuitems.get('Main.&Administration.View Supervisor Log...',{}).get('id', 0)
        self.menuAutostartSupervisorID = menuitems.get('Main.&Administration.Autostart Supervisor: Unknown',{}).get('id', 0)
        self.menuAutostartWorkerID     = menuitems.get('Main.&Administration.Autostart Worker: Unknown',{}).get('id', 0)
        self.menuWorkerStatusID        = menuitems.get('Main.&Administration.Worker: Unknown',{}).get('id', 0)
        self.menuSupeStatusID          = menuitems.get('Main.&Administration.Supervisor: Unknown',{}).get('id', 0)
        self.menuDbRepairID            = menuitems.get('Main.&Administration.Database Repair', {}).get('id', 0)

        # insert the menu bar into the frame
        self.SetMenuBar(menuBar)
        
    # -----------------------
    # HELPER FUNCTIONS for Main MenuBar
    # -----------------------

    # Callback stub function to pass in the hostnames
    def factory_MenuItemCB(self, func, *args, **kwargs):
        '''factory for generating menu item for popup menus'''
        return lambda event: self.MenuItemCB(func, *args, **kwargs)
    
    def MenuItemCB(self, func, *args, **kwargs):
        '''get selected hostnames and then call the specified function'''
        return func(self, *args, **kwargs)
 
    # --------------------------
        
    def updateTitleBar(self, *args, **kwargs):
        pingDict = qbCache.supervisorPingDict
        self.SetTitle('Qube! WranglerView %s [Supervisor: %s (%s licenses)]'%(VERSION_STRING,
                                                       pingDict.get('hostname', 'unreachable'),
                                                       pingDict.get('licenses', '?'),
                                                       ))

    def populateJobtypeMenus(self):
        # WORKAROUND: set submitMenu
        # TODO: replace submitMenu with self.submitMenu in this function
        submitMenu = self.submitMenu
        fileMenuAppUI = self.fileMenuAppUI

        # Clear existing job menus
        for i in submitMenu.GetMenuItems():
            submitMenu.RemoveItem(i)
        for i in fileMenuAppUI.GetMenuItems():
            fileMenuAppUI.RemoveItem(i)        
        
        # Get submit menu items and groupings 
        submitMenuItems = {}
        submitGroupings = ['cmd', '3D', 'renderers', '2D', '']  # default grouping order

        # Initialize the Submit menus and submenus
        # NOTE: the main submit menu is keyed to the submenu '()' (so can easily have submenus under the submit menu)
        submitSubmenu = {}
        submitSubmenu[()] = submitMenu

        # Append SimpleCmd menu items to submitMenuItems and add to Install UI menu
        self.registeredSimpleCmds = wx.GetApp().registeredSimpleCmds
        if len(self.registeredSimpleCmds) > 0:
            submitMenu.AppendSeparator()
            for i in self.registeredSimpleCmds:
                # Filter out submit items if not <ALL> requested to be displayed
                if '<ALL>' not in qbPrefs.preferences['display_submitInterfaces']:
                    if not (i.name in qbPrefs.preferences['display_submitInterfaces']):
                        continue
                # Append to submitMenuItems and update submitGroupings
                try:
                    i.menuID = wx.NewId()
                    submitGroup = i.category
                    if submitGroup == None: submitGroup = ''   # make sure is a str (no group specified default to an empty string)
                    if not submitGroup in submitGroupings:
                        submitGroupings.append(submitGroup)
                    submitMenuItems.setdefault(submitGroup, []).append({'id': i.menuID, 'name':i.name, 'help':i.help})
                    # Create submenu (if not exist)
                    submenus = tuple(submitGroup.split('/'))  
                    for j in range(1, len(submenus)):   # first item is the main submit menu group, others following / are submenus
                        submenu = submenus[1:j+1]
                        if not submitSubmenu.has_key(submenu):
                            parentGroup = '/'.join(submenus[:j])
                            logging.debug("Creating submit submenu '%s' under '%s'" % (repr(submenu), parentGroup))
                            submitSubmenu[submenu] = wx.Menu()
                            if not parentGroup in submitGroupings:
                                submitGroupings.append(parentGroup)
                            submitMenuItems.setdefault(parentGroup, []).append({'name': submenus[j], 'isSubmenu':True, 'submenu':submenu})
                except:
                    logging.error("Invalid SimpleCmd. Skipping Submit menuitem under '%s'."%i.name)
                    traceback.print_exc()
                # Add "Install App UI" menuitem
                try:
                    if i.install != None:
                        i.fileMenuAppUIID = wx.NewId()
                        if len(i.name) > 0:
                            menuItemLabel = i.name[0].upper()+i.name[1:]
                        else:
                            menuItemLabel = '(undefined)'
                        fileMenuAppUI.Append(i.fileMenuAppUIID, "Install '%s' App UI..."%menuItemLabel, "Install Application UI for the Simplecmd '%s'"%i.name)
                except:
                    logging.error("Invalid SimpleCmd. Skipping Install UI menuitem.")
        
        # Add main submission menu items (retrieve from app, used as a central place to store the values)
        for g in submitGroupings:
            # get name of current menu used in this grouping/submenu
            submenu = tuple(g.split('/')[1:]) # remove first item as it is the main submit menu group
            currentMenu = submitSubmenu[submenu]

            submitMenuItems.setdefault(g, [])
            if len(submitMenuItems[g]) > 0:
                # Sort items in grouping
                if sys.version_info < (2,4):
                    submitMenuItems[g].sort(lambda x,y: cmp(x.get('name','').lower(), y.get('name','').lower()))  # NOTE: 10x slower than using sort keys introduced in python 2.4
                else:
                    submitMenuItems[g].sort(key=lambda x: x.get('name','').lower())
                # Add menu items
                for i in submitMenuItems.get(g, []):
                    if i.get('isSubmenu', False) == True:
                        currentMenu.AppendMenu( -1, i['name'], submitSubmenu[i['submenu']])
                    elif i.get('name', '') == '-':
                        currentMenu.AppendSeparator()
                    else:
                        i.setdefault('id', wx.NewId())
                        menuitemName = i.get('label', '%s Job...'%i.get('name', '(unknown)'))
                        menuitemName = menuitemName[0].upper() + menuitemName[1:]  # capitalize the first letter automatically for consistancy
                        currentMenu.Append(i['id'], menuitemName, i.get('help', ''))
                if currentMenu == submitMenu: currentMenu.AppendSeparator()   # Add a separator if in main Submit menu

        # Load Job From File
        menuSubmitSavedJobID     = wx.NewId()
        submitMenu.Append(menuSubmitSavedJobID , "&Job from file...", "Submit Job from a file")


        # Submit handlers -----------------------------------
        # Explicit submit menu items ==
        self.Bind(wx.EVT_MENU, self.menuSubmitSavedJobCB , id=menuSubmitSavedJobID   )

        # Dynamic items --
        # Define Factory functions for callbacks
        def factory_menuSubmitCB(func):
            '''factory for generating a dialog for submission menus'''
            return lambda event: func({})

        def factory_menuSubmitSimpleCmdCB(sc):
            '''factory for generating a function with 'simpleCmd' instance set at generation time
            and the event coming dynamically
            '''
            return lambda event: simplecmd.createSubmitDialog(sc, {})

        def factory_menuInstallAppUICB(sc):
            '''factory for generating a function with 'simpleCmd' instance set at generation time
            and the event coming dynamically
            '''
            return lambda event: sc.install()

        # Regular submit menu bindings
        # TODO: Sort the items in the groups
        for g in submitMenuItems.values():
            for i in g:
                if i.get('id', None) != None and i.get('func', None) != None:
                    self.Bind(wx.EVT_MENU, factory_menuSubmitCB(i['func']) , id=i['id']   )

        # SimpleCmds
        for i in self.registeredSimpleCmds:
            if hasattr(i, 'menuID'):
                self.Bind(wx.EVT_MENU, factory_menuSubmitSimpleCmdCB(i) , id=i.menuID   )
            if hasattr(i, 'fileMenuAppUIID'):
                self.Bind(wx.EVT_MENU, factory_menuInstallAppUICB(i) , id=i.fileMenuAppUIID   )

        # Trailing Callbacks --------------------------------
        if sys.platform[:3] == 'win':
            # WORKAROUND (Windows): This one is to explicitly call Thaw in response to Freeze on EVT_MENU_OPEN
            # NOTE: This Bind() has to be done last after all the others
            self.Bind(wx.EVT_MENU, self.menuActionCB)          


    def setAdminMenuVisibility(self, show):
        menuBar = self.GetMenuBar()
        a = menuBar.FindMenu("&Administration")
        if show:
            menuBar.Insert(3, self.adminMenu, "&Administration")
        else:
            menuBar.Remove(a)


    def setAdminLayoutVisibility(self, show):
        if show:
            self.mainLayoutNotebook.AddPage(self.adminLayout, "User Permissions")
        else:
            for i in xrange(self.mainLayoutNotebook.GetPageCount()):
                if self.mainLayoutNotebook.GetPage(i) == self.adminLayout:
                    if i == self.mainLayoutNotebook.GetSelection():
                        self.mainLayoutNotebook.SetSelection(0)                        
                    self.mainLayoutNotebook.RemovePage(i)
                    break


    def setChartsLayoutVisibility(self, show):
        if show:
            self.mainLayoutNotebook.AddPage(self.chartsLayout, "Performance Charts")
        else:
            for i in xrange(self.mainLayoutNotebook.GetPageCount()):
                if self.mainLayoutNotebook.GetPage(i) == self.chartsLayout:
                    if i == self.mainLayoutNotebook.GetSelection():
                        self.mainLayoutNotebook.SetSelection(0)                        
                    self.mainLayoutNotebook.RemovePage(i)
                    break


    def updateAdminMenuStatus(self):
        if not qbUtils.isLocalSupervisorRunning():
            # Disable if Supe not running
            # TODO: Make this if supe not INSTALLED
            #if self.menuInstallLicenseID != 0:
            #    self.adminMenu.Enable(self.menuInstallLicenseID, False)
            if self.menuSupeLogID != 0:
                self.adminMenu.Enable(self.menuSupeLogID, False)
                
        if self.menuAutostartSupervisorID  != 0:
            if qbUtils.isSupervisorAutostart_Service():
                self.adminMenu.SetLabel(self.menuAutostartSupervisorID, 'Autostart Supervisor: Service on Boot')
            else:
                self.adminMenu.SetLabel(self.menuAutostartSupervisorID, 'Autostart Supervisor: Disabled')

        if self.menuWorkerStatusID != 0:
            if qbUtils.isLocalWorkerRunning():
                if qbUtils.isWorkerServiceRunning():
                    self.adminMenu.SetLabel(self.menuWorkerStatusID, 'Worker: Service Started')
                elif qbUtils.isDesktopWorkerRunning():
                    self.adminMenu.SetLabel(self.menuWorkerStatusID, 'Worker: Process (as Desktop User) Started')
            else:
                self.adminMenu.SetLabel(self.menuWorkerStatusID, 'Worker: Stopped')

        if self.menuSupeStatusID != 0:
            if qbUtils.isSupervisorServiceRunning():
                self.adminMenu.SetLabel(self.menuSupeStatusID, 'Supervisor: Service Started')
            else:
                self.adminMenu.SetLabel(self.menuSupeStatusID, 'Supervisor: Service Stopped')

        if self.menuAutostartWorkerID != 0:
            if qbUtils.isWorkerAutostart_Service():
                self.adminMenu.SetLabel(self.menuAutostartWorkerID, 'Autostart Worker: Service on Boot')
            elif qbUtils.isWorkerAutostart_Desktop():
                self.adminMenu.SetLabel(self.menuAutostartWorkerID, 'Autostart Worker: On User Login')
            else:
                self.adminMenu.SetLabel(self.menuAutostartWorkerID, 'Autostart Worker: Disabled')

#        self.updateAdminSvcActionMenu('worker')
#        self.updateAdminSvcActionMenu('supervisor')

        if qbUtils.totalTableCount > 0:
            self.enableAdminDbMenuItems()
            self.updateAdminDbTableCount()
        else:
            self.enableAdminDbMenuItems(enable=False)

    def updateAdminSvcActionMenu(self, svcName):
        if svcName == 'worker':
            svcStatusMenuID = self.menuWorkerStatusID
            svcIsRunning = qbUtils.isWorkerServiceRunning() or qbUtils.isLocalWorkerRunning()
        else:
            svcStatusMenuID = self.menuSupeStatusID
            svcIsRunning = qbUtils.isSupervisorServiceRunning()

        statusMenu = self.adminMenu.FindItemById(svcStatusMenuID)
        actionMenu = statusMenu.GetSubMenu()

        stopSvcMenuItem = None
        startSvcMenuItems = []
        for i in actionMenu.GetMenuItems():
            if i.GetLabel().startswith('Stop'):
                stopSvcMenuItem = i
            else:
                startSvcMenuItems.append(i)

        if svcIsRunning:
            for i in startSvcMenuItems:
                i.Enable(False)
            stopSvcMenuItem.Enable(True)
        else:
            for i in startSvcMenuItems:
                i.Enable(True)
            stopSvcMenuItem.Enable(False)

    def enableAdminDbMenuItems(self, enable=True):
        menuItems = [x for x in self.adminMenu.GetMenuItems() if x.GetItemLabelText().startswith('Database')]
        for item in menuItems:
            item.Enable(enable)

    def updateAdminDbTableCount(self):
        menuItem = [x for x in self.adminMenu.GetMenuItems() if x.GetItemLabelText().startswith('Database Repair')][0]
        currentLabel = menuItem.GetItemLabelText()

        if currentLabel.count('Only Available'):
            qbUtils.getTotalTableCount()

        corruptTableCount = len(qbUtils.corruptDbTables)
        roundedTableCount = int(qbUtils.totalTableCount/10) * 10

        newLabel = ''
        if corruptTableCount == 0:
            if qbUtils.totalTableCount == 0:
                newLabel = re.sub('- .*', '- All Tables (Try Health Check First)', currentLabel)
            else:
                newLabel = re.sub('- .*', '- ~%s Tables (Try Health Check First)' % roundedTableCount, currentLabel)
        else:
            newLabel = re.sub('- .*', '- %s Tables' % str(corruptTableCount), currentLabel)
        menuItem.SetText(newLabel)

    def OnShowFind(self, evt):
        focusedWidget = self.FindFocus()
        if focusedWidget == None:
            logging.error("Focused widget not determined. 'None' returned. Skipping action.")
            return
        logging.debug("Showing 'Find' dialog for window %s" % focusedWidget)
        # Destroy existing "Find" dialog if widget focus is different
        if self.findDialog != None and self.findDialog.GetParent() != focusedWidget:
            self.findDialog.Destroy()
            self.findDialog = None
        if self.findDialog == None:
            data  = wx.FindReplaceData()
            data.SetFlags(wx.FR_DOWN)
            self.findDialog = wx.FindReplaceDialog(focusedWidget, data, "Find")  #instead of "self"
            self.findDialog.data = data  # save a reference to it...
            focusedWidget.Bind(wx.EVT_FIND_CLOSE, self.OnFindClose)
        self.findDialog.Raise()
        self.findDialog.Show(True)


    def OnFind(self,event):
        logging.debug('Qube:OnFind()')
        logging.error('Currently focused window does not support find.  Highlight a text-based or list-based window and open "Find" dialog.')


    def OnFindClose(self, event):
        if self.findDialog != None:
            self.findDialog.Destroy()  # alternate: event.GetDialog().Destroy()
            self.findDialog = None


    # Misc
    def adjustRefreshTimer(self, refreshTimer, refreshEnabled, refreshInterval, timerText=''):
        if refreshInterval == 0 or refreshEnabled == False:
            logging.info('Disabling "%s" automatic refresh timer.'%timerText)
            refreshTimer.Stop()
        else:
            logging.info('Setting "%s" automatic refresh interval to %s (hh:mm:ss)' % (timerText, datetime.timedelta(0, refreshInterval/1000)))
            refreshTimer.Start(refreshInterval)

    def savePreferences(self):
        # Store Window size
        if qbPrefs.preferences.saveLayout == True:
            logging.debug( "Layout: Storing window sizes and panel sash position preferences" )
            mainWinSize                                          = self.GetSize() - self.toolbarSize
            qbPrefs.preferences['mainWindowSize']                = mainWinSize.Get()    # store this as a tuple, not a wx.Size instance
            qbPrefs.preferences['logSplitterSashPos']            = self.notebookAndLogSplitter.GetSashPosition()
            qbPrefs.preferences['jobLayoutSashPos']              = self.jobLayout.GetSashPosition()
            qbPrefs.preferences['jobLayoutJobSplitterSashPos']   = self.jobLayout.jobSplitter.GetSashPosition()
            qbPrefs.preferences['hostLayoutSplitterSashPos']     = self.hostLayout.GetSashPosition()
            

    def updateRequestGauge(self, requestsInQueue):
        if requestsInQueue == 0:
            self.requestGauge.SetValue(0)
        else:
            power = -0.5  # negative reciprocal provides number between 0-1.  Power determines curve
            gaugeValue = 90.0*math.pow(requestsInQueue, power)
            logging.debug("Gauge Progress val=%s  (in queue=%s)"%(gaugeValue, requestsInQueue))
            self.requestGauge.SetValue(100 - gaugeValue)
        self.SetStatusText('Requests in queue: %s' % str(requestsInQueue), 4)
        

    def updateFarmSummaryStatusBar(self, hostnames=[]):  # NOTE: hostnames is unused param from the signal
        # WORKER SUMMARY
        workers_running = len([i for i in qbCache.hostInfos.values() if determineHostState(i)=='running'])
        workers_idle    = len([i for i in qbCache.hostInfos.values() if determineHostState(i)=='idle'])        
        # SLOT SUMMARY    
        slots_activeHosts = [ [int(i) for i in getHostResources(host).get('host.processors', '0/0').split('/')] for host in qbCache.hostInfos.values() if host['state'] == 'active']
        if len(slots_activeHosts) > 0:
            slots_running, slots_total = zip(*slots_activeHosts)
        else:
            slots_running = slots_total = []
        # REPORT
        self.SetStatusText('Workers: %i/%i  Slots: %i/%i'%(workers_running,
                                                           workers_running+workers_idle,
                                                           sum(slots_running),
                                                           sum(slots_total) ), 3) 


    # Handle menu opening/closing
    def OnMenuOpen(self, event):
        # Check for service/process states in the admin menu each time it is opened
        # QUESTION: Does this mae the menu too slow to open?
        # REVISIT: Consider updating this menu when a "Refresh" is made (and after admin action) instead of menu open.
        if event.GetMenu() == self.adminMenu:
            logging.info("Updating Administration menu item status")
            self.updateAdminMenuStatus()

        # WORKAROUND (except for OSX): handle case when menu opens w/o closing
        #    Windows and Linux can have multiple menuOpen events but only one menuClose event
        #    OSX will always have a corresponding menuClose event for every menuOpen event
        if sys.platform != 'darwin' and self.isMenuOpen and self.notebookAndLogSplitter.IsFrozen():
            self.notebookAndLogSplitter.Thaw() # Thaw temporarily since should be currently frozen
        # Update and Freeze
        self.Update()
        self.notebookAndLogSplitter.Freeze()
        self.isMenuOpen = True
        event.Skip()

    def OnMenuClose(self, event):
        # Reset the help statusbar text
        self.SetStatusText("Qube "+VERSION_STRING+", PipelineFX 2009", 0)
        # Thaw it
        if self.notebookAndLogSplitter.IsFrozen():
            self.notebookAndLogSplitter.Thaw()
        self.isMenuOpen = False
        event.Skip()


    def OnMenuHighlight(self, event):
        '''extend menubar help text to display in statusbar for popup menus
        NOTE: Popup Menu help does not presently work in wx on Windows.'''
        menu = event.GetMenu()
        if menu == None or menu == self.GetMenuBar():
            # Use the standard method in the statusbar if the menubar is the main menu bar
            event.Skip()
        else:
            if (wx.GetTopLevelParent(self).GetStatusBar() != None):
                    helpstring = menu.GetHelpString(event.GetMenuId())
                    wx.GetTopLevelParent(self).SetStatusText(helpstring, 0)


    def OnStatusBarSize(self, event):
        rect = self.statusbar.GetFieldRect(4)
        yOffset = 0
        if sys.platform == 'win32':
            yOffset += 4
        self.requestGauge.SetPosition((rect.x+125, rect.y+yOffset))

        
    # CALLBACKS
    def menuActionCB(self,event):
        '''WORKAROUND: explicitly thaw on menu action.
        Needed on Windows for keyboard events since EVT_MENU_OPEN is called
        when a keyboard event is made, but no EVT_MENU_CLOSE is called
        '''
        if sys.platform[:3] == 'win':
            if self.notebookAndLogSplitter.IsFrozen():
                self.notebookAndLogSplitter.Thaw()
        event.Skip()


    def menuSubmitSavedJobCB(self,event):
        # Get Filename (return if Cancel)
        dlg = wx.FileDialog(
            self, message="Load Job file...", defaultDir=os.getcwd(), 
            defaultFile="", style=wx.OPEN,
            wildcard="Qube Job (*.xja;*.qja)|*.xja;*.qja|"
                     "XML (*.xml)|*.xml|"
                     "All files (*.*)|*.*")
        filename = None
        if dlg.ShowModal() == wx.ID_OK:
            filename = str(dlg.GetPath())  # convert unicode to str
        dlg.Destroy()
        if filename == None:
            return
        
        # Get Job from file
        logging.info( "Loading job file %s" % (filename))
        job = qb.recoverjob(filename)
        if not isinstance(job, (dict, qb.Job)):
            logging.error("Unable to load job file %s" % filename)
            return
        
        # Resubmit (open dialog)
        resultingJobs = submit.resubmitFromJob(job)


    def menuQubeRefreshCB(self,event):
        logging.debug( "Refreshing job and host data cache" )
        # Clear current supervisor request queue
        qbCache.clearRequestQueue()

        # refreshing jobinfo and jobdetails
        request = qbCache.QbServerRequest(action="jobinfo", value=-1, method='reload') # refresh all jobs
        qbCache.QbServerRequestQueue.put(request)

        request = qbCache.QbServerRequest(action="hostinfo", value='', method='reload') # refresh all hosts
        qbCache.QbServerRequestQueue.put(request)

        # TODO: Consider adding this as a default refresh action
        #    Pros: it will update the user info if changed outside of this GUI
        #    Cons: it is one more call to be executed when the user presses refresh
        #request = qbCache.QbServerRequest(action="userinfo", value='', method='reload') # refresh all hosts
        #qbCache.QbServerRequestQueue.put(request)

        request = qbCache.QbServerRequest(action="globalResources", value='', method='reload') # refresh all hosts
        qbCache.QbServerRequestQueue.put(request)


    def menuQubeClearAndRefreshCB(self,event):
        logging.debug( "Clearing Cache and refreshing job and host data" )
        # Clear current supervisor request queue
        qbCache.clearRequestQueue()

        qbSignals.signalCacheChanged_clearing()

        # refreshing jobinfo and jobdetails
        request = qbCache.QbServerRequest(action="jobinfo", value=-1, method='clear-reload') # refresh all jobs
        qbCache.QbServerRequestQueue.put(request)

        request = qbCache.QbServerRequest(action="hostinfo", value='', method='reload') # refresh all hosts
        qbCache.QbServerRequestQueue.put(request)
        
        request = qbCache.QbServerRequest(action="userinfo", value='', method='reload') # refresh all hosts
        qbCache.QbServerRequestQueue.put(request)

        request = qbCache.QbServerRequest(action="globalResources", value='', method='reload') # refresh all hosts
        qbCache.QbServerRequestQueue.put(request)


    def menuQubeRefreshSelectedCB(self,event):
        logging.debug( "Refreshing selected job and host data" )
        
        # refreshing jobinfo and jobdetails
        selectedJobids = self.jobLayout.jobList.GetSelectedJobids()
        if len(selectedJobids) > 0:
            request = qbCache.QbServerRequest(action="jobinfo", value=selectedJobids, method='reload') # refresh all jobs
            qbCache.QbServerRequestQueue.put(request)

        selectedHostnames = self.hostLayout.hostList.GetSelectedHosts()
        if len(selectedHostnames) > 0:
            request = qbCache.QbServerRequest(action="hostinfo", value=selectedHostnames, method='reload') # refresh all hosts
            qbCache.QbServerRequestQueue.put(request)

        # REVISIT: consider refreshing 'userinfo' as well


    def menuSearchFilterJobDepsCB(self,event):
        logging.debug( "Setting SearchFilter for dependent jobs." )
        # TODO: Use signal instead to set this
        jobids = self.jobLayout.jobList.GetSelectedJobids()
        JobFilterDependsCB(jobids)


    def menuSearchFilterClearCB(self,event):
        logging.debug( "Clearing SearchFilter." )
        qbSignals.signalAction_setSearchFilter( '' )


    def menuToggleMetaJobsSashCB(self,event):
        sashPos = self.jobLayout.metaJobSplitter.GetSashPosition()
        if sashPos < 10:
            logging.info('Showing MetaJob Panel')
            self.jobLayout.metaJobSplitter.SetSashPosition(0.5) # show the panel (evenly split with the JobList)
        else:
            logging.info('Hiding MetaJob Panel')
            self.jobLayout.metaJobSplitter.SetSashPosition(1) # hide the panel
            if qbPrefs.preferences.get('toolbar_searchFilter_value','').startswith('pgrp:'):
                qbSignals.signalAction_setSearchFilter( '' ) # clear search filter if search filter starts with "id:"


    def menuToggleLogSashCB(self,event):
        sashPos = self.notebookAndLogSplitter.GetSashPosition()
        panelLength = self.notebookAndLogSplitter.GetSize()[1]
        if sashPos+20 > panelLength:
            logging.info('Showing Log Panel')
            self.notebookAndLogSplitter.SetSashPosition(0.8*panelLength) # show the panel
        else:
            logging.info('Hiding Log Panel')
            self.notebookAndLogSplitter.SetSashPosition(panelLength-2) # hide the panel


    def menuToggleJobDetailsSashCB(self,event):
        sashPos = self.jobLayout.GetSashPosition()
        panelLength = self.jobLayout.GetSize()[0]
        if sashPos+80 > panelLength:
            logging.info('Showing Job Details Panel')
            self.jobLayout.SetSashPosition(0.6*panelLength) # show the panel
        else:
            logging.info('Hiding Job Details Panel')
            self.jobLayout.SetSashPosition(panelLength-2) # hide the panel


    def menuToggleJobFramesSashCB(self,event):
        sashPos = self.jobLayout.jobSplitter.GetSashPosition()
        panelLength = self.jobLayout.jobSplitter.GetSize()[1]
        if sashPos+80 > panelLength:
            logging.info('Showing Job Frames Panel')
            self.jobLayout.jobSplitter.SetSashPosition(0.6*panelLength) # show the panel
        else:
            logging.info('Hiding Job Frames Panel')
            self.jobLayout.jobSplitter.SetSashPosition(panelLength-2) # hide the panel


    def menuToggleWorkerSashCB(self,event):
        sashPos = self.hostLayout.GetSashPosition()
        panelLength = self.hostLayout.GetSize()[0]
        if sashPos+80 > panelLength:
            logging.info('Showing Worker Details Panel')
            self.hostLayout.SetSashPosition(0.6*panelLength) # show the panel
        else:
            logging.info('Hiding Worker Details Panel')
            self.hostLayout.SetSashPosition(panelLength-2) # hide the panel


    def menuPanelMetaJobsCB(self,event):
        logging.debug( "Opening MetaJobs Panel." )
        # If not exist, then create
        if self.metaJobFrame == None:
            # Create a singleton floating frame for pgrp metajob 
            def OnCloseMetaJobFrame(event):
                self.metaJobFrame = None
                event.Skip()            
            self.metaJobFrame = wx.Frame(self, wx.NewId(), "MetaJob List", size=(800,600), style=wx.DEFAULT_FRAME_STYLE)
            self.metaJobFrame.Bind(wx.EVT_CLOSE, OnCloseMetaJobFrame)
            jobList= jobMetaList.JobMetaList(self.metaJobFrame, -1)
        # Show frame (toggle hide/show to make sure it goes to the front)
        self.metaJobFrame.Show(False)
        self.metaJobFrame.Show(True)


    def menuAboutCB(self,event):
        # use AboutBox if available (introduced in wxPython 2.7)
        software = [ "Qube Python API "+qb.version(),
                     "Python "+sys.version,
                     "wxPython "+wx.__version__,
                    ]
        
        supePing = qb.ping(asDict=True)
        supePing.setdefault('licenses_type', 'unspecified')  # backward compatible with 6.0.1 and earlier API
        if len(supePing) > 0:
            supeInfo = ("Licenses: %(licenses_used)s/%(licenses)s (used/total) [per-%(licenses_type)s]\n"
                        "Qube Version: %(version)s\n"
                        "Platform: %(os)s\n"
                        "Build: %(build)s" % supePing)
        else:
            supeInfo = 'Not available'

        workerPing = qb.workerping(socket.gethostname(), asDict=True)
        if len(workerPing) > 0:
            workerInfo = ("Qube Version: %(version)s\n"
                          "Platform: %(os)s\n"
                          "Build: %(build)s" % workerPing)
        else:
            workerInfo = 'Not available'

        descriptionBody = (
            "\n"+
            "QubeGUI Client:\n"+
            "Platform "+platform.platform()+"\n"+
            ('\n'.join(software))+"\n"
            "\n"
            'Supervisor:\n'+supeInfo+'\n\n'
            'Worker:\n'+workerInfo+'\n'
            '\n'
            )

        if wx.VERSION >= (2,7):
            # Workaround: Issue with Fedora Core 5 on dialog box width, so reducing width for Linux
            if sys.platform[:5] == 'linux': # matches linux*
                textWidth = 350
            else:
                textWidth = 500
                
            # Specify the info
            info = wx.AboutDialogInfo()
            info.Name = "Qube!"
            info.Version = VERSION_STRING
            info.Copyright = "(C) 2009 PipelineFX, LLC"
            #info.Developers = developers
            info.Description =  wx.lib.wordwrap.wordwrap( descriptionBody,textWidth, wx.ClientDC(self))
            info.WebSite = ("http://www.pipelinefx.com", "PipelineFX")
            # Call the wx.AboutBox with the info object
            wx.AboutBox(info)
        else:
            aboutText = (
                'Qube! '+VERSION_STRING+'\n\n'
                "(c) 2009 PipelineFX, LLC.\n"
                "http://www.pipelinefx.com\n"
                + descriptionBody
                )
            dlg = wx.MessageDialog(self,
                    aboutText, 
                    "About Qube", 
                    wx.OK | wx.ICON_INFORMATION)
            dlg.ShowModal()
            dlg.Destroy()


    def launchDocument(self, filename, filetype=None):
        # Launch file with default app
        f = os.path.normpath( filename ) # make sure the path is well-constructed
        if os.path.exists(f):
            try:
                if sys.platform[:3] == 'win':        
                    if filetype == 'text' and not f.endswith('.txt'): # if explicitly specified as text, but without extension...
                        os.system('start wordpad "%s"'%f)             # force wordpad to open and view contents
                    else:
                        os.startfile(f)
                elif sys.platform == 'darwin':
                    if filetype == 'text':
                        os.system('open -t '+f)
                    else:
                        os.system('open '+f)
                else:
                    import webbrowser
                    # assume a file:// if not http specified
                    if not f.startswith('http://'):
                        f = 'file://'+f
                    webbrowser.open(f)
                    ## Alternate: Use MIME types for Linux
                    ##pdfType = wx.TheMimeTypesManager.GetFileTypeFromMimeType('application/pdf')
                    ##cmd = pdfType.GetOpenCommand(f, pdfType.GetMimeType())
                    ##os.system(cmd)
            except:
                logging.error('Unable to launch viewer or load file "%s".  Please specify default application to launch file.' % f)
                return False
        else:
            logging.error('File "%s" does not exist.  Please set QBDIR or check that file is readable.' % f)
            return False
        return True


    def launchWebpage(self, webpage):
        '''Launch webpage through default webbrowser'''
        return qbUtils.launchWebpage(webpage)


    def launchQubeguiDocument(self, filename):
        '''search multiple paths where qubegui docs can be located, then launch with viewer'''
        rootdir = os.path.dirname(sys.argv[0])
        if rootdir == '': rootdir = '.'
        paths = [rootdir,                         # Check in exe directory
                 rootdir+'/../api/python/qb/gui', # Check relative to exe to address "Program Files" "Program Files (x86)" location issue
                 qbdir+'/api/python/qb/gui',      # Check under qbdir
                ]
        foundDocs = ['%s/%s'%(i,filename) for i in paths if os.path.exists( '%s/%s'%(i,filename) )]
        if len(foundDocs) > 0:
            return self.launchDocument(foundDocs[0])
        else:
            logging.error("Unable to find '%s' under %s" % (filename, str(paths)))
        return False # if successfully launch, then should return above


    def menuSimpleCmdManualCB(self,event):
        self.launchQubeguiDocument('README_SIMPLECMD.html')

    def menuQubeguiDevManualCB(self,event):
        self.launchQubeguiDocument('README_DEVELOPER.html')

    def menuQubeguiReleaseCB(self,event):
        self.launchQubeguiDocument('RELEASE.txt')

    def menuUserManualCB(self,event):
        self.launchDocument(qbdir+'/docs/Use.pdf')

    def menuQubeDevManualCB(self,event):
        self.launchDocument(qbdir+'/docs/Development.pdf')

    def menuQubeDevPythonManualCB(self,event):
        self.launchDocument(qbdir+'/docs/API_Python.pdf')

    def menuQubeInstallManualCB(self,event):
        self.launchDocument(qbdir+'/docs/Installation.pdf')

    def menuQubeAdminManualCB(self,event):
        self.launchDocument(qbdir+'/docs/Administration.pdf')
    
    def menuSupportWebsiteCB(self,event):
        self.launchWebpage('http://support.pipelinefx.com/')
        
    def menuForumWebsiteCB(self,event):
        self.launchWebpage('http://support.pipelinefx.com/smf')

    def menuHelpJobtypesCB(self,event):
        # Construct temp html page
        htmlfile = self.constructJobtypeDocsHtml()
        # Launch tmp html page
        self.launchWebpage('file://%s'%htmlfile)


    def constructJobtypeDocsHtml(self):
        '''construct html from the jobtype README and docstrings
        '''
        # Get local config for readme info
        lc = qb.localconfig()
        # TODO: Account for (x86) jobtypes dir on Windows
        jobtypeDirs = lc.get('worker_template_path', qbdir+'/jobtypes').split(os.path.pathsep)
        
        # Determine html text --
        self.registeredSimpleCmds = wx.GetApp().registeredSimpleCmds
        tocText = []
        jobtypeText = []
        if len(self.registeredSimpleCmds) > 0:
            # Get list of jobtypes, sorted alphabetically (case insensitive)
            sortedSimpleCmds = list(self.registeredSimpleCmds) # copy of the registered simplecmds
            if sys.version_info < (2,4):
                # 10x slower than using keys (introduced in python 2.4)
                sortedSimpleCmds.sort(lambda x,y: cmp(str.lower(x.name), str.lower(y.name)))
            else:
                sortedSimpleCmds.sort(key=lambda x: str.lower(x.name))
            # Loop over the simplecmds and construct the html
            for i in sortedSimpleCmds:
                joblines = []
                try:
                    if len(i.name) > 0:
                        menuItemLabel = escape(i.name[0].upper()+i.name[1:])
                    else:
                        menuItemLabel = 'Unnamed jobtype'
                    tocText.append('<li><a href="#%s">%s</a></li>'% (menuItemLabel, menuItemLabel))
                    joblines.append('<h2><a name="%s">%s</a></h2>'% (menuItemLabel, menuItemLabel))
                    joblines.append('<h3>Interface</h3>')
                    joblines.append(i.get_option_help())
                    if len(i.docstring) > 0:
                        joblines.append('<h3>Documentation</h3>')
                        joblines.append(i.docstring)
                    # Scan for README in jobtype dirs
                    for d in jobtypeDirs:
                        readmeFile = '%s/%s/README.txt'%(d, i.name)
                        if os.path.exists(readmeFile):
                            logging.debug("Loading '%s' into docs" % readmeFile)
                            readmeTxt = ''
                            try:
                                f = open(readmeFile, 'r')
                                readmeTxt = f.read()
                                f.close()
                            except IOError:
                                pass
                            if len(readmeTxt) > 0:
                                # Remove header (specified by # as starting character)
                                readmeTxt_lines = readmeTxt.split('\n')
                                for i in xrange(len(readmeTxt_lines)):
                                    if not readmeTxt_lines[i].startswith('#'):
                                        startingLine = i
                                        break
                                readmeTxt = '\n'.join(readmeTxt_lines[startingLine:])
                                # Escape with proper html characters for >, <, etc.
                                readmeTxt = escape(readmeTxt)
                                # replace [SOMEVALUE] with <pre>SOMEVALUE</pre>
                                readmeTxt = re.sub(r'\n\s*\[(.+)\]\s*\n', r'</pre>\n<h4>\1</h4>\n<pre>', readmeTxt)
                                # With Html link to readme: joblines.append('<h3>Readme</h3>\n<a href="file://%s">%s</a><pre>%s</pre>'%(readmeFile, readmeFile, readmeTxt))
                                joblines.append('<h3>Readme</h3>\n<pre>%s</pre>'%readmeTxt) # Without link (better for publishing, standalone)
                            break # Only get the first readme that is come across
                    # Append resulting job lines to overall document lines
                    jobtypeText.append('\n'.join(joblines))
                except:
                    logging.error("Invalid SimpleCmd help. Skipping Help menuitem.")
        # Compose html sections
        htmltext = '''<html>
        <center><h1>Jobtypes Documentation</h1></center>
        <h2>Table of Contents</h2>
        <table><tr>
            <td valign="top"><ul>%s</ul></td>
            <td valign="top"><ul>%s</ul></td>
            <td valign="top"><ul>%s</ul></td>
        </tr></table>
        <hr>
        %s
        </html>
        ''' % ('\n'.join(tocText[:len(tocText)/3]),
               '\n'.join(tocText[len(tocText)/3:len(tocText)/3*2]),
               '\n'.join(tocText[len(tocText)/3*2:]),
               '<hr>\n'.join(jobtypeText))
        
        # Write to temp html file --
        # Determine cache filename for this data
        tempdir = tempfile.gettempdir()
        htmlfilename = '%s/qube-JobtypesHelp.html' % (tempdir)
        # Note: this CacheFile will self-delete when all references to it go away
        self.file_JobtypesHelp = None # to make sure file is deleted if already exists
        self.file_JobtypesHelp = qbCache.CacheFile(htmlfilename, htmltext)
        return self.file_JobtypesHelp.filename


    def menuQubeguiCmdlineOptsCB(self,event):
        '''print out the 'QubeGUI --help' text to a dialog'''
        class TmpBuffer:
            def __init__(self):
                self.value = ''
            def write(self, val):
                self.value += val
        tmpBuf = TmpBuffer()
        #parser.formatter = optparse.TitledHelpFormatter()
        parser.formatter.max_help_position = 10
        parser.formatter.width = 60
        parser.print_help(tmpBuf)
        msgDialog = wx.MessageDialog(self, tmpBuf.value, 'QubeGUI Commandline Options', wx.OK|wx.ICON_INFORMATION)
        msgDialog.ShowModal()
        msgDialog.Destroy()
       

    def menuReportBugCB(self,event):
        # Specify fields to construct email body
        fields = {}
        fields['platform']       = platform.platform()
        fields['qubeClient']     = qb.version()
        fields['qubeSupervisor'] = qb.ping(asDict=True).get('version', 'unknown')
        fields['qubeGUI']        = VERSION_STRING
        fields['python']         = platform.python_version()
        fields['wxPython']       = wx.version()        
        body = '''DESCRIPTION:


STEPS TO REPRODUCE:
1)
2)
...
ACTUAL RESULT:
EXPECTED RESULT:

KNOWN WORKAROUNDS:


SEVERITY: critical, meduim, low

VERSIONS:
    Platform: %(platform)s
    Qube Client %(qubeClient)s
    Qube Supervisor %(qubeSupervisor)s
    Qube GUI %(qubeGUI)s
    Python %(python)s
    wxPython %(wxPython)s
''' % fields

        # use "%0A" for carriage returns as according to spec (on Windows)
        if sys.platform[:3] == 'win': body = body.replace('\n', '%0A')
        
        # Launch webpage to create email
        # Note: see mailto spec described at http://www.ianr.unl.edu/internet/mailto.html for more info on format
        self.launchWebpage('mailto:support@pipelinefx.com?subject=Bug: <summary>&body=%s'%body)


    def menuPrefsCB(self,event):
        origProps =  dict(qbPrefs.preferences).copy()
        dlg = prefsDialog.PrefsDialog(self)
        val = dlg.ShowModal()
        if (val == wx.ID_OK) or (val == wx.ID_NO): # wx.ID_NO indicates here a reset
            # Apply non-default preferences if OK pressed dialog
            if val == wx.ID_OK:
                dlg.ApplySettings()  # update the qbPrefs.preferences

            # get list of changed props
            newProps = dict(qbPrefs.preferences).copy()
            changedProperties = [k for k,v in newProps.items() if origProps.get(k, None) != v]
            logging.debug("Changed properties = %s"%changedProperties)
            
            # Act on changedProperties
            if ('RefreshInterval' in changedProperties) or ('RefreshEnabled' in changedProperties):
                self.adjustRefreshTimer(self.refreshTimer, qbPrefs.preferences.RefreshEnabled, qbPrefs.preferences.RefreshInterval*1000, 'ALL items') # note: converting from seconds to milliseconds

            if ('RefreshSelectedInterval' in changedProperties) or ('RefreshSelectedEnabled' in changedProperties):
                self.adjustRefreshTimer(self.refreshTimer_selected,  qbPrefs.preferences.RefreshSelectedEnabled, qbPrefs.preferences.RefreshSelectedInterval*1000, 'SELECTED items') # note: converting from seconds to milliseconds

            # TODO: These changes should probably be made more object oriented.
            #       Perhaps a PreferencesChangedSignal?
            listWidgets = {
                'JobList_columns'       : self.jobLayout.jobList,
                'JobAgendaList_columns' : self.jobLayout.jobAgendaList,
                'JobWorkerList_columns' : self.jobLayout.jobWorkersList,
                'JobMetaList_columns'   : self.jobLayout.jobMetaList,
                'JobProcessesRunningList_columns' : self.jobProcessesRunningLayout,
                'HostList_columns'      : self.hostLayout.hostList,
            }
            for columnListProp,widget in listWidgets.items():
                if columnListProp in changedProperties:
                    # Get current sort column
                    origSortColName   = widget.columns[widget._col]
                    # Set Column Headers
                    widget.columns = qbPrefs.preferences[columnListProp]
                    widget.SetColumnHeaders()
                    # Find and set sort column
                    try:
                        colIndex = widget.columns.index(origSortColName)
                    except ValueError:
                        colIndex = 0
                    widget._col = colIndex
                    # Refresh
                    widget.RefreshDataMap()

            if 'ListCtrl_rowColorizing' in changedProperties:
                self.Refresh()

            if 'refreshButtonClearsCache' in changedProperties:
                self.toolbar.ApplyToolBar(self.mainLayoutNotebook.GetSelection())

            if ('display_adminMenu' in changedProperties):
                self.setAdminMenuVisibility( qbPrefs.preferences['display_adminMenu'] )

            if ('display_adminLayout' in changedProperties):
                self.setAdminLayoutVisibility( qbPrefs.preferences['display_adminLayout'] )

            if ('display_chartsLayout' in changedProperties):
                self.setChartsLayoutVisibility( qbPrefs.preferences['display_chartsLayout'] )

            if ('display_submitInterfaces' in changedProperties):
                self.populateJobtypeMenus()
                
        # Cleanup
        dlg.Destroy()

    def menuSavePrefsCB(self,event):
        qbSignals.signalGatherPreferences()
        qbPrefs.preferences.save()

    def menuOpenUserPrefsDir(self,event):
        prefsFile = qbPrefs.preferences.getPreferencesFile()
        self.launchWebpage('file://%s'% os.path.dirname(prefsFile))

    def menuSavePrefsAsCB(self,event):
        # Collect constantly adjusting prefs (like panel sizes)
        qbSignals.signalGatherPreferences()
        # Determine file to save as
        filepath = ''
        dlg = wx.FileDialog(
            self, message="Save preference values to:",
            defaultDir=os.getcwd(), 
            defaultFile="qube_guiDefaults.conf",
            wildcard='Configuration File (*.conf)|*.conf|All files (*.*)|*.*',
            style=wx.SAVE
            )
        if dlg.ShowModal() == wx.ID_OK:
            filepath = dlg.GetPath()
        dlg.Destroy()
        if filepath != '':
            qbPrefs.preferences.save(filepath, dictFirst=0, dictLast=2)

    def menuOpenSimpleCmdsDirCB(self,event):
        for i in wx.GetApp().getSimpleCmdPaths():
            self.launchWebpage('file://%s'% os.path.abspath(i))

    def menuOpenAppUIDirCB(self,event):
        self.launchWebpage('file://%s' % wx.GetApp().getAppUIDir())

    def menuInstallSimpleCmdCB(self,event):
        # select simplecmd .py file
        dlg = wx.FileDialog(
            self, message="Select a SimpleCmd to install",
            defaultDir=os.getcwd(), 
            defaultFile="",
            wildcard="Python SimpleCmd (*.py)|*.py",
            style=wx.OPEN | wx.MULTIPLE | wx.CHANGE_DIR
            )
        # get paths from dialog
        filepaths = []
        if dlg.ShowModal() == wx.ID_OK:
            filepaths = dlg.GetPaths()
        dlg.Destroy()
        
        # install
        installedSimpleCmds = []
        if len(filepaths) > 0:
            # copy to simplecmds directory (Q: can we authenticate as root if on OSX)
            simplecmdsDir = os.path.abspath(wx.GetApp().getSimpleCmdPaths()[-1])  # NOTE: Will always have at least 1 path here
            if not os.path.isdir(simplecmdsDir):
                logging.error('Expected simplecmds directory "%s" does not exist. Aborting install.' % simplecmdsDir)
                return
            for p in filepaths:
                logging.info('Installing "%s" to "%s"' % (p, simplecmdsDir))
                if os.path.isfile(p):
                    # check for dstfile existence
                    dstfile = '%s/%s' % (simplecmdsDir, os.path.basename(p))
                    if os.path.isfile(dstfile):
                        # confirm overwrite
                        dlg = wx.MessageDialog(self, 'Destination file "%s" exists. Overwrite?' % dstfile, 'Confirm overwrite',
                               wx.YES_NO | wx.YES_DEFAULT | wx.ICON_QUESTION)
                        dlgResult = dlg.ShowModal()
                        dlg.Destroy()
                        if dlgResult != wx.ID_YES:
                            logging.info('Cancelled overwrite of "%s" .' % dstfile)
                            continue # skip this file
                    # copy
                    result = qbUtils.sudoCopy(p, dstfile)
                    if result == True:
                        installedSimpleCmds.append(dstfile)
                        logging.info('Success. Installed "%s"' % dstfile)
                else:
                    logging.error('Unable to access file "%s". Skipping.' % p)
        if len(installedSimpleCmds) > 0:
            self.menuReloadSimpleCmdsCB(None)

    def menuInstallAppUIModuleCB(self,event):
        # select simplecmd .py file
        dlg = wx.FileDialog(
            self, message="Select an AppUI module to install",
            defaultDir=os.getcwd(), 
            defaultFile="",
            wildcard="Python AppUI (*.py)|*.py",
            style=wx.OPEN
            )
        # get paths from dialog
        filepaths = []
        if dlg.ShowModal() == wx.ID_OK:
            filepaths = dlg.GetPaths()
        dlg.Destroy()

        destPath = None
        if len(filepaths):
            dlg = wx.DirDialog(
                self, message="Select where to install the AppUI module",
                defaultPath=wx.GetApp().getAppUIDir()
            )
            if dlg.ShowModal() == wx.ID_OK:
                destPath = dlg.GetPath()
            dlg.Destroy()
        
        # install
        if len(filepaths) > 0 and destPath:
            # copy to simplecmds directory (Q: can we authenticate as root if on OSX)
            for p in filepaths:
                if os.path.isfile(p):
                    # check for dstfile existence
                    dstfile = '%s/%s' % (destPath, os.path.basename(p))
                    if os.path.isfile(dstfile):
                        # confirm overwrite
                        dlg = wx.MessageDialog(self, 'Destination file "%s" exists. Overwrite?' % dstfile, 'Confirm overwrite',
                               wx.YES_NO | wx.YES_DEFAULT | wx.ICON_QUESTION)
                        dlgResult = dlg.ShowModal()
                        dlg.Destroy()
                        if dlgResult != wx.ID_YES:
                            logging.info('Cancelled overwrite of "%s" .' % dstfile)
                            continue # skip this file
                    # copy
                    result = qbUtils.sudoCopy(p, dstfile)
                    if result == True:
                        logging.info('Installed "%s" --> "%s"' % (p, destPath))
                else:
                    logging.error('Unable to access file "%s". Skipping.' % p)
        else:
            logging.info('AppUI module installation cancelled.')

    def menuReloadSimpleCmdsCB(self,event):
        '''reload all jobtypes and then repopulate the Submit menu'''
        wx.GetApp().loadAllJobtypes(displayLoadMsg=True)
        self.populateJobtypeMenus()

        # Load UI Plugins
        #simplecmdPaths = wx.GetApp().getSimpleCmdPaths()
        #qbPlugins.LoadPlugins(simplecmdPaths, [])



    def menuInstallLicenseCB(self, event):
        dlg = qbUtils.LicenseStrDialog(self, "Enter License Keys", size=(500,500))
        dlg.CenterOnScreen()

        if dlg.ShowModal() == wx.ID_OK:
            licenseStr = dlg.GetTextValue() 
            doConcat = dlg.GetDoConcat()

            if len(licenseStr) == 0:
                logging.warning('No license strings supplied; Qube license file not updated.')
            else:
                (tmpFD, tmpFilePath) = tempfile.mkstemp(prefix='qb_lic.')
                os.write(tmpFD,'\n%s\n' % licenseStr)
                os.close(tmpFD)

                # Copy license from tmpfile
                logging.info("Installing license to '%s'" % qb.QB_SUPERVISOR_CONFIG_DEFAULT_LICENSE_FILE)
                result = qbUtils.sudoCopy(tmpFilePath, qb.QB_SUPERVISOR_CONFIG_DEFAULT_LICENSE_FILE, concat=doConcat)
                os.unlink(tmpFilePath)

                if result:
                    # Update Supervisor license counts (updates title bar)
                    request = qbCache.QbServerRequest(action='supervisorPing')
                    qbCache.QbServerRequestQueue.put(request)
                else:
                    logging.error('License installation failed; Qube license file not updated.')
        else:
            logging.warning('License installation cancelled; Qube license file not updated.')

        dlg.Destroy()


    def menuConfWizardCB(self, event):
        configWizard.createConfigWizard()


    def menuConfDialogCB(self, event):
        confDialog.createConfDialog()


    def menuDisplayConfDialogCB(self, event):
        localconfigDict = qb.localconfig()
        sortedKeys = localconfigDict.keys()
        sortedKeys.sort()
        dlg = wx.lib.dialogs.ScrolledMessageDialog(self,
                                                   '\n'.join(['%-20s: %s'%(k,localconfigDict[k].replace('\n', ' ')) for k in sortedKeys]),
                                                   'Local Configuration',
                                                   style=wx.DEFAULT_DIALOG_STYLE|wx.RESIZE_BORDER,
                                                   size=(640,480))

        # Set fonts to use
        fixedFont = wx.Font(10, wx.MODERN, wx.NORMAL, wx.NORMAL)
        dlg.text.SetFont(fixedFont)
        dlg.ShowModal()
        dlg.Destroy()


    def menuStartSupervisorSvcCB(self, event):
        qbUtils.startSupervisorService()
        if self.menuSupeStatusID != 0:
            self.adminMenu.SetLabel(self.menuSupeStatusID, 'Supervisor: Service Started')


    def menuStopSupervisorCB(self, event):
        if qbUtils.isSupervisorServiceRunning():
            qbUtils.stopSupervisorService()
        if self.menuSupeStatusID != 0:
            self.adminMenu.SetLabel(self.menuSupeStatusID, 'Supervisor: Stopped')


    def menuStartWorkerSvcCB(self, event):
        qbUtils.startWorkerService()
        if self.menuWorkerStatusID != 0:
            self.adminMenu.SetLabel(self.menuWorkerStatusID, 'Worker: Service Started')
        

    def menuStartWorkerProcCB(self, event):
        qbUtils.startWorkerProc()
        if self.menuWorkerStatusID != 0:
            self.adminMenu.SetLabel(self.menuWorkerStatusID, 'Worker: Process (as Desktop User) Started')


    def menuStopWorkerCB(self, event):
        '''stops worker'''
        if qbUtils.isWorkerServiceRunning():
            qbUtils.stopWorkerService()
        elif qbUtils.isLocalWorkerRunning():
            qbUtils.stopWorkerProc()
        else:
            logging.error("No Worker processes to stop.")
        if self.menuWorkerStatusID != 0:
            self.adminMenu.SetLabel(self.menuWorkerStatusID, 'Worker: Stopped')


    def menuSupeAutostart_enableCB(self, event):
        if self.menuAutostartSupervisorID != 0:
            self.adminMenu.SetLabel(self.menuAutostartSupervisorID, 'Autostart Supervisor: Service on Boot')
        qbUtils.serviceAutostart('supervisor', enable=True)


    def menuSupeAutostart_disableCB(self, event):
        if self.menuAutostartSupervisorID != 0:
            self.adminMenu.SetLabel(self.menuAutostartSupervisorID, 'Autostart Supervisor: Disabled')
        qbUtils.serviceAutostart('supervisor', enable=False)


    def menuWorkerAutostart_enableServiceCB(self, event):
        if self.menuAutostartWorkerID != 0:
            self.adminMenu.SetLabel(self.menuAutostartWorkerID, 'Autostart Worker: Service on Boot')
        qbUtils.serviceAutostart('worker', enable=True)
        qbUtils.startupItemAutostart('worker', enable=False)


    def menuWorkerAutostart_enableDesktopCB(self, event):
        if self.menuAutostartWorkerID != 0:
            self.adminMenu.SetLabel(self.menuAutostartWorkerID, 'Autostart Worker: On User Login')
        qbUtils.serviceAutostart('worker', enable=False)
        qbUtils.startupItemAutostart('worker', enable=True)


    def menuWorkerAutostart_disableCB(self, event):
        if self.menuAutostartWorkerID != 0:
            self.adminMenu.SetLabel(self.menuAutostartWorkerID, 'Autostart Worker: Disabled')
        qbUtils.serviceAutostart('worker', enable=False)
        qbUtils.startupItemAutostart('worker', enable=False)


    def menuUpdatePasswordCB(self, event):
        qbloginDialog.createDialog()
        

    def menuPingSupervisorCB(self, event):
        pingResult = qb.ping(asDict=True)
        if len(pingResult):
            pingResult.setdefault('licenses_type', 'unspecified')  # backward compatible with 6.0.1 and earlier API

        if logging.getLogger().getEffectiveLevel() == logging.DEBUG:
            logging.debug('supervisor ping: %s' % str(pingResult))
        elif 'macaddress' in pingResult:
            logging.info('Supervisor MAC address: %(macaddress)s' % pingResult)
        
        try:
            if len(pingResult) > 0:
                # Display dialog with results
                # Example: {'version': '5.3-0', 'licenses_used': '0', 'address': '127.0.0.1', 'licenses': '20', 'os': 'osx', 'build': 'bld-5-3-2008-03-28-3'}
                msgDialog = wx.MessageDialog(None,
                                             ("Licenses: %(licenses_used)s/%(licenses)s (used/total) [per-%(licenses_type)s]\n\n"
                                              "Qube Version: %(version)s\n\n"
                                              "Platform: %(os)s\n\n"
                                              "Build: %(build)s\n\n"
                                              "IP  Address: %(address)s\n\n"
                                              "MAC Address: %(macaddress)s\n\n"
                                              % pingResult),
                                             'Ping Supervisor', wx.OK)
            else:
                msgDialog = wx.MessageDialog(None,
                                             "Unable to contact Qube Supervisor",
                                             'Ping Supervisor', wx.OK|wx.ICON_ERROR)
        except KeyError, e:
            msgDialog = wx.MessageDialog(None,
                                         "Ping data missing one or more values: %s" % e, 
                                         'Ping Supervisor', wx.OK|wx.ICON_ERROR)

        msgDialog.ShowModal()
        msgDialog.Destroy()


    def menuPingWorkerCB(self, event):
        worker = socket.gethostname()
        pingWorkerDialog(worker)


    def menuSupeLogCB(self, event):
        c = qb.localconfig()
        logfile = c.get('supervisor_logfile', qb.QB_SUPERVISOR_CONFIG_DEFAULT_LOGFILE)
        self.launchDocument(logfile, filetype='text')


    def menuWorkerLogCB(self, event):
        c = qb.localconfig()
        logfile = c.get('worker_logfile', qb.QB_WORKER_CONFIG_DEFAULT_LOGFILE)
        self.launchDocument(logfile, filetype='text')

    def menuDatabaseCheckCB(self, repair=False):
        qbUtils.performDatabaseCheck(repair)

    def closeCB(self,event):
        logging.debug( "Closing Qube" )

        # Gather Preferences on exit
        logging.debug('Frame: Gather preferences')
        qbSignals.signalGatherPreferences()
        
        # remove logPanel handling of logging (since it is being destroyed)
        global logPaneHandler
        logPaneHandler.disconnectControls()

        # Close main window
        self.Destroy()            # Destroy window  (or use self.Close(True))

        
    def OnMainLayoutChanged(self, event):
        logging.debug( "In OnMainLayoutChanged id=%i new=%i old=%i" % (event.GetId(), event.GetSelection(), event.GetOldSelection()) )
        if event.GetId() == self.mainLayoutNotebook.GetId():
            selectedLayout = event.GetSelection()
            self.Freeze()  # Freeze/thaw used so that window does not update until toolbar refresh is done
            self.toolbar.ApplyToolBar(selectedLayout)
            self.Thaw()
        event.Skip()


class MyToolBar(wx.ToolBar):
    '''
    '''
    REFRESH_BTN_INTERVAL = 3.0    # refresh buttons are disabled for this interval after being hit
    
    def __init__(self, parent, toolbarIndex=0):
        wx.ToolBar.__init__(self, parent,
                            style= wx.TB_HORIZONTAL
                                 | wx.NO_BORDER
                                 | wx.TB_FLAT
                                 | wx.TB_TEXT
                            )

        self.logging = logging.getLogger(self.__class__.__name__)

        self.toolbarLayouts =  [
                [ self.CreateCtrls_common, self.CreateCtrls_jobLayout,  self.CreateCtrls_commonEnd ],  # jobLayout
                [ self.CreateCtrls_common, self.CreateCtrls_commonEnd ], # jobProcessesRunning
                [ self.CreateCtrls_common, self.CreateCtrls_hostLayout, self.CreateCtrls_commonEnd ], # hostLayout
                [ self.CreateCtrls_common, self.CreateCtrls_commonEnd ], # adminLayout
                [ self.CreateCtrls_common, self.CreateCtrls_commonEnd ], # chartsLayout
            ]
        
        #---------------
        # IDs
        #---------------
        # -- Job Layout --
        # State Show/Hide Toggles
        self.statePendingID  = wx.NewId()  # Pending, Waiting, Suspended, Blocked, BadLogin
        self.stateRunningID  = wx.NewId()  # Running
        self.stateFailedID   = wx.NewId()  # Failed, Unknown
        self.stateKilledID   = wx.NewId()  # Killed
        self.stateCompleteID = wx.NewId()  # Completed
        # Filters
        self.jobSearchButtonID = wx.NewId()
        self.searchFilterID = wx.NewId()
        self.farm_SearchButtonID = wx.NewId()
        self.farm_searchFilterID = wx.NewId()
        self.userToggleID = wx.NewId()
        self.userFilterID = wx.NewId()

        # -- Host Layout --
        # State Show/Hide Toggles
        self.hostRunningID = wx.NewId()  # Running
        self.hostIdleID    = wx.NewId()  # Idle
        self.hostLockedID  = wx.NewId()  # Locked
        self.hostDownID    = wx.NewId()  # Down and Panic

        #---------------
        # Update widgets values
        #---------------
        # Specify relationship between state toggle buttons, preferences, and states
        self.jobStateToggles = {}
        self.jobStateToggles[self.statePendingID]  = ('toolbar_statePending_value' , ['pending', 'waiting', 'suspended', 'blocked', 'badlogin'])
        self.jobStateToggles[self.stateRunningID]  = ('toolbar_stateRunning_value' , ['running'])
        self.jobStateToggles[self.stateFailedID]   = ('toolbar_stateFailed_value'  , ['failed', 'unknown'])
        self.jobStateToggles[self.stateKilledID]   = ('toolbar_stateKilled_value'  , ['killed', 'dying'])
        self.jobStateToggles[self.stateCompleteID] = ('toolbar_stateComplete_value', ['complete'])

        self.hostStateToggles = {}
        self.hostStateToggles[self.hostRunningID] = ('toolbar_hostRunning_value', ['running'])
        self.hostStateToggles[self.hostIdleID]    = ('toolbar_hostIdle_value'   , ['idle'])
        self.hostStateToggles[self.hostLockedID]  = ('toolbar_hostLocked_value' , ['locked'])
        self.hostStateToggles[self.hostDownID]    = ('toolbar_hostDown_value'   , ['down', 'panic'])

        # Update Values
        for (key, (vPref, vStates)) in self.jobStateToggles.items():
            self.enableJobStateFilter(vStates, qbPrefs.preferences[vPref])

        for (key, (vPref, vStates)) in self.hostStateToggles.items():
            self.enableHostStateFilter(vStates, qbPrefs.preferences[vPref])

        self.enableUserFilter(qbPrefs.preferences['toolbar_userToggle_value'],
                              qbPrefs.preferences['toolbar_userFilter_value'])
        
        if qbPrefs.preferences.get('toolbar_searchFilter_value','').startswith('pgrp:'):
            qbPrefs.preferences['toolbar_searchFilter_value'] = ''
        self.enableSearchFilter( qbPrefs.preferences['toolbar_searchFilter_value'] )
        
        self.farm_enableSearchFilter( qbPrefs.preferences['toolbar_farm_searchFilter_value'] )

        #---------------
        # Misc Init for Toolbar
        #---------------
        # Set icon path
        rootdir = os.path.dirname(sys.argv[0])
        rootdir = os.environ['QB_ICONS']
#        if rootdir == '': rootdir = '.'
        self.iconpath = rootdir+'/icons'

        self.SetToolBitmapSize([24,24])
        self.ApplyToolBar(toolbarIndex)

        self.inSearchFilterInit = False  # addresses Windows issue that CB is called when creating widget and sets value = '' (thus clearing it unintentionally)

        self.refreshButtonTimer = qbTimer.QbTimer(timeout=self.REFRESH_BTN_INTERVAL, signal=qbSignals.signalRefreshTimer_expired)

        # -- Connect Signals ---
        qbSignals.signalAction_setSearchFilter.connect(self.setSearchFilterExternally)  # for external panels to set the searchFilter
        qbSignals.signalRefreshTimer_expired.connect(self.toggleRefreshButtons)

    def ApplyToolBar(self, index):
        self.ClearTools()
        for func in self.toolbarLayouts[index]:  func()
        self.Realize()

    def CreateCtrls_common(self):
        # TODO: Busy Throbber for Supervisor requests (like web pages)
        #self.busyAnim = wx.animate.GIFAnimationCtrl(self, -1, self.iconpath+'/One_gear.gif', size=(24,24), style=wx.animate.AN_FIT_ANIMATION)
        #self.busyAnim.GetPlayer().UseBackgroundColour(True)
        #self.busyAnim.Play()
        #self.AddControl(self.busyAnim)

        parent = self.GetParent()
        imageRefresh = wx.Image(self.iconpath+'/view_refresh.png').ConvertToBitmap()
        
        if qbPrefs.preferences['refreshButtonClearsCache']:
            refreshBtnID = parent.menuClearAndRefreshID
        else:
            refreshBtnID = parent.menuRefreshID
        if refreshBtnID != 0:
            self.AddLabelTool(id=refreshBtnID, bitmap=imageRefresh, label="Refresh", shortHelp="Refresh data", longHelp="Refresh data from supervisor")        
            self.Bind(wx.EVT_TOOL, self.OnRefreshBtnPressCB, id=refreshBtnID)

        imageRefreshSel = wx.Image(self.iconpath+'/view_refresh_sel.png').ConvertToBitmap()
        self.AddLabelTool(id=parent.menuRefreshSelID, bitmap=imageRefreshSel, label="Refresh Sel", shortHelp="Refresh selected data", longHelp="Refresh selected data from supervisor")        
        self.Bind(wx.EVT_TOOL, self.OnRefreshBtnPressCB, id=parent.menuRefreshSelID)

        self.AddSeparator()

    def CreateCtrls_commonEnd(self):
        pass


    def CreateCtrls_jobLayout(self):
        # State Show/Hide Toggles --
        if sys.platform == 'darwin':  # need to use 16x16 icons for toggle buttons on OSX, or they do not show up
            imageStateRunning  = wx.Image(self.iconpath+'/queue_running16x16.png').ConvertToBitmap()
            imageStatePending  = wx.Image(self.iconpath+'/queue_pending16x16.png').ConvertToBitmap()
            imageStateFailed   = wx.Image(self.iconpath+'/queue_failed16x16.png').ConvertToBitmap()
            imageStateKilled   = wx.Image(self.iconpath+'/queue_killed16x16.png').ConvertToBitmap()
            imageStateComplete = wx.Image(self.iconpath+'/queue_done16x16.png').ConvertToBitmap()
            imageUserFilter    = wx.Image(self.iconpath+'/queue_myjobs16x16.png').ConvertToBitmap()
        else:
            imageStateRunning  = wx.Image(self.iconpath+'/queue_running.png').ConvertToBitmap()
            imageStatePending  = wx.Image(self.iconpath+'/queue_pending.png').ConvertToBitmap()
            imageStateFailed   = wx.Image(self.iconpath+'/queue_failed.png').ConvertToBitmap()
            imageStateKilled   = wx.Image(self.iconpath+'/queue_killed.png').ConvertToBitmap()
            imageStateComplete = wx.Image(self.iconpath+'/queue_done.png').ConvertToBitmap()
            imageUserFilter    = wx.Image(self.iconpath+'/queue_myjobs.png').ConvertToBitmap()
        
        self.AddCheckLabelTool(id=self.statePendingID , bitmap=imageStatePending , label="Incomplete", shortHelp="Show/hide pending, blocked, badlogin, waiting, suspended jobs", longHelp="Show/hide pending, blocked, badlogin, waiting, and suspended jobs")
        self.AddCheckLabelTool(id=self.stateRunningID , bitmap=imageStateRunning , label="Running", shortHelp="Show/hide running jobs", longHelp="Show/hide running jobs")
        self.AddCheckLabelTool(id=self.stateFailedID  , bitmap=imageStateFailed  , label="Failed" , shortHelp="Show/hide failed and unknown jobs", longHelp="Show/hide failed and unknown jobs")
        self.AddCheckLabelTool(id=self.stateKilledID  , bitmap=imageStateKilled  , label="Killed" , shortHelp="Show/hide killed jobs", longHelp="Show/hide killed jobs")
        self.AddCheckLabelTool(id=self.stateCompleteID, bitmap=imageStateComplete, label="Complete", shortHelp="Show/hide completed jobs", longHelp="Show/hide completed jobs")
        # Set state for state toggles
        for (key, (vPref, vStates)) in self.jobStateToggles.items():
            self.ToggleTool(key, qbPrefs.preferences[vPref])
        self.AddSeparator()

        # User Filter --
        self.AddCheckLabelTool(id=self.userToggleID, bitmap=imageUserFilter, label="User", shortHelp="Filter on user name", longHelp="Toggle filter displayed jobs by specified user")
        self.ToggleTool(self.userToggleID, qbPrefs.preferences['toolbar_userToggle_value'])

        self.inSearchFilterInit = True
        if hasattr(wx, 'SearchCtrl') and sys.platform != 'linux2':        
            self.userFilter = wx.SearchCtrl(self, id=self.userFilterID, value=qbPrefs.preferences['toolbar_userFilter_value'], size=(100, -1), style=wx.TE_PROCESS_ENTER)
            self.userFilter.SetDescriptiveText( "User" )
            updateSearchFilterHistoryMenu('toolbar_userFilter_history', self.userFilter, self.setUserFilterExternally)
            self.Bind(wx.EVT_SEARCHCTRL_SEARCH_BTN      , self.setUserFilterCB   , id=self.userFilterID) 
            self.userFilter.ShowCancelButton( True )
            def userFilterClearCB(event):
                logging.debug( "Clearing User Filter." )
                self.userFilter.SetValue('')
                self.setUserFilterCB(value='')
            self.Bind(wx.EVT_SEARCHCTRL_CANCEL_BTN, userFilterClearCB   , id=self.userFilterID)
            self.userFilter.SetValue(qbPrefs.preferences['toolbar_userFilter_value'])
        else:
            self.userFilter = wx.TextCtrl(self, id=self.userFilterID, value=qbPrefs.preferences['toolbar_userFilter_value'], size=(100, -1), style=wx.TE_PROCESS_ENTER)
        self.userFilter.SetToolTip( wx.ToolTip("Filtering text (* wildcards accepted)"))
        self.userFilter.Enable( qbPrefs.preferences['toolbar_userToggle_value'])
        self.inSearchFilterInit = False
        self.AddControl(self.userFilter)
        # Binding
        self.Bind(wx.EVT_TEXT_ENTER      , self.setUserFilterCB   , id=self.userFilterID)

        # Search Filter --
        # State Show/Hide Toggles
        self.inSearchFilterInit = True
        if hasattr(wx, 'SearchCtrl') and sys.platform != 'linux2':
            self.searchFilter = wx.SearchCtrl(self, id=self.searchFilterID, value=qbPrefs.preferences['toolbar_searchFilter_value'], size=(400, -1), style=wx.TE_PROCESS_ENTER)
            self.searchFilter.ShowCancelButton( True )
            self.searchFilter.SetDescriptiveText( "Search" )
            updateSearchFilterHistoryMenu('toolbar_searchFilter_history', self.searchFilter, self.setSearchFilterExternally)
            self.Bind(wx.EVT_SEARCHCTRL_SEARCH_BTN      , self.setSearchFilterCB   , id=self.searchFilterID)
            def searchFilterClearCB(event):
                logging.debug( "Clearing Job SearchFilter." )
                self.searchFilter.SetValue('')
                self.setSearchFilterCB(value='')
            self.Bind(wx.EVT_SEARCHCTRL_CANCEL_BTN, searchFilterClearCB   , id=self.searchFilterID)
        else:
            if sys.platform == 'darwin':  # need to use 16x16 icons for toggle buttons on OSX, or they do not show up
                imageSearchFilter= wx.Image(self.iconpath+'/view_jobcontrol16x16.png').ConvertToBitmap()
            else:
                imageSearchFilter= wx.Image(self.iconpath+'/view_jobcontrol.png').ConvertToBitmap()
            # Widgets
            self.AddLabelTool(id=self.jobSearchButtonID, bitmap=imageSearchFilter, label="Search", shortHelp="Search jobs for text", longHelp="Toggle filter search text")
            self.EnableTool(self.jobSearchButtonID, False) # just want the "Search" icon and text label.  Not using it as a button.       
            self.searchFilter = wx.TextCtrl(self, id=self.searchFilterID, value=qbPrefs.preferences['toolbar_searchFilter_value'], size=(400, -1), style=wx.TE_PROCESS_ENTER)
            self.searchFilter.SetToolTip( wx.ToolTip("Search text"))
        self.inSearchFilterInit = False
        self.searchFilter.SetValue(qbPrefs.preferences['toolbar_searchFilter_value'])
        self.AddControl(self.searchFilter)
        # Binding
        self.Bind(wx.EVT_TEXT_ENTER      , self.setSearchFilterCB   , id=self.searchFilterID)

        # -- Bindings -----------
        self.Bind(wx.EVT_TOOL      , self.toggleUserFilterCB, id=self.userToggleID)
        self.Bind(wx.EVT_TEXT_ENTER, self.setUserFilterCB   , id=self.userFilterID)

        self.Bind(wx.EVT_TOOL      , self.jobStateToggleCB, id=self.statePendingID)
        self.Bind(wx.EVT_TOOL      , self.jobStateToggleCB, id=self.stateRunningID)
        self.Bind(wx.EVT_TOOL      , self.jobStateToggleCB, id=self.stateFailedID)
        self.Bind(wx.EVT_TOOL      , self.jobStateToggleCB, id=self.stateKilledID)
        self.Bind(wx.EVT_TOOL      , self.jobStateToggleCB, id=self.stateCompleteID)


    def CreateCtrls_hostLayout(self):
        # State Show/Hide Toggles --
        # TODO: Get similar images for running and idle to match style of "down" host
        if sys.platform == 'darwin':  # need to use 16x16 icons for toggle buttons on OSX, or they do not show up
            imageHostRunning    = wx.Image(self.iconpath+'/farm_active16x16.png').ConvertToBitmap()
            imageHostIdle       = wx.Image(self.iconpath+'/farm_all16x16.png').ConvertToBitmap()
            imageHostLocked     = wx.Image(self.iconpath+'/farm_locked16x16.png').ConvertToBitmap()
            imageHostDown       = wx.Image(self.iconpath+'/farm_down16x16.png').ConvertToBitmap()

        else:
            imageHostRunning    = wx.Image(self.iconpath+'/farm_active.png').ConvertToBitmap()
            imageHostIdle       = wx.Image(self.iconpath+'/farm_all.png').ConvertToBitmap()
            imageHostLocked     = wx.Image(self.iconpath+'/farm_locked.png').ConvertToBitmap()
            imageHostDown       = wx.Image(self.iconpath+'/farm_down.png').ConvertToBitmap()
            
        self.AddCheckLabelTool(id=self.hostIdleID   , bitmap=imageHostIdle   , label="Idle"   , shortHelp="Worker idle"            , longHelp="Show/Hide idle workers")
        self.AddCheckLabelTool(id=self.hostRunningID, bitmap=imageHostRunning, label="Running", shortHelp="Worker actively running a job"   , longHelp="Show/Hide workers actively running jobs")
        self.AddCheckLabelTool(id=self.hostLockedID , bitmap=imageHostLocked , label="Locked" , shortHelp="Worker processors all locked"            , longHelp="Show/Hide locked workers")
        self.AddCheckLabelTool(id=self.hostDownID   , bitmap=imageHostDown   , label="Down"   , shortHelp="Worker down or panicked", longHelp="Show/Hide workers that are down, panicked, or unreachable")
        # Set state for state toggles
        for (key, (vPref, vStates)) in self.hostStateToggles.items():
            self.ToggleTool(key, qbPrefs.preferences[vPref])
        self.AddSeparator()

        # Search Filter --
        # State Show/Hide Toggles
        self.inSearchFilterInit = True
        if hasattr(wx, 'SearchCtrl') and sys.platform != 'linux2':
            self.farm_searchFilter = wx.SearchCtrl(self, id=self.farm_searchFilterID, value=qbPrefs.preferences['toolbar_farm_searchFilter_value'], size=(400, -1), style=wx.TE_PROCESS_ENTER)
            self.farm_searchFilter.ShowCancelButton( True )
            self.farm_searchFilter.SetDescriptiveText( "Farm Search" )
            updateSearchFilterHistoryMenu('toolbar_farm_searchFilter_history', self.farm_searchFilter, self.farm_setSearchFilterExternally)
            self.Bind(wx.EVT_SEARCHCTRL_SEARCH_BTN      , self.farm_setSearchFilterCB   , id=self.farm_searchFilterID)
            def searchFilterClearCB(event):
                logging.debug( "Clearing Host SearchFilter." )
                self.farm_searchFilter.SetValue('')
                self.farm_setSearchFilterCB(value='')
            self.Bind(wx.EVT_SEARCHCTRL_CANCEL_BTN, searchFilterClearCB   , id=self.farm_searchFilterID)
        else:
            if sys.platform == 'darwin':  # need to use 16x16 icons for toggle buttons on OSX, or they do not show up
                imageSearchFilter= wx.Image(self.iconpath+'/view_jobcontrol16x16.png').ConvertToBitmap()
            else:
                imageSearchFilter= wx.Image(self.iconpath+'/view_jobcontrol.png').ConvertToBitmap()
            # Widgets
            self.AddLabelTool(id=self.farm_SearchButtonID, bitmap=imageSearchFilter, label="Search", shortHelp="Search Farm Workers for text", longHelp="Toggle filter search text")
            self.EnableTool(self.farm_SearchButtonID, False) # just want the "Search" icon and text label.  Not using it as a button.       
            self.farm_searchFilter = wx.TextCtrl(self, id=self.farm_searchFilterID, value=qbPrefs.preferences['toolbar_farm_searchFilter_value'], size=(400, -1), style=wx.TE_PROCESS_ENTER)
            self.farm_searchFilter.SetToolTip( wx.ToolTip("Search text"))
        self.inSearchFilterInit = False
        self.farm_searchFilter.SetValue(qbPrefs.preferences['toolbar_farm_searchFilter_value'])
        self.AddControl(self.farm_searchFilter)
        # Binding
        self.Bind(wx.EVT_TEXT_ENTER      , self.farm_setSearchFilterCB   , id=self.farm_searchFilterID)

        # -- Bindings --
        self.Bind(wx.EVT_TOOL      , self.hostStateToggleCB, id=self.hostIdleID)
        self.Bind(wx.EVT_TOOL      , self.hostStateToggleCB, id=self.hostRunningID)
        self.Bind(wx.EVT_TOOL      , self.hostStateToggleCB, id=self.hostLockedID)
        self.Bind(wx.EVT_TOOL      , self.hostStateToggleCB, id=self.hostDownID)


    # ---------------
    # CALLBACKS
    # ---------------

    def jobStateToggleCB(self,event):
        (vPref, vStates) =  self.jobStateToggles[event.GetId()]
        if wx.GetKeyState(wx.WXK_SHIFT) == False:            # -- SINGLE TOGGLE INDIVIDUAL BUTTONS
            qbPrefs.preferences[vPref] = event.Checked()
            self.enableJobStateFilter(vStates, qbPrefs.preferences[vPref])
        else:                                                # -- TOGGLE ALL OTHER BUTTONS ON/OFF
            # Determine new state for other toggles
            othersState = True
            for (k, (vP, vS)) in self.jobStateToggles.items():
                if vP != vPref and qbPrefs.preferences[ vP ] == True:
                    othersState = False
                    continue
            # Set states
            qbPrefs.preferences[ vPref ] = True
            for (k, (vP, vS)) in self.jobStateToggles.items():
                if vP != vPref:
                    qbPrefs.preferences[ vP ] = othersState
                self.ToggleTool(k , qbPrefs.preferences[vP])
                self.enableJobStateFilter(vS, qbPrefs.preferences[vP])


    def enableJobStateFilter(self, states, enableFilter):
        logging.debug("In enableJobStateFilter %s %s" % (states, enableFilter) )
        parent = self.GetParent()
        # This list of the 'status' states are for ones to filter out (False)
        for state in states:
            if enableFilter:
                logging.debug("enableJobStateFilter: Display state %s = True (or remove filter key)" % state)
                if parent.jobLayout.jobList.jobFilter.has_key('status'):
                    if parent.jobLayout.jobList.jobFilter['status'].has_key(state):
                        del parent.jobLayout.jobList.jobFilter['status'][state]
                    if len(parent.jobLayout.jobList.jobFilter['status']) == 0:
                        del parent.jobLayout.jobList.jobFilter['status']
                # MetaJob
                if parent.jobLayout.jobMetaList.jobFilter.has_key('status'):
                    if parent.jobLayout.jobMetaList.jobFilter['status'].has_key(state):
                        del parent.jobLayout.jobMetaList.jobFilter['status'][state]
                    if len(parent.jobLayout.jobMetaList.jobFilter['status']) == 0:
                        del parent.jobLayout.jobMetaList.jobFilter['status']
            else:
                logging.debug("enableJobStateFilter: Display state %s = False" % state)
                if not parent.jobLayout.jobList.jobFilter.has_key('status'):
                    parent.jobLayout.jobList.jobFilter['status'] = {}
                parent.jobLayout.jobList.jobFilter['status'][state] = False
                # MetaJob
                if not parent.jobLayout.jobMetaList.jobFilter.has_key('status'):
                    parent.jobLayout.jobMetaList.jobFilter['status'] = {}
                parent.jobLayout.jobMetaList.jobFilter['status'][state] = False

        parent.jobLayout.jobList.RefreshDataMap(-1) # Refresh jobList
        # MetaJob
        parent.jobLayout.jobMetaList.RefreshDataMap() # Refresh jobList


    def toggleUserFilterCB(self, event):
        qbPrefs.preferences['toolbar_userToggle_value'] = event.Checked()
        logging.debug("In toggleUserFilterCB %i", qbPrefs.preferences['toolbar_userToggle_value']) 
        self.userFilter.Enable( qbPrefs.preferences['toolbar_userToggle_value'] )
        # Make sure that the widget value matches that of the prefs setting (in case they did not hit "enter" before)
        if (qbPrefs.preferences['toolbar_userToggle_value'] == True and
            qbPrefs.preferences['toolbar_userFilter_value'] != str(self.userFilter.GetValue()) ):
            self.setUserFilterCB( value=str(self.userFilter.GetValue()) )
        self.enableUserFilter( qbPrefs.preferences['toolbar_userToggle_value'], qbPrefs.preferences['toolbar_userFilter_value'] )

    def setUserFilterExternally(self, filterValue):
        self.userFilter.SetValue(filterValue)
        self.setUserFilterCB(value=filterValue)

    def setUserFilterCB(self, event=None, value=None):
        # Determine value
        if value == None:
            value = str( event.GetString() )
        # Save original filter value in history and create menu
        if value != '':
            updateSearchFilterHistoryMenu('toolbar_userFilter_history', self.userFilter, self.setUserFilterExternally, newValue=value)
        # Set search filter
        qbPrefs.preferences['toolbar_userFilter_value'] = value
        logging.debug("In setUserFilterCB %s", qbPrefs.preferences['toolbar_userFilter_value']) 
        self.enableUserFilter( True, qbPrefs.preferences['toolbar_userFilter_value'] )

    def enableUserFilter(self, enableFilter, filterValue):
        parent = self.GetParent()
        if enableFilter and len(filterValue) > 0 and filterValue != '*':
            logging.debug("enableUserFilter: Filtering user to %s", filterValue)
            # If explicit username, then filter qb.jobinfo() by user [performance benefit]
            if not "*" in filterValue:
                qbCache.jobinfoFilter_requested = {'user': filterValue}
                # If current retrieved cache is not all or the specified user, then update cache
                if qbCache.jobinfoFilter_incache.get('user', '') not in ['', filterValue]:
                    request = qbCache.QbServerRequest(action='jobinfo', value=-1, method='reload') # refresh all jobs
                    qbCache.QbServerRequestQueue.put( request )
            # Filter jobLayout
            parent.jobLayout.jobList.jobFilter['user'] = filterValue
            parent.jobLayout.jobList.RefreshDataMap(-1) # Refresh jobList
            # MetaJob
            parent.jobLayout.jobMetaList.jobFilter['user'] = filterValue
            parent.jobLayout.jobMetaList.RefreshDataMap() # Refresh jobList

        else:
            logging.debug("enableUserFilter: Unfiltering user")
            # Handle cache filtering.  If current jobinfo list in cache is not full list, then retrieve full list
            qbCache.jobinfoFilter_requested = {}
            if qbCache.jobinfoFilter_incache != {}:
                request = qbCache.QbServerRequest(action='jobinfo', value=-1, method='reload') # refresh all jobs
                qbCache.QbServerRequestQueue.put( request )
            if parent.jobLayout.jobList.jobFilter.has_key('user'):
                del parent.jobLayout.jobList.jobFilter['user']
                parent.jobLayout.jobList.RefreshDataMap(-1) # Refresh jobList
            # MetaJob
            if parent.jobLayout.jobMetaList.jobFilter.has_key('user'):
                del parent.jobLayout.jobMetaList.jobFilter['user']
                parent.jobLayout.jobMetaList.RefreshDataMap() # Refresh jobList


    def setSearchFilterExternally(self, filterValue):
        self.searchFilter.SetValue(filterValue)
        self.setSearchFilterCB(value=filterValue)


    def setSearchFilterCB(self, event=None, value=None):
        if self.inSearchFilterInit == False:
            # Determine value
            if value == None:
                value = str( event.GetString() )
            # Save original filter value in history and create menu
            if value != '':
                updateSearchFilterHistoryMenu('toolbar_searchFilter_history', self.searchFilter, self.setSearchFilterExternally, newValue=value)
            # Set search filter
            qbPrefs.preferences['toolbar_searchFilter_value'] = value
            logging.debug("In setSearchFilterCB(value=%s)", repr(qbPrefs.preferences['toolbar_searchFilter_value']))
            self.enableSearchFilter( qbPrefs.preferences['toolbar_searchFilter_value'] )
        else:
            logging.debug("Skipping setSearchFilterCB() execution since in toolbar init")


    def enableSearchFilter(self, filterValue):
        parent = self.GetParent()
        if len(filterValue.strip()) > 0:
            logging.debug("enableSearchFilter: Filtering job search to '%s'", filterValue)
            parent.jobLayout.jobList.searchFilter   = filterValue  
            #parent.jobLayout.jobMetaList.searchFilter   = filterValue  
        else:
            logging.debug("enableSearchFilter: Unfiltering job search")
            parent.jobLayout.jobList.searchFilter = ''
            #parent.jobLayout.jobMetaList.searchFilter = ''
        parent.jobLayout.jobList.RefreshDataMap(-1)     
        #parent.jobLayout.jobMetaList.RefreshDataMap()     


    def farm_setSearchFilterExternally(self, filterValue):
        self.farm_searchFilter.SetValue(filterValue)
        self.farm_setSearchFilterCB(value=filterValue)


    # Farm Search Filter
    def farm_setSearchFilterCB(self, event=None, value=None):
        if self.inSearchFilterInit == False:
            # Determine value
            if value == None:
                value = str( event.GetString() )
            # Save original filter value in history and create menu
            if value != '':
                updateSearchFilterHistoryMenu('toolbar_farm_searchFilter_history', self.farm_searchFilter, self.farm_setSearchFilterExternally, newValue=value)
            # Set search filter
            qbPrefs.preferences['toolbar_farm_searchFilter_value'] = value
            logging.debug("In farm_setSearchFilterCB %s", qbPrefs.preferences['toolbar_farm_searchFilter_value'])
            self.farm_enableSearchFilter( qbPrefs.preferences['toolbar_farm_searchFilter_value'] )
        else:
            logging.debug("Skipping farm_setSearchFilterCB() execution since in toolbar init")


    def farm_enableSearchFilter(self, filterValue):
        parent = self.GetParent()
        if len(filterValue.strip()) > 0:
            logging.debug("farm_enableSearchFilter: Filtering job search to '%s'", filterValue)
            parent.hostLayout.hostList.searchFilter = filterValue
        else:
            logging.debug("farm_enableSearchFilter: Unfiltering job search")
            parent.hostLayout.hostList.searchFilter = ''
        parent.hostLayout.hostList.RefreshDataMap(-1)   
    

    def hostStateToggleCB(self,event):
        (vPref, vStates) =  self.hostStateToggles[event.GetId()]
        if wx.GetKeyState(wx.WXK_SHIFT) == False:            # -- SINGLE TOGGLE INDIVIDUAL BUTTONS
            qbPrefs.preferences[ vPref ] = event.Checked()
            self.enableHostStateFilter(vStates, qbPrefs.preferences[vPref])
        else:                                                # -- TOGGLE ALL OTHER BUTTONS ON/OFF
            # Determine new state for other toggles
            othersState = True
            for (k, (vP, vS)) in self.hostStateToggles.items():
                if vP != vPref and qbPrefs.preferences[ vP ] == True:
                    othersState = False
                    continue
            # Set states
            qbPrefs.preferences[ vPref ] = True
            for (k, (vP, vS)) in self.hostStateToggles.items():
                if vP != vPref:
                    qbPrefs.preferences[ vP ] = othersState
                self.ToggleTool(k , qbPrefs.preferences[vP])
                self.enableHostStateFilter(vS, qbPrefs.preferences[vP])


    def hostIdleCB(self,event):
        qbPrefs.preferences['toolbar_hostIdle_value'] = event.Checked()
        self.enableHostStateFilter(['idle'], qbPrefs.preferences['toolbar_hostIdle_value'])

    def hostRunningCB(self,event):
        qbPrefs.preferences['toolbar_hostRunning_value'] = event.Checked()
        self.enableHostStateFilter(['running'], qbPrefs.preferences['toolbar_hostRunning_value'])

    def hostLockedCB(self,event):
        qbPrefs.preferences['toolbar_hostLocked_value'] = event.Checked()
        self.enableHostStateFilter(['locked'], qbPrefs.preferences['toolbar_hostLocked_value'])

    def hostDownCB(self,event):
        qbPrefs.preferences['toolbar_hostDown_value'] = event.Checked()
        self.enableHostStateFilter(['down', 'panic'], qbPrefs.preferences['toolbar_hostDown_value'])

    def enableHostStateFilter(self, states, enableFilter):
        logging.debug("In enableHostStateFilter %s %s" % (states, enableFilter) )
        parent = self.GetParent()
        # This list of the 'status' states are for ones to filter out (False)
        for state in states:
            if enableFilter:
                logging.debug("enableHostStateFilter: Display state %s = True (or remove filter key)" % state)
                if parent.hostLayout.hostList.hostFilter.has_key('state'):
                    if parent.hostLayout.hostList.hostFilter['state'].has_key(state):
                        del parent.hostLayout.hostList.hostFilter['state'][state]
                    if len(parent.hostLayout.hostList.hostFilter['state']) == 0:
                        del parent.hostLayout.hostList.hostFilter['state']
            else:
                logging.debug("enableHostStateFilter: Display state %s = False" % state)
                if not parent.hostLayout.hostList.hostFilter.has_key('state'):
                    parent.hostLayout.hostList.hostFilter['state'] = {}
                parent.hostLayout.hostList.hostFilter['state'][state] = False
        parent.hostLayout.hostList.RefreshDataMap(-1) # Refresh hostList

    def OnRefreshBtnPressCB(self, evt):
        self.logging.debug('Disabling refresh buttons')
        self.toggleRefreshButtons(False)

        if not (self.refreshButtonTimer.thread and self.refreshButtonTimer.thread.isAlive()):
            self.logging.debug('starting timer by button press')
            self.refreshButtonTimer.start()
        evt.Skip()

    def toggleRefreshButtons(self, enable=True):
        parent = self.GetParent()
        if qbPrefs.preferences['refreshButtonClearsCache']:
            refreshBtnID = parent.menuClearAndRefreshID
        else:
            refreshBtnID = parent.menuRefreshID

        for btnID in [refreshBtnID, parent.menuRefreshSelID]:
            wx.CallAfter(self.EnableTool, id=btnID, enable=enable)


class MySplashScreen(wx.SplashScreen):
    def __init__(self):
        # path is relative to the main script
        rootdir = os.path.dirname(sys.argv[0])
        rootdir = os.environ['QB_ICONS']
        if rootdir == '': rootdir = '.'
        splashImagePath = rootdir+"/icons/splash.png"
        bmp = wx.Image(splashImagePath).ConvertToBitmap()
        wx.SplashScreen.__init__(self, bmp,
                                 wx.SPLASH_CENTRE_ON_SCREEN | wx.SPLASH_TIMEOUT,
                                 3000, None, -1)
        self.Bind(wx.EVT_CLOSE, self.OnClose)
        self.Show()

    def OnClose(self, evt):
        # Make sure the default handler runs too so this window gets destroyed
        evt.Skip()
        self.Hide()

class MyApp(wx.App):
    def __init__(self, showsplash=True, launchGUI=True, savePrefsOnExit=True, startingSupervisor='', serverThreadsNum=1, *args, **kwargs):
        self.showsplash = showsplash
        self.launchGUI  = launchGUI
        self.startingSupervisor = startingSupervisor
        self.serverThreadsNum = serverThreadsNum
        self.savePrefsOnExit = savePrefsOnExit
        wx.App.__init__(self, *args, **kwargs)
        
    def OnInit(self):
        logging.info( "Starting Qube v%s" % VERSION_STRING )
        if (self.showsplash == True):
            splash = MySplashScreen()

        # Kickstart the supervisor request queue for job and host info
        # TODO: Re-add this? Bring up the GUI only after this returns?
        #request = qbCache.QbServerRequest(action='jobinfo', value=-1) # refresh all jobs (kickstart it early)
        #qbCache.QbServerRequestQueue.put( request )

        # Preferences --
        # Load User Preferences (do this first as it may define a studio prefs file used to load studio default prefs)
        qbPrefs.preferences.load()
        
        # Load StudioDefaults Preferences (env variable overwrites user prefs value)
        if os.environ.get('QUBEGUI_DEFAULTPREFS', '') != '':
            qbPrefs.preferences['studioDefaultsPrefsFile'] = os.environ['QUBEGUI_DEFAULTPREFS']
        studioDefaultsPath = qbPrefs.preferences['studioDefaultsPrefsFile']
        # WORKAROUND (Windows python 2.4,2.5):
        #    \\myserver\C$\mydir should not be considered an env variable by expandvars() and expanduser()
        #    handles: '\\\\aaa\\$$bbb$$\\c$\\d\\e\\$fff\\gg$' --> '\\\\aaa\\$$bbb$$\\c$$\\d\\e\\$fff\\gg$$'
        if sys.platform[:3] == 'win' and sys.version_info < (2,6):
            studioDefaultsPath = re.sub(r'([^$])(\$[^a-zA-Z$_]|\$\Z)', r'\1$\2', studioDefaultsPath) # Add a $ before any $ at the end or not followed by a char
        studioDefaultsPath = os.path.expanduser( os.path.expandvars(studioDefaultsPath) )
        if studioDefaultsPath != '':
            if os.path.exists(studioDefaultsPath):
                qbPrefs.preferences.load(studioDefaultsPath, dictIndex=2) # put into studioDefaults dict
            else:
                logging.error("Studio defaults path '%s' does not exist" % studioDefaultsPath)
                
        # Load StudioOverride Preferences (env variable overwrites user prefs value)
        if os.environ.get('QUBEGUI_STUDIOPREFS', '') != '':
            qbPrefs.preferences['studioPrefsFile'] = os.environ['QUBEGUI_STUDIOPREFS']
        studioPrefsPath = qbPrefs.preferences['studioPrefsFile']
        # WORKAROUND (Windows python 2.4,2.5):
        #    \\myserver\C$\mydir should not be considered an env variable by expandvars() and expanduser()
        #    handles: '\\\\aaa\\$$bbb$$\\c$\\d\\e\\$fff\\gg$' --> '\\\\aaa\\$$bbb$$\\c$$\\d\\e\\$fff\\gg$$'
        if sys.platform[:3] == 'win' and sys.version_info < (2,6):
            studioPrefsPath = re.sub(r'([^$])(\$[^a-zA-Z$_]|\$\Z)', r'\1$\2', studioPrefsPath) # Add a $ before any $ at the end or not followed by a char
        studioPrefsPath = os.path.expanduser( os.path.expandvars(studioPrefsPath) )
        if studioPrefsPath != '':
            if os.path.exists(studioPrefsPath):
                qbPrefs.preferences.load(studioPrefsPath, dictIndex=0) # put into studioPrefs (studio overrides) dict
            else:
                logging.error("Studio-wide preferences path '%s' does not exist" % studioPrefsPath)

        # Override username default
        qbPrefs.preferences.factoryDefaults['toolbar_userFilter_value'] = getpass.getuser()
        
        # -- Determine supervisor to use --
        # if supe not specified, then use the one specified in the QubeGUI prefs
        if self.startingSupervisor == None:
            self.startingSupervisor = qbPrefs.preferences['supervisor']
        else:
            self.startingSupervisor = self.startingSupervisor.strip()
            qbPrefs.preferences['supervisor'] = self.startingSupervisor

        # -- set supervisor and clientlogpath --
        clientlogpath = ""
        if self.startingSupervisor != '':
            logging.info("Setting supervisor to %s", self.startingSupervisor)
            qb.setsupervisor(self.startingSupervisor)
            if (self.startingSupervisor == qb.localconfig().get('qb_supervisor', '')):
                pass # qb.setlogpath('')   # Skipping this since logpath override set to "" by default
            else:
                #
                # TODO: Consider adding a client_logpath_map for a map of logpaths 
                #       for multiple supervisors
                #       Store as either a GUI preference or a qb.conf pref.
                #
                qb.setlogpath('USE_SUPERVISOR')
                clientlogpath = 'USE_SUPERVISOR'
    
        # Report on how retrieving stdout/stderr
        if clientlogpath == '':
            qblocalconfig = qb.localconfig()
            clientlogpath = qblocalconfig.get('client_logpath', qblocalconfig.get('supervisor_logpath', ''))
        if clientlogpath in ['', 'USE_SUPERVISOR']:
            logging.info('Job Log stdout/stderr retrieval method is querying Supervisor')
        else:
            logging.info('Job Log stdout/stderr retrieval method is direct file access from "%s"'%clientlogpath)
                    
        # -- Start threads to send/recieve info from supervisor -- 
        self.serverThreads = qbCache.startQbServerRequestThreads(self.serverThreadsNum)

        # Update registered jobtypes and construct submit menu
        self.loadAllJobtypes()

        # Load UI Plugins
        qbPlugins.LoadPlugins(self.getSimpleCmdPaths(), [])

        # -- Launch GUI --
        if self.launchGUI == True:
            # Specify the jobinfo filter before the main window comes up
            #    This allows the jobinfo requests to be filtered up front to just the user if specified [performance enhancement]
            #    TODO: Consider moving these local preferences to the qbPrefs file
            if qbPrefs.preferences.get('toolbar_userToggle_value', False) == True:
                filterValue = qbPrefs.preferences.get('toolbar_userFilter_value', getpass.getuser())
                if len(filterValue) > 0 and not "*" in filterValue:
                    qbCache.jobinfoFilter_requested = {'user': filterValue}
            
            # create the main frame window
            mainWindowSize = qbPrefs.preferences.get('mainWindowSize', (1000,700))
            if isinstance(mainWindowSize, tuple):
                mainWindowSize = wx.Size(*mainWindowSize)
            self.frame = MyFrame(None, wx.NewId(), "Qube %s (contacting supervisor...)"%VERSION_STRING, size=mainWindowSize)
            self.SetTopWindow(self.frame)
            self.frame.Show(True)
            self.frame.Raise()
    
            # Print info on registered SimpleCmds to the log panel
            #for i in self.registeredSimpleCmds:
            #    if hasattr(i, '__file__'):
            #        logging.debug("Added SimpleCmd '%s' from '%s'" % (i.name, i.__file__))
            #    else:
            #        logging.debug("Added SimpleCmd '%s'" % i.name)

        return True
    
    def OnExit(self):
        # Save gathered preferences on exit (if GUI launched)
        if (self.savePrefsOnExit==True):
            qbPrefs.preferences.save()
        logging.debug('Exiting app')
        
        # Close Server Threads
        logging.debug('Closing server query threads')
        for t in self.serverThreads:
            t.join(.01)  # force thread close with a very small timeout


    def getSimpleCmdPaths(self):
        '''Return list of simplecmd paths.  The last one is the default simplecmds/ directory under the executable.
        The paradigm is to have the first named simplecmd be used, with any duplicates ignored.
        '''
        rootdir = os.path.dirname(sys.argv[0])
        if rootdir == '': rootdir = '.'
        simpleCmdPaths = []
        simpleCmdPaths.extend( qbPrefs.preferences['SimpleCmd_additionalPaths'] )  # Add additional paths from prefs
        simpleCmdPaths.append(rootdir+'/simplecmds')                               # Append default simplecmds/ directory
        # WORKAROUND (Windows python 2.4,2.5):
        #    \\myserver\C$\mydir should not be considered an env variable by expandvars() and expanduser()
        #    handles: '\\\\aaa\\$$bbb$$\\c$\\d\\e\\$fff\\gg$' --> '\\\\aaa\\$$bbb$$\\c$$\\d\\e\\$fff\\gg$$'
        if sys.platform[:3] == 'win' and sys.version_info < (2,6):
            simpleCmdPaths = [re.sub(r'([^$])(\$[^a-zA-Z$_]|\$\Z)', r'\1$\2', i) for i in simpleCmdPaths] # Add a $ before any $ at the end or not followed by a char
        simpleCmdPaths = [os.path.expanduser( os.path.expandvars(i) ) for i in simpleCmdPaths] # expand user and vars
        return simpleCmdPaths

    def getAppUIDir(self):
        appUIPath = ''
        
        rootdir = os.path.dirname(sys.argv[0])
        if rootdir == '':
            rootdir = '.'
        
        appUIPath = os.path.join(rootdir, 'AppUI')
        appUIPath = os.path.abspath(appUIPath)

        return appUIPath
        
    def LoadSimpleCmds(self,displayLoadMsg=False):
        ''':Return: list of registered simplecmds.
        ''' 
        registeredSimpleCmds = []
        # -- Hardcoded samples --
        #self.registeredSimpleCmds.append( simplecmd.SimpleCmd('simple1'  , False, 'Maya Batch', 'render') )
        #self.registeredSimpleCmds.append( simplecmd.SimpleCmd('simple2'  , True, 'Maya Batch', 'render') )
        # -- Load ./simplecmds/*.py and call create() --
        simpleCmdPaths = self.getSimpleCmdPaths()
        # Generate list of simplecmds to load
        cmdfiles = []
        for p in simpleCmdPaths:
            cmdfiles.extend( glob.glob(p+'/*.py') )
        for cmdfile in cmdfiles:
            logging.debug("Importing %s." % cmdfile)
            moduleName = os.path.splitext(os.path.basename(cmdfile))[0]
            try:
                module = imp.load_source(moduleName, cmdfile)
                if hasattr(module, 'create'):
                    cmds = module.create()
                    for c in cmds: c.__file__ = os.path.abspath(module.__file__) # add path to file containing the SimpleCmd
                    registeredSimpleCmds.extend( cmds )

                    logMsg = "Registering %s (%s)" % (', '.join(["'%s'"%i.name for i in cmds]), cmdfile)
                    if displayLoadMsg:
                        logging.info(logMsg)
                    else:
                        logging.debug(logMsg)
                else:
                    logging.debug("No create() function in %s for dynamically loading simplecmds"%cmdfile)
            except:
                logging.error("Error importing %s. Skipping. %s" % (cmdfile, str(sys.exc_info())))
                if sys.version_info < (2,4):
                    traceback.print_exc()
                else:
                    logging.error(traceback.format_exc()) # new for python 2.4
        # -- Return --
        return registeredSimpleCmds
    
    
    def loadAllJobtypes(self, displayLoadMsg=False):
        '''statically and dynamically load/register jobtypes'''
        # Member Variables to (re)Populate
        # TODO: check on these 3 member variables for redundant info
        self.registeredSimpleCmds = []
        self.registeredJobs = {}

        # == Update self.registeredSimpleCmds ==
        # Load SimpleCmds (Dynamically Loaded)
        # NOTE: Loaded first so can override the statically loaded SimpleCmds (see below under Remove Duplicates)
        logging.info("SimpleCmd directories: %s" % ([os.path.abspath(i) for i in self.getSimpleCmdPaths() ]))
        self.registeredSimpleCmds.extend( self.LoadSimpleCmds(displayLoadMsg=displayLoadMsg) )

        # Load SimpleCmds (Statically Loaded)
        # NOTE: Do a reload() and then register the SimpleSubmits so can get any changes made
        #       (though not doing this for simplecmd.py)
        # Example: 
        # reload(submit_maya)
        # self.registeredSimpleCmds.extend( submit_maya.create() )
        #
        # <PUT STATICALLY REGISTERED SimpleSubmit/SimpleCmd JOBTYPES HERE>
        #
        self.registeredSimpleCmds.append( simplecmd.create_cmdline() )
        self.registeredSimpleCmds.append( simplecmd.create_cmdrange() )
        
        # Remove Duplicates -- have (dynamic) ones override the static ones
        # Benefit: This allows one to put overriding SimpleSubmit scripts in the simplecmds/ directories
        numOrigRegisteredSimpleCmds = len(self.registeredSimpleCmds)
        tmpUniq = {} # temp variable used below to help with keeping only first unique named simplecmd
        self.registeredSimpleCmds = [tmpUniq.setdefault(i.name,i) for i in self.registeredSimpleCmds if i.name not in tmpUniq]
        if numOrigRegisteredSimpleCmds != len(self.registeredSimpleCmds):
            logging.info("%i duplicate SimpleCmd/SimpleSubmit entries preceeded by earlier entries." % (numOrigRegisteredSimpleCmds-len(self.registeredSimpleCmds)))

        # Sort SimpleCmds
        if sys.version_info < (2,4):
            # 10x slower than using sort keys introduced in python 2.4
            self.registeredSimpleCmds.sort(lambda x,y: cmp(x.name, y.name))
        else:
            self.registeredSimpleCmds.sort(key=lambda x: x.name)
                
        # == Update self.registeredJobs ==
        # Update registeredJobs dict with SimpleSubmits (from the SimpleCmds list)
        for sc in self.registeredSimpleCmds: 
            if (isinstance(sc, simplecmd.SimpleSubmit) and not isinstance(sc, simplecmd.SimpleCmd)):
                self.registeredJobs[sc.name] = {'prototype': sc.prototype, 'fn': simplecmd.simpleSubmit_createSubmitDialog}
        
        # Hack: Backwards compatibility for migen
        if self.registeredJobs.has_key('miGen'): self.registeredJobs['migen'] = self.registeredJobs['miGen']  #HACK! dual entries to get around case-sensitivity problems already in field.


myTrace_rootdir = os.path.dirname(sys.argv[0])
def myTrace(frame, event, arg):
    if True: #event == 'call':
        d = os.path.dirname(frame.f_code.co_filename)
        if True: #d == myTrace_rootdir:
            f = os.path.basename(frame.f_code.co_filename)
            print "TRACE: %s (%s:%i) [%s]"%(frame.f_code.co_name,f,frame.f_lineno, event)
    return myTrace


class WxLog(logging.Handler):
    def __init__(self):
        logging.Handler.__init__(self)
        # setup cache if wx controls not active yet
        self.cache = ''

        # init wx controls
        self.textctrl       = None
        self.statusbarFrame = None
        self.statusbarIndex = 0
        
        # Print out more than just standard message
        #self.setFormatter(logging.Formatter('%(levelname)s: %(message)s (%(threadName)s)'))  # alternately can override self.format(record)

        # add a logging level that doesn't use wx.CallAfter, but prints immediately
        # - useful for operations that require feedback while in progress
        logging.addLevelName(logging.INFO+5, 'INFO-IMMEDIATE')
        logging.addLevelName(logging.WARNING+5, 'WARNING-IMMEDIATE')
        logging.addLevelName(logging.ERROR+5, 'ERROR-IMMEDIATE')

        # Background statusColors
        self.LogLevelBgColorDefault           = wx.Color(255, 255, 255)
        self.LogLevelBgColor = {}
        self.LogLevelBgColor[logging.ERROR]   = wx.Color(255,230,230)
        self.LogLevelBgColor[logging.WARNING] = wx.Color(255,255,128)
        self.LogLevelBgColor[logging.INFO]    = self.LogLevelBgColorDefault
        self.LogLevelBgColor[logging.DEBUG]   = wx.Color(230,230,230)

        self.LogLevelBgColor[logging.ERROR+5]  = self.LogLevelBgColor[logging.ERROR]
        self.LogLevelBgColor[logging.WARNING+5]  = self.LogLevelBgColor[logging.WARNING]
        self.LogLevelBgColor[logging.INFO+5]  = self.LogLevelBgColor[logging.INFO]
        
        # Foreground statusColors
        self.LogLevelFgColorDefault = wx.Color(0,0,0)
        self.LogLevelFgColor = {}
        self.LogLevelFgColor[logging.ERROR]   = wx.Color(220,0,0)
        self.LogLevelFgColor[logging.WARNING] = wx.Color(200,120,0)
        self.LogLevelFgColor[logging.INFO]    = self.LogLevelFgColorDefault
        self.LogLevelFgColor[logging.DEBUG]   = wx.Color(0,0,0)

        self.LogLevelFgColor[logging.ERROR+5]  = self.LogLevelFgColor[logging.ERROR]
        self.LogLevelFgColor[logging.WARNING+5]  = self.LogLevelFgColor[logging.WARNING]
        self.LogLevelFgColor[logging.INFO+5]  = self.LogLevelFgColor[logging.INFO]

    def connectControls(self, textctrl=None, statusbarFrame=None, statusbarIndex=0):
        self.textctrl       = textctrl
        self.statusbarFrame = statusbarFrame
        self.statusbarIndex = statusbarIndex

    def disconnectControls(self):
        self.textctrl       = None
        self.statusbarFrame = None
        self.statusbarIndex = 0
        
    def emit(self, record):
        # Note: using CallAfter to handle multi-threaded cases
        # add to the log window
        if (self.textctrl != None):
            # if there has been any items cached up, then display them now
            if len(self.cache) > 0:
                # Note: just using standard color.  Could preserve record
                wx.CallAfter(self.textctrl.SetDefaultStyle, wx.TextAttr(colText=self.LogLevelFgColorDefault,colBack=self.LogLevelBgColorDefault))
                wx.CallAfter(self.textctrl.AppendText, "\n"+self.cache)
                self.cache = ''  # clear cache

            # Add to textctrl log window
            # Put \n return before so that text is shown on last line in panel
            fgColor = self.LogLevelFgColor.get(record.levelno, self.LogLevelFgColorDefault)
            bgColor = self.LogLevelBgColor.get(record.levelno, self.LogLevelBgColorDefault)

            if logging.getLevelName(record.levelno).endswith('IMMEDIATE'):
                self.textctrl.SetDefaultStyle(wx.TextAttr(colText=fgColor,colBack=bgColor))
                self.textctrl.AppendText("\n" + self.format(record))
                self.textctrl.Update()
            else:
                wx.CallAfter(self.textctrl.SetDefaultStyle, wx.TextAttr(colText=fgColor,colBack=bgColor))
                wx.CallAfter(self.textctrl.AppendText, "\n"+self.format(record))
        else:
            # cache list of items to emit after textctrl is valid
            self.cache += "\n" + self.format(record)
        # add to the status bar
        if (self.statusbarFrame != None) and (record.levelno >= logging.INFO) and not logging.getLevelName(record.levelno).endswith('IMMEDIATE'):
            wx.CallAfter(self.statusbarFrame.SetStatusText, self.format(record), self.statusbarIndex)

# GLOBAL LOG
logPaneHandler = WxLog()



# ----------------------------------------------------------------
# -
# - Main Function
# -
# ----------------------------------------------------------------
if __name__ == '__main__':
    # Parse the command-line options
    parser = optparse.OptionParser(version=VERSION_STRING, conflict_handler="resolve")  # note: adds a --version option
    parser.set_defaults(showsplash=False)

    group = optparse.OptionGroup(parser, 'Startup Actions')
    group.add_option("--splash",   action="store_true", dest="showsplash", help="show splash screen")
    group.add_option("--nosplash", action="store_false", dest="showsplash", help="suppress splash screen")
    group.add_option("--configuration", action="store_true",  dest="configurationDialog", default=False, help="display the configuration dialog")
    group.add_option("--setupwizard"  , action="store_true",  dest="configurationWizard", default=False, help="display the basic setup/configuration wizard")
    parser.add_option_group(group)

    group = optparse.OptionGroup(parser, 'Job Submission')
    group.add_option("--submitJobtype", type="string", dest="submitJobtype", help="launch submission dialog for a specific jobtype or simplecmd (ie. cmdline, cmdrange, maya, etc.)")
    group.add_option("--submitDict"   , type="string", dest="submitDict"   , help="launch submission dialog for a python 'dict' for a job. For example: \"{'prototype':'cmdline', 'package':{'cmdline':'set'}}\"")
    group.add_option("--submitFile"   , type="string", dest="submitFile"   , help="launch submission dialog for a job file (.qja, .xja)")
    group.add_option("--resubmit"     , type="int"   , dest="resubmit"     , help="launch resubmit dialog for a jobid")
    group.add_option("--nogui"        , action="store_false",  dest="showGUI", default=True, help="display interactive GUI and submission dialogs")
    parser.add_option_group(group)

    group = optparse.OptionGroup(parser, 'Configuration Overrides')
    group.add_option("--supervisor", type="string", dest="supervisor", help="explicitly specify the supervisor to use")
    group.add_option("--defaultprefs", type="string", dest="studioDefaults", help="load the studio default prefs (ahead of user prefs).  Also settable with environment variable QUBEGUI_DEFAULTPREFS")
    group.add_option("--studioprefs", type="string", dest="studioPrefs", help="load the studio mandated prefs (after user prefs).  Also settable with environment variable QUBEGUI_STUDIOPREFS")
    group.add_option("--serverthreads", type="int", dest="serverthreads", default=1, help="number of server theads to use")
    group.add_option("--stdout"  , type="string", dest="stdout", help="file redirection for stdout")
    group.add_option("--stderr"  , type="string", dest="stderr", help="file redirection for stderr")
    group.add_option("--jobfilter"  , type="string",  dest="jobFilter", help="explicitly specify the job filter to use")
    group.add_option("--farmfilter"  , type="string",  dest="farmFilter", help="explicitly specify the Farm Worker filter to use")
    parser.add_option_group(group)

    group = optparse.OptionGroup(parser, 'Debugging')
    group.add_option("-d", "--debug", action="store_true", dest="debug", default=False, help="print very verbose debug output")
    group.add_option("-v", "--verbose", action="store_true",  dest="verbose", default=True, help="print verbose output")
    group.add_option("-q", "--quiet"  , action="store_false", dest="verbose", help="suppress verbose output.  Only warnings and errors.")
    group.add_option("--trace", action="store_true", dest="trace", default=False, help="debug trace through all calls")
    parser.add_option_group(group)

    (options, args) = parser.parse_args()

    # Check version requirements
    validVersion = True
    if sys.version_info[:2] < (2,3):
        print ("Invalid python version %s.  Qube GUI requires python 2.3 or greater." % sys.version[:6].rstrip())
        validVersion = False
    if wx.VERSION < (2,6):
        print ("Invalid wxPython version %s. Qube GUI requires wxPython 2.6 or greater." % wx.__version__)
        validVersion = False
    if not validVersion:
        print "Exiting."
        sys.exit(1) # exit with error
        
    # Warning filters
    warnings.filterwarnings(action="ignore", message=".*get/set.*", category=DeprecationWarning)
    warnings.filterwarnings(action="ignore", message=".*QBObject\.__setattr__().*", category=DeprecationWarning)
    warnings.filterwarnings(action="ignore", message=".*__data__.*", category=DeprecationWarning)
    warnings.filterwarnings(action="ignore", message=".*Converting from None to.*", category=DeprecationWarning)
    warnings.filterwarnings(action="ignore", message="Specifying jobinfo.*", category=DeprecationWarning)

    # Set Parameters

    # --- Stdout and stderr ---
    # py2exe Workaround
    #   On windows, discard stdout and stderr by default
    #   This avoids having a qube.exe.log file being created if there is stderr text
    #   If stderr or stdout is desired on windows qube.exe, then please use
    #   the --stdout and --stderr redirect options
    if hasattr(sys, 'frozen') and sys.frozen == 'windows_exe':
        class Blackhole(object):
            softspace = 0
            def write(self, text):
                pass
            def flush(self):
                pass
        sys.stdout = Blackhole()
        sys.stderr = Blackhole()

    # Redirect stdout and stderr if requested
    if options.stdout != None and options.stdout == options.stderr:
        try:
            print("Redirecting stdout and stderr to file '%s'" % options.stdout)
            sys.stdout = file(options.stdout, "w")
            sys.stderr = sys.stdout
        except IOError:
            print("ERROR: Unable to open file '%s' for writing stdout and stderr." % options.stdout)
    else:
        if options.stderr != None:
            try:
                print("Redirecting stderr to file '%s'" % options.stderr)
                sys.stderr = file(options.stderr, "w")
            except IOError:
                print("ERROR: Unable to open file '%s' for writing stderr." % options.stderr)
        if options.stdout != None:
            try:
                print("Redirecting stdout to file '%s'" % options.stdout)
                sys.stdout = file(options.stdout, "w")
            except IOError:
                print("ERROR: Unable to open file '%s' for writing stdout." % options.stdout)

    # --- Set the Root Logger ----
    logStream=None
    # NOTE: logging.basicConfig(*args) only works with python 2.4 and greater
    #if   (options.debug   == True): logging.basicConfig(level=logging.DEBUG, stream=logStream, format='%(levelname)s: %(message)s (%(threadName)s)')
    #elif (options.verbose == True): logging.basicConfig(level=logging.INFO , stream=logStream, format='%(levelname)s: %(message)s')
    # THEREFORE
    # Using the long steps instead (to satisfy Python 2.3)
    loggingLevel = logging.WARNING
    loggingFormat = logging.BASIC_FORMAT
    if (options.debug   == True):
        loggingLevel  = logging.DEBUG
        loggingFormat = '%(name)20s : %(levelname)-8s : %(message)s (%(filename)s:%(lineno)d, %(threadName)s)'
    elif (options.verbose   == True):
        loggingLevel  = logging.INFO
        loggingFormat = '%(levelname)s: %(message)s'
        
    rootLogger = logging.getLogger()
    rootLoggerHdlr = logging.StreamHandler(logStream)
    rootLoggerFmtr = logging.Formatter(loggingFormat, None)
    rootLoggerHdlr.setFormatter(rootLoggerFmtr)
    rootLogger.addHandler(rootLoggerHdlr)
    rootLogger.setLevel(loggingLevel)
    
    # add handler for adding info to wx panels
    rootLogger.addHandler(logPaneHandler)

    #
    # have to call this to initialize the qbUtils.totalTableCount global var
    #
    # if we don't do this in a function, but instead attempt to call qb.query in the top-level of
    # the qbUtils module to initialize the value on startup, qb.query gets imported at startup and
    # the logging gets a duplicate logging.handler which causes all messages to print out twice;
    # I think this is due to the way the qb.query and MySQLdb interact
    #
    qbUtils.getTotalTableCount()

    # If really wanting a LOT of debug info, then turn on tracing
    if   (options.trace   == True): sys.setprofile(myTrace)
    
    if options.studioDefaults:
        os.environ['QUBEGUI_DEFAULTPREFS'] = options.studioDefaults
    
    if options.studioPrefs:
        os.environ['QUBEGUI_STUDIOPREFS'] = options.studioPrefs
    
    logging.info("QubeGUI executable: %s" % (sys.argv[0]))
    
    # -- GUI display options --
    if options.showGUI == False:
        # TODO: Consider refactoring to remove the redundant "showSubmitDialogs" property 
        submit.showSubmitDialogs = False
        simplecmd.showSubmitDialogs = False
        # Note: not saving prefs on exit if GUI not shown
   
    # Start App and enter MainLoop
    if ((options.submitJobtype == None) and
        (options.submitDict    == None) and
        (options.submitFile    == None) and
        (options.resubmit      == None)):
        app = MyApp(redirect=False, showsplash=(options.showsplash and options.showGUI), launchGUI=options.showGUI, savePrefsOnExit=options.showGUI, startingSupervisor=options.supervisor, serverThreadsNum=options.serverthreads)
        if options.jobFilter != None:
            app.frame.GetToolBar().setSearchFilterCB(value=options.jobFilter)
            #qbPrefs.preferences['toolbar_searchFilter_value'] = options.jobFilter
        if options.farmFilter != None:
            app.frame.GetToolBar().farm_setSearchFilterCB(value=options.farmFilter)
            #qbPrefs.preferences['toolbar_farm_searchFilter_value'] = options.farmFilter
        # Optional actions to launch dialogs before hand over main window control to user
        if options.configurationWizard == True:
            configWizard.createConfigWizard()
        if options.configurationDialog == True:
            confDialog.createConfDialog()
        if options.showGUI:
            app.MainLoop()
        else:
            app.OnExit()
    else:
        # Submission dialogs (without main QubeGUI frame)
        # launch app (required by wx)
        app = MyApp(redirect=False, showsplash=False, launchGUI=False, savePrefsOnExit=options.showGUI, startingSupervisor=options.supervisor, serverThreadsNum=options.serverthreads)
        # Get hostinfo request going in case "Browse" buttons are to be used for hosts, clusters, etc.
        if options.showGUI:
            request = qbCache.QbServerRequest(action='hostinfo'   , value='')
            qbCache.QbServerRequestQueue.put( request )
        # Scan submitDict if present
        submitDict = None
        if options.submitDict != None:
            # Note that this may throw an exception
            try:
                submitDict = eval(options.submitDict)
                if not isinstance(submitDict, (dict, qb.Job)):
                    raise "String '%s' not translatable into a dict or qb.Job" % options.submitDict
            except:
                if sys.version_info >= (2,4):
                    excMsg = traceback.format_exc() # new for python 2.4
                else:
                    excMsg = sys.exc_info()[0]
                msgDialog = wx.MessageDialog(None,
                                             'String "%s" not translatable into a dict or qb.Job.\n\n%s'%(options.submitDict, excMsg),
                                             'Submit Error', wx.OK|wx.ICON_ERROR)
                msgDialog.ShowModal()
                msgDialog.Destroy()
                raise
        # Construct job and submit
        if options.submitJobtype != None:
            if app.registeredJobs.has_key(options.submitJobtype):
                submitJob = qb.Job({'prototype':options.submitJobtype})
            elif simplecmd.getSimpleCmd({'prototype':'cmdline', 'package':{'simpleCmdType':options.submitJobtype} }) != None:
                submitJob = qb.Job({'prototype':'cmdline', 'package':{'simpleCmdType':options.submitJobtype} })
            else:
                msgDialog = wx.MessageDialog(None,
                                             'Unable to find jobtype or simplecmd "%s"'%options.submitJobtype,
                                             'Submit Error', wx.OK|wx.ICON_ERROR)
                msgDialog.ShowModal()
                msgDialog.Destroy()
                raise 'Unable to find jobtype or simplecmd "%s"'%options.submitJobtype
            if submitJob.get('name', None) == '': submitJob.pop('name', '')  # WORKAROUND: remove the name so it will take the default value
        elif options.submitFile != None:
            logging.info( "Loading job file %s" % (options.submitFile))
            try:
                assert(os.path.exists(options.submitFile))
                submitJob = qb.recoverjob(options.submitFile)
                if not isinstance(submitJob, (dict, qb.Job)):
                    raise "Unable to load job file %s" % options.submitFile
            except:
                msgDialog = wx.MessageDialog(None, 'Error: %s"'%(sys.exc_info()[0]), 'Submit Error', wx.OK|wx.ICON_ERROR)
                msgDialog.ShowModal()
                msgDialog.Destroy()
                raise
        elif options.resubmit != None:
            try:
                jobs = qb.jobinfo(id=options.resubmit, agenda=True, callbacks=True)
                if len(jobs) == 0: raise "Unable to retrieve jobid %i to resubmit" % options.resubmit
                submitJob = jobs[0]
            except:
                msgDialog = wx.MessageDialog(None, '%s'%(sys.exc_info()[0]), 'Submit Error', wx.OK|wx.ICON_ERROR)
                msgDialog.ShowModal()
                msgDialog.Destroy()
                raise
        elif options.submitDict != None:
            submitJob = submitDict  # use dict parsed above
        else:
            raise 'Unexpected resubmit section.  This code should not be reachable.'
        # Update the job parameters with the override submitDict params (if not just submitDict specified)
        if submitDict != submitJob and submitDict != None:
            submitJob.setdefault('package', {}).update(submitDict.get('package', {}))
            submitDict['package'] = submitJob['package']
            submitJob.update(submitDict)
        submitResults = submit.resubmitFromJob(submitJob)
        # Display dialog with Results
        if len(submitResults) > 0:
            jobids = [str(i['id']) for i in submitResults]
            jobStr = ['Job', 'Jobs'][(len(jobids) > 1)]
            msg = 'Successfully submitted %s %s.'% (jobStr, ','.join(jobids))
            if options.showGUI == True:
                msgDialog = wx.MessageDialog(None, msg, 'Submission Results', wx.OK|wx.ICON_INFORMATION)
                msgDialog.ShowModal()
                msgDialog.Destroy()
        # exit app (called manually since mainloop not called for just the dialog)
        # NOTE: Only calling app.OnExit() if GUI shown since it is causing a Bus Error.  No error given if not called w/ no gui shown.
        #       Not sure exactly why
        # NOTE: "Bus" error again.  Not sure why.  May want to try a mainloop with a CallAfter() to close it
        if options.showGUI == True: 
            app.OnExit()

    # Clear Cache
    #    Do this after the mainloop has exited so that all widgets that could
    #    be using the cache are already closed
    #    NOTE: It does not seem that there are any logging implications of this being called
    #          After the widgets are destroyed
    qbCache.jobInfos.clear()
    qbCache.jobDetails.clear()  # when jobDetails clears, it will cause all CacheFiles it is using to clean up and delete themselves
    qbCache.hostInfos.clear()

    # Linux pyinstaller exe: Remove symlink to simplecmds/ so not removed when temp _MEI*/ dir removed 
    if hasattr(sys, 'frozen') and sys.platform[:5] == 'linux' and os.environ.has_key('_MEIPASS2'): # matches linux* and is --onefile exe
        simplecmdsDir = os.environ['_MEIPASS2']+"simplecmds"
        if os.path.exists(simplecmdsDir):
            os.unlink(simplecmdsDir)
            
