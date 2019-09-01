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


class unreal(baseApp):

    def environ(self):
        pass

    def license(self):
        pass

    def bins(self):
        return [
            ('unreal', 'Engine/Binaries/Linux/UE4Editor -USEALLAVAILABLECORES')
        ]

    def userSetup(self, jobuser):
        self['HOME'] = jobuser.path('unreal')
        if not os.path.exists( jobuser.path('unreal/.confg') ):
            jobuser.mkdir( 'unreal' )
            jobuser.mkdir( 'unreal/.config/' )
            jobuser.mkdir( 'unreal/.config/Epic/' )
            jobuser.create()

            USER = pipe.admin.username()
            PROD = jobuser.path('../../../../PRODUCAO')

            # checkout default from git repository
            if not os.path.exists( "%s/git_%s" % (PROD, USER) ):
                os.system( 'git clone "%s/git" "%s/git_%s"' % (PROD, PROD, USER) )

            # # create main projet folder
            # if not os.path.exists( jobuser.path('unreal/Unreal Projects/mainProject/Content') ):
            #     os.system( 'mkdir -p "%s"' % jobuser.path('unreal/Unreal Projects/mainProject/Content') )

            if not os.path.exists( jobuser.path('unreal/Unreal Projects/mainProject') ):
                os.system( 'ln -s "../../../../../../PRODUCAO/git_%s" "%s" ' %  (
                    pipe.admin.username(),
                    jobuser.path('unreal/Unreal Projects/mainProject')
                ) )

            os.system( 'cd "%s" ; git push ; git merge ; git checkout' % jobuser.path('unreal/Unreal Projects/mainProject/') )

            # from glob import glob
            #

            # from glob import glob
            # for each in glob( os.path.abspath( jobuser.path('../../../../ARTWORKS/*ZIP*/*.zip') ) ):
            #     project = jobuser.path( 'unreal/Unreal Projects/mainProject/Content/%s' % os.path.basename( each ) )
            #     done = project+".decompressed"
            #
            #     folders1 = [ x for x in glob( "%s/unreal/Unreal Projects/*" % jobuser.path() ) if os.path.isdir(x) ]
            #
            #     if not os.path.exists( done ):
            #         print "Decompressing %s... " % each
            #         os.system( 'cd "%s/unreal/Unreal Projects/mainProject/Content/" ; unzip -o "%s" > "%s"' % ( jobuser.path(), each, done ) )
            #         folders1 = [ x for x in glob( "%s/unreal/Unreal Projects/*" % jobuser.path() ) if os.path.isdir(x) and x not in folders1 ]
            #
            #
            # # create uproject file
            # folders = [ x for x in glob( "%s/*" % jobuser.path('unreal/Unreal Projects/') ) if os.path.isdir(x) ]
            # def fixPath( folders ):
            #     for each in folders:
            #         original = each
            #         # cleanup weird chars from the folder names
            #         cont = True
            #         cleanup = ', []{}()\?@#$%^&*!~<>'
            #         while ( cont ):
            #             each = each.rstrip('/').strip('_')
            #             beach = os.path.basename(each)
            #             deach = os.path.dirname(each)
            #             cont = False
            #             for c in cleanup:
            #                 if c in beach:
            #                     cont = True
            #                     each = deach + '/' + beach.replace(c,"_").replace("__","_").strip('_')
            #
            #         if not os.path.exists( each ):
            #             os.system( 'mv "%s" "%s"' % (original, each) )
            #
            #         # recurse into folders to fix everything
            #         if os.path.isdir( each ):
            #             fixPath( glob( each+"/*" ) )
            #
            # fixPath(folders)

            # create project if none exists
            from glob import glob
            folders = [ x for x in glob( "%s/*" % jobuser.path('unreal/Unreal Projects/') ) if os.path.isdir(x) ]
            for each in folders:
                projectName = "%s/%s.uproject" % ( each, os.path.basename( each ) )
                if not os.path.exists( projectName ):
                    print ( "Creating missing project: ",projectName )
                    f = open(projectName,'w')
                    f.write('''
                    {
                    	"FileVersion": 3,
                    	"EngineAssociation": "{1169EDF2-08D6-C2A3-9675-F58612060840}",
                    	"Category": "",
                    	"Description": "",
                    	"Plugins": [
                    		{
                    			"Name": "PythonScriptPlugin",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "Takes",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "VirtualCamera",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "ApexDestruction",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "ChaosCloth",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "ChaosSolverPlugin",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "CodeEditor",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "ImagePlate",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "OpenColorIO",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "SequencerScripting",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "EditorScriptingUtilities",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "PerforceSourceControl",
                    			"Enabled": false
                    		},
                    		{
                    			"Name": "ScriptPlugin",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "BlankPlugin",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "LensDistortion",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "Composure",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "OpenCVLensDistortion",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "BlueprintMaterialTextureNodes",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "BlueprintStats",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "ControlRig",
                    			"Enabled": true
                    		},
                    		{
                    			"Name": "LiveLink",
                    			"Enabled": true
                    		}
                    	]
                    }
                    ''')
                    f.close()
