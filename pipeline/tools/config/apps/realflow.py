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

class realflow(baseApp):
    def environ(self):
        self.p=python()
        self.update(cortex())
        self.update(gaffer())
        self['PYTHONHOME'] = self.p.path()
        self['PYTHONPATH'] = self.p.path('lib/python$PYTHON_VERSION_MAJOR')
        self['LD_PRELOAD'] = self.p.path('lib/libpython$PYTHON_VERSION_MAJOR.so.1.0')
        self['LD_PRELOAD'] = '/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/pyside/1.1.2/lib/libpyside-python$PYTHON_VERSION_MAJOR.so.1.1'
        self['RF_2012_PATH'] = self.path()



    def bins(self):
        ret = [('realflow', 'realflow.bin')]
        if float( self.version() ) >= 2015:
            ret = [('realflow', 'realflow')]
        return ret

    def license(self):
        # install license for the current machine
        import os
#        mac = getMacAddress()
#        self['RV_LICENSE_FILE'] = "/tmp/rv_license_%s.txt" % os.environ['USER']
#        os.system( "%s/licensegen -m %s %s 2>&1 1>/dev/null" % (self.path(), mac, self['RV_LICENSE_FILE']) )

        dir = '%s/.config/Next Limit Technologies' % os.environ['HOME']
        if not os.path.exists(dir):
            os.makedirs(dir)
        file = '%s/RealFlow2012.conf' % dir
        if os.path.exists(file):
            os.remove(file)
        f = open( file, 'w' )
        f.write('''
[Licenses]
RF_2012_GUI\License%200\Product=RF_2012_GUI
RF_2012_GUI\License%200\Type=STANDARD
RF_2012_GUI\License%200\Key=931307CC56927C8A88F52F8156CD8A6E992C82B8CBDADB01E40BDAA34074F2B68208818AE325584C76AC12FCA1538C77A89CFEFBA81B8C17E7C18BEC2C951070
RF_2012_GUI\License%200\Name=MIKEPARADOX
RF_2012_GUI\License%200\Organization=MIKEPARADOX 2011
RF_2012_GUI\License%200\NumNodes=666
RF_2012_GUI\License%200\Issue=04072011
RF_2012_GUI\License%200\Valid=
RF_2012_GUI\License%200\Code=1372706997
''')
        f.close()
        self['nextlimit_LICENSE']=os.environ['PIPE_REALFLOW_LICENSE']


    def userSetup(self, jobuser):
        self['RFSCENESPATH'] = jobuser.path('realflow/')
        os.chdir( jobuser.path('realflow/')  )


    def bin(self):
        return "env LD_LIBRARY_PATH=%s:$LD_LIBRARY_PATH  %s" % (
            self.p.path('lib/python$PYTHON_VERSION_MAJOR/lib-dynload'), self.path('bin') )
