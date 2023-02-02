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

##########################################################################
#
#  Copyright (c) 2007-2010, Image Engine Design Inc. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of Image Engine Design nor the names of any
#       other contributors to this software may be used to endorse or
#       promote products derived from this software without specific prior
#       written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

from IECore import Op, Parameter, StringVectorData, BoolData, StringParameter, ValidatedStringParameter
from IECore import BoolParameter, CompoundParameter, registerRunTimeTyped, IntData, StringData
from IECore import CompoundObject, IntParameter, DateTimeParameter, StringVectorParameter
from glob import glob
import os, datetime, sys
import pipe
try:
    import clients
except:
    clients = None



class mkjob( Op ) :

    def getLastIndex(self):
        ''' go over the filesystem jobs and gather the last project
        index available'''
        # old pipe index - remove after we have new pipe projs
#        lastProjectOld = 0
#        s = pipe.admin.sudo()
#        s.cmd("ls -l /mnt/Projetos/ | while read line ; do echo $line | grep -v total | rev | cut -d' ' -f1 | rev | cut -d_ -f1 | egrep '[0-9]' ; done | sort -u | tail -1")
#        result = s.run()
#        if result:
#            lastProjectOld = int(result[0])

        lastProjectOld = 0
        jobList = glob( "/mnt/Projetos/*"  )
        jobList = map( lambda x: os.path.basename(x), jobList )
        jobList = [ x for x in jobList if x[0].isdigit() ]
        jobList.sort()
        if jobList:
            lastProjectOld = int(jobList[-1].split('_')[0].split('.')[0])


        lastProject = 0
        jobList = glob( "%s/*" % pipe.roots.jobs() )
        jobList = map( lambda x: os.path.basename(x), jobList )
        jobList = [ x for x in jobList if x[0].isdigit() and int(x.split('.')[0]) < 9000 ]
        jobList.sort()
        if jobList:
            lastProject = int(jobList[-1].split('_')[0].split('.')[0])

        if lastProjectOld > lastProject:
            lastProject = lastProjectOld

        return lastProject

    def __init__( self ) :
        Op.__init__( self, "Create new projects.",
            Parameter(
                name = "result",
                description = "",
                defaultValue = StringData(),
                userData = {
                        "UI" : {
                            "showResult": BoolData( True ),
                        },
                    },
            )
        )

        clients_preset = ("no client")
        if clients:
            clients_preset = clients.asPreset()


        output = pipe.output()
        self.parameters().addParameters(
            [
                IntParameter(
                    name="jobIndex",
                    description = "O Indice do Projeto.",
                    defaultValue = self.getLastIndex()+1,
                ),
                ValidatedStringParameter(
                    name="jobName",
                    description = "The name of the job to be created/edited",
                    defaultValue = "",
                    regex = r'^\S+$',
                    regexDescription = "jobName must be a name without any spaces in it.",
                    allowEmptyString = False,
                ),
                StringParameter(
                    name="client",
                    description = "",
                    defaultValue = "no client",
                    # presets = clients_preset,
                    # presetsOnly = True,
                ),
                StringParameter(
                    name="defaultOutput",
                    description = "The default resolution for the project.",
                    defaultValue = output.labels()[0],
                    presets = output.asPreset(),
                    presetsOnly = True,
                ),

                StringVectorParameter(
                    name = "assets",
                    description = "Input the assets for the project."
                                  "To add, click once on the + sign."
                                  "To quickly add more lines, press space after clicking the + sign."
                                  "To remove select the lines and click on the - sign.",
                    defaultValue = StringVectorData( [''] ),
                ),
                StringVectorParameter(
                    name = "shots",
                    description = "Input the shots for the project."
                                  "To add, click once on the + sign."
                                  "To quickly add more lines, press space after clicking the + sign."
                                  "To remove select the lines and click on the - sign.",
                    defaultValue = StringVectorData( [''] ),
                ),
            ])

    def doOperation( self, operands ) :

        job = pipe.admin.job( operands["jobIndex"].value, operands["jobName"].value )
        job.mkroot()

        for each in  operands["shots"]:
            if each:
                job.mkshot( "shots/%s" % each )

        for each in  operands["assets"]:
            if each:
                job.mkshot( "assets/%s" % each )

        job.client( operands["client"].value )
        job.data( {
            'output' : operands["defaultOutput"].value,
        } )

        result = job.create()
        print( result )

        return StringData( result )

registerRunTimeTyped( mkjob )
