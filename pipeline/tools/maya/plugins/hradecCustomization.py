import os, socket, sys, threading
import time
try:
    import maya
    import maya.OpenMayaMPx as OpenMayaMPx
    import maya.OpenMaya as mo
    import maya.cmds as m
    import maya.utils as mutils
    import maya.cmds as m
    from maya.mel import eval as meval
    m.h=None
except: 
    maya = False

try: 
    import rad
    cgfxDevTools = '%s%stools/bin/cgfxDevTools/' % (rad.depotRoot, rad.atgRoot)
    editra = 'editra.cmd'
except: 
    rad = None
    cgfxDevTools = os.getcwd()
    editra = 'editra.cmd'



    
class msocket():
    def __init__(self, address='localhost', port=24000):
        if address=='localhost':
            address='127.0.0.1' #socket.gethostbyname(socket.gethostname())
        self.url = (address, port)
        self.__socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
    def maya_commandPort_bind(self):
        if maya:
            url = '%s:%d' % self.url
            print "opening command port on url %s" % url
            sys.stdout.flush()
            if not m.commandPort(url,q=1):
                m.commandPort(n=url)
                
    def bind(self):
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server_socket.setblocking(1)
        self.server_socket.bind(self.url)
        self.server_socket.listen(1)
        class msocketServerThread ( threading.Thread ):
            def setParent(self, parent):
                self.parent = parent
            def run ( self ):
                client_socket, address = self.parent.server_socket.accept()
                data = client_socket.recv(2048).strip()
                def runScriptJobMel():
                    from maya.mel import eval as meval
                    try:
                        result = meval(data)
                    except Exception, msg:
                        result = msg
                    print result
                    client_socket.send(str(result))
                    client_socket.recv(15).strip()
                    self.parent.msocketServer =  msocketServerThread()
                    self.parent.msocketServer.setParent(self.parent)
                    self.parent.msocketServer.start()
                def runScriptJob():
                    m.scriptJob( runOnce=True,  idleEvent=runScriptJobMel )
                result = mutils.executeInMainThreadWithResult( runScriptJob )

        self.msocketServer =  msocketServerThread()
        self.msocketServer.setParent(self)
        self.msocketServer.start()

    def close(self):
        try:self.__socket.shutdown(socket.SHUT_RDWR)
        except:pass
        if not maya:
            try:self.server_socket.shutdown(socket.SHUT_RDWR)
            except:pass
        else:
            self.server_socket.shutdown(socket.SHUT_RDWR)
            
    def __refreshConnection(self, Exception, msg):
        CONNECTED = 10056
        RESETBYPEER = 10054
        NOTCONNECTED = 10057
        REFUSED = 10061
        if msg[0] in [CONNECTED]:
            pass
            #self.__socket.shutdown(socket.SHUT_RDWR)
        elif msg[0] in [RESETBYPEER, NOTCONNECTED, 10053]:
            self.connect()
        else:
            raise Exception( str(msg) + ' ' + str(self.url) )
            
    def connect(self, timeout=0):
        if timeout>10:
            raise Exception ('Tried to connect but couldnt find the server.')
        
        del self.__socket 
        self.__socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            self.__socket.setblocking(1.0)
            self.__socket.connect(self.url)
        except Exception, msg:
            self.__refreshConnection(Exception, msg)
        #self.mel("global float $refreshing;$refreshing=%s" % time.time() )
        
    def send(self,cmd, timeout=0):
        try:
            self.__socket.send('%s\n' % cmd)
            self.__socket.shutdown(1)
        except Exception, msg:
            self.connect(timeout)
            self.send(cmd, timeout+1)
    
    def recv(self):
        buff = self.__socket.recv(1024*100)
        #self.send('___OK___')
        if not buff:
            raise
        return buff
    
    def mel(self, cmd):
        result='<connection error>'
        try:
            self.send(cmd)
            result = self.recv()
        except:
            result = self.mel(cmd)
        return result
    
    def save(self):
        self.send('file -rn "%s/msocket_save"' % os.environ['TMP'].replace('\\','/') )
        self.send('file -f -save -options "v=0" -type "mayaBinary"')
        return self.recv()
        
    def load(self):
        self.send('file -f -o "%s/msocket_save.mb"' % os.environ['TMP'].replace('\\','/') )
        return self.recv()
    
    def cgfxDEVrefresh(self):
        self.send('''
            global float $refreshing;
            print (%s-$refreshing);
            if((%s-$refreshing)>5) print " refreshing DEV cgfx shader node!";
        ''' % ( str(time.time()),str(time.time()) ) )
        self.send('''
            global float $refreshing;
            if((%s-$refreshing)>5) AEpure3dCgfxShaderRefresh "DEV" "AEp3dShaderFilename";
        ''' % ( str(time.time())) )
        self.send('''
            global float $refreshing;
            if((%s-$refreshing)>5) $refreshing=%s;\n
        ''' % ( str(time.time()), str(time.time())) )


if maya:
    pluginName = "hradecCustomization"
    PluginNodeId = 0xCFFFE

    # a class that holds all my generic maya tools!!
    class hradecTools:
        def __init__(self):
            self.hportURL = None
            self.socket =  msocket()
            try:
                self.socket.bind()
            except Exception, msg:
                print sys.stderr, str(msg)
            
        @staticmethod
        def e(cmd):
                whatIs =  meval('whatIs %s' % cmd)
                if 'found in' in whatIs:
                    path = os.path.abspath( whatIs.split('in: ')[1].strip() )
                    cur = os.getcwd()
                    os.chdir(cgfxDevTools)
                    err = os.system('%s "%s"' % (editra, path) )
                    if err>0:
                        raise Exception('cant find %s' % editra)
                    os.chdir(cur)
                else:
                    raise Exception(cmd + ' is ' + whatIs)
                
    def setupScene():
        if rad:
            m.setAttr("perspShape.farClipPlane", 1000000)
            meval('source createPrefWndUI; changeLinearUnit("meter")')
            
        # force bg gradient all the time! (maya doesnt save the prefs for it!)
        meval('displayPref -displayGradient true;')
        

    def loadLast():
        if os.environ.has_key('AUTOLOAD'):
            if os.environ['AUTOLOAD']!='0':
                projs = m.optionVar(q='RecentProjectsList')
                meval('setProject  "%s"' % projs[-2])
                files = m.optionVar(q='RecentFilesList')
                mf = files[-1]
                m.file(mf, f=True, o=True)
            
        setupScene()

        # as assiging my generic tools class to globals() doesn't seem to work in a plugin,
        # I'm assigning it to booth maya and maya.cmds modules so they are availables
        # globally in maya (aparently globals() inside a plugin is isolated from the 
        # globals environment running when maya finishes initalization)
        # maya and maya.cmds modules are exactly the same!
        tools = hradecTools()
        m.h = tools
        maya.h = tools


    def initializePlugin(mobject):
        m.scriptJob( runOnce=True,  idleEvent=loadLast )
        m.scriptJob( event=('deleteAll',setupScene) )
            

    def uninitializePlugin(mobject):
        m.h.socket.close()
        pass

    setupScene()
