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

class chrome(baseApp):
    def environ(self):
        if os.popen('cat /proc/version | egrep "Debian|Ubuntu"').readlines():
            pipe.version.set( chrome = 'beta' )
            self.debian = True
   
    def bins(self):
        return [('chrome', 'chrome')]    
        
    def run(self, app):
        ba = baseApp(self.className)
        
        pipe.libs.version.set(freetype = "don't use pipe freetype!")
        
        # fix if we have a dead singletonLock
        import os
        singletonLock = "%s/.config/google-chrome/SingletonLock" % os.environ["HOME"] 
        if os.path.exists(singletonLock):
            singletonLock_host = ''.join( os.popen("echo $(readlink %s | sed 's/.local/@/' | cut -d'@' -f1).local" % singletonLock).readlines()).strip()
            if singletonLock_host:
                hostname = ''.join( os.popen("hostname").readlines()).strip()
                if singletonLock_host != hostname:
    #                dead = os.popen(" ping -c 1 $(readlink %s | sed 's/.local/@/' | cut -d'@' -f1).local 2>&1 | grep unknown").readlines()
    #                if dead:
                        os.remove( singletonLock )
            
        # grab extra options for chrome from env var
        extraOptions = ""
        if os.environ.has_key('PIPE_PROXY_SERVER'):
            extraOptions = '--proxy-server=%s  --proxy-bypass-list="*.local;127.0.0.1;localhost"' % os.environ['PIPE_PROXY_SERVER'] 
            
        
        if self.osx:
            ba.run( '"../Google Chrome.app/Contents/MacOS/Google Chrome" --enable-plugins --ui-enable-threaded-compositing --ui-disable-partial-swap --use-gl --canvas-msaa-sample-count=0 --disable-gpu-vsync --disable-gpu-watchdog --enable-gpu-rasterization --enable-prune-gpu-command-buffers  --enable-threaded-compositing --enable-nacl  --enable-map-image %s' % extraOptions)
        else:
            # to run without sandbox, we need the chrome-sandbox
            # in /opt/google/chrome/chrome-sandbox, and it must be 
            # owned by root, with chmod 4755
            if os.path.exists('/opt/google/chrome/chrome-sandbox'):
                if not hasattr( self, 'debian'):
                    ba.run( 'chrome --enable-plugins --ui-enable-threaded-compositing --ui-disable-partial-swap --use-gl --canvas-msaa-sample-count=0 --disable-gpu-vsync --disable-gpu-watchdog --enable-gpu-rasterization --enable-prune-gpu-command-buffers  --enable-threaded-compositing --enable-nacl  --enable-map-image %s' % extraOptions)
                else:
                    ba.run( 'chrome --enable-plugins  %s' % extraOptions)                    
            else:
                ba.run( 'chrome --no-sandbox  --enable-plugins %s'  % extraOptions )
                                      


