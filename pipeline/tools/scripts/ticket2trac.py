#!/usr/bin/env python

##
#
# Copyright 2009 Rickard Lindroth, Singbox AB All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
#
#   1. Redistributions of source code must retain the above copyright notice, this list of
#      conditions and the following disclaimer.
#
#   2. Redistributions in binary form must reproduce the above copyright notice, this list
#      of conditions and the following disclaimer in the documentation and/or other materials
#      provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY SINGBOX AB ``AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SINGBOX AB OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are those of the
# authors and should not be interpreted as representing official policies, either expressed
# or implied, of Singbox AB.
#
#
# ticket2trac:
# a small script for adding tickets to Trac from command line.
#
# Author:
#
# Rickard Lindroth, Singbox AB
# http://www.singbox.com
# info@singbox.com
# 
##

from optparse import OptionParser
import sys

from trac.env import open_environment
from trac.ticket import Ticket
from trac.ticket.api import TicketSystem
from trac.ticket.notification import TicketNotifyEmail

class Ticket2Trac():
    """ A Class for adding a ticket to trac """
    
    def main(self, args=sys.argv[1:]):
        
        options, remaining_args = self.parse(args)
        trac_env = self.getProjectEnv(remaining_args[0])
        ticket_fields = self.getTicketFields(options)
        ticket, ticket_number = self.createTicket(ticket_fields, trac_env)
        
        if ticket_number:    
            self.postCreate(ticket,trac_env)
            print "Ticket number #%d created" % ticket_number
            sys.exit(0)
        else:
            print "Failed to create ticket"
            sys.exit(1)
        
    
    def parse(self, cli_args):
        """ 
        This function parses the command line parameters.
        
        Keyword arguments:
        cli_args -- This is an array with the command line arguments (ARGV)
         
        Returns: 
        options object and a array with the remaining command line options.
        """
        
        usage = "usage: %prog [options] [trac install path] [ticket summary]"
        parser = OptionParser(usage=usage)
        
        parser.add_option('-r', '--reporter', dest='reporter', help='The author of the ticket.')
        
        parser.add_option('-t','--type', dest='type', 
                          help='The nature of the ticket (for example, defect or enhancement request)')
        
        parser.add_option('-c', '--component', dest='component', 
                          help='The project module or subsystem this ticket concerns.')
        
        parser.add_option('-v', '--version', dest='version', 
                          help='Version of the project that this ticket pertains to.')
        
        parser.add_option('--keyword', dest='keywords',
                          help='Keywords that a ticket is marked with. Useful for searching and report generation.')
        
        parser.add_option('--priority', dest='priority',
                          help='The importance of this issue, ranging from trivial to blocker')
        
        parser.add_option('-m', '--milestone', dest='milestone', 
                          help='When this issue should be resolved at the latest.')

        parser.add_option('-o', '--owner', dest='owner',
                          help='Principal person responsible for handling the issue.')
        
        parser.add_option('-x', '--cc', dest='cc',
                          help='Email carbon copies to this users or email-addresses.')
        
        parser.add_option('-s', '--status', dest='status', default = 'new',
                          help='What is the current status? One of new, assigned, closed, reopened. default is "new"')
        
        parser.add_option('-d', '--description', dest='description',
                          help='The body of the ticket. A good description should be specific, descriptive and to the point.')
        
        parser.add_option('-p', '--project', dest='project', help='projects to apply to')
        
        options, args = parser.parse_args(cli_args)
        if len(args) != 2:
            parser.error("incorrect number of arguments, use -h for help")
        
        #Add summary to the options so that it gets passed to the ticket later.
        options.summary = args[1]
        
        return options, args

   
    def getTicketFields(self, options):
        """ 
        This function creates a dictionary out of the options object
        All fields with None as value is removed so that we don't 
        write over default parameters in the ticket from the ini file.
        
        Keyword arguments: 
        options -- The object returned from the parser.
        
        Returns: 
        A dictionary with all ticket fields as set by the user.
        """
        
        # Well we didn't need to do any clever stuff.
        # Just return options as a dict.
        fields = options.__dict__
        
        # Remove all fields with None as value, or they will
        # overwrite default values.
        for field, value in fields.items():
            if value is None:
                del fields[field]
        
        return fields 
        
    
    def getProjectEnv(self, path):
        """
        This function gets the trac environment from a given path.
        
        Keyword arguments: 
        path -- This is the path to the trac installation. 
        
        Returns:
        A trac environments object. 
        """
        
        env = None
        
        try:
            env = open_environment(path)
        except Exception, e:
            print "First argument must be a valid trac path. The directory where you installed trac.", e
            sys.exit(1)

        return env
        
    
    def createTicket(self, ticket_fields, env):
        """
        Creates the ticket in trac.
        
        Keyword arguments:
        ticket_fields -- A dictionary with the ticket fields.
        
        Returns: 
        The ticket number.
        """
        
        ticket = Ticket(env)
        
        # Lets populate the ticket with our fields.
        # The ticket has already set all default values for us from trac.ini
        # in it's init, nice huh. 
        # Don't write to ticket.values[] unless you know what you are doing
        ticket.populate(ticket_fields)
        
        
        # create the ticket
        ticket_number = ticket.insert()

        return ticket, ticket_number

    def postCreate(self, ticket, env):
        """ Does things after creating a ticket """

        # Send notify emails
        tn = TicketNotifyEmail(env)
        tn.notify(ticket)


if __name__ == '__main__':
    ticket2Trac = Ticket2Trac()
    ticket2Trac.main()
