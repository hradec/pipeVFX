import sqlitedict
import sqlite3
import pipe
import IECore
import time

__DB = '%s/sam/.sam.db/sql.db'

class assets(sqlitedict.SqliteDict):
    def __init__( self, job=None ):
        p = _DB(job)
        p='/tmp/xx'
        sqlitedict.SqliteDict.__init__( self, p+'.dict', autocommit=True )

        # t = time.time()
        # print "reading db: %0.04f" %  (time.time()-t)
        #
        # for each in [ x for x in self.keys() if x[0]=='/' ]:
        #     # print each
        #     i = each.split('/')
        #     self[i[1]][i[2]][i[3]][i[4]] = eval(self[each])
        #
        # print "elapsed time for eval: %0.04f" %  (time.time()-t)


    def refresh( self, folderName='sam', force=None ):
        import assetUtils, Asset, genericAsset
        import time, os, threading, sys
        from glob import glob
        from multiprocessing import Pool
        ret = {}
        threads = []
        try: j = pipe.admin.job()
        except: j=None
        if j:
            isAsset = '/asset/' in j.shot().path()
            shot = j.shot().shot
            def recursiveTree(path, d={}, d2={}, f='',l=0, threads = threads):
                # print path
                if l>=5:
                    return d
                for each in glob( "%s/*" % path ):
                    if f in each:
                        id = each.replace(path,'')[1:]
                        if os.path.isdir(each):
                            # try:
                            #     data = Asset.AssetParameter(each.replace(j.path('sam/'),'')).getData()
                            #     # id = id+" (%s)" % data['assetUser']
                            #     zdata[each] = data
                            # except:
                            #    pass
                            # if l!=2 or len(id.split('.'))==1 or isAsset or shot == id.split('.')[0] :
                                # if l==2:
                                #     print shot ,id
                                # sys.stdout.flush()

                                d[id] = {}
                                if os.path.exists('%s/data.txt' % each):
                                    # data = Asset.AssetParameter(each.replace(j.path('sam/'),'')).getData()
                                    op = assetUtils.assetOP(each.split(folderName)[1][1:])
                                    # print( op.pathPar )
                                    op.loadOP()
                                    data = op.data
                                    data['whoCanImport'] = op.subOP._whoCanImport
                                    data['whoCanOpen'] = op.subOP._whoCanOpen
                                    data['nodeName'] = genericAsset._nodeName(data)
                                    for n in data.keys():
                                        if 'IECore' in str(data[n]):
                                            data[n] = str(data[n])
                                    # d[id]['__data__'] = open('%s/data.txt' % each, 'r').readlines()
                                    # print data
                                    d[id]['data'] = data

                                # id2 = ( id if id[0].isdigit() and len(id.split('.'))>2 else id.split('.')[-1] )
                                # d2[id2] = {}
                                # recursiveTree(each, d[id], d2[id2],l=l+1)

                                recursiveTree(each, d[id], {},l=l+1)
                                # threads += [threading.Thread(target=recursiveTree,args=(each, d[id], {},'',l+1,threads,))]
                                # threads[-1].start()

                        elif 'current' in each :
                            lines = ''.join(open(each).readlines()).replace('\n','')
                            d['__current__'] = lines
                        #    d[id] = False
                return d



            def getAll(path, r={}, l=[]):
                paths = glob( "%s/*/*/*/*" % path )
                pool = Pool(8)
                ret = {}
                results = pool.map(loadOP, paths)
                return results

            t = time.time()

            # ret = recursiveTree("%s/sam" % (j.path()), ret, ret_sem_shot, filter)
            print( "populateAssets->starting: %0.04f" %  (time.time()-t) )
            # types = assetUtils.types()
            # print "populateAssets->gettingTypes: %0.04f" %  (time.time()-t)

            #recursiveTree("%s/sam" % j.path(), ret)
            ret = getAll("%s/sam" % j.path())

            print( "populateAssets: %0.04f" %  (time.time()-t) )

            # print ret[0]
            for r in ret:
                for k in r.keys():
                    self[k] = r[k]


            print( "done: %0.04f" %  (time.time()-t) )


_loadOP_all = {}
def loadOP(*p):
    # print p
    path = p[0]
    import assetUtils, Asset, genericAsset
    import time, os, threading, sys
    from glob import glob
    from multiprocessing import Pool


    r = _loadOP_all
    i = path.split('sam')[1].strip('/').split('/')

    if i[0] not in r:
        r[i[0]] = { }
    if i[1] not in r[i[0]]:
        r[i[0]][i[1]] = {}
    if i[2] not in r[i[0]][i[1]]:
        r[i[0]][i[1]][i[2]] = {}
    if i[3] not in r[i[0]][i[1]][i[2]]:
        if 'current' in i[3] :
            lines = ''.join(open(path).readlines()).replace('\n','')
            r[i[0]][i[1]][i[2]]['__current__'] =  lines.strip()
        else:
            r[i[0]][i[1]][i[2]][i[3]] =  {}

            op = assetUtils.assetOP(path.split('sam/')[1])
            op.loadOP()
            data = op.data
            data['whoCanImport'] = op.subOP._whoCanImport
            data['whoCanOpen']   = op.subOP._whoCanOpen
            data['nodeName']     = genericAsset._nodeName(data)
            data['stat']         = os.stat(path+'/data.txt')
            for n in data.keys():
                if 'IECore' in str(data[n]):
                    data[n] = str(data[n])

            r[i[0]][i[1]][i[2]][i[3]]['data'] = data
    return r



_loadOP_all = {}
def _getData(*p):
    import assetUtils, Asset, genericAsset
    import time, os, sys
    import IECore
    # self = p[0][0]
    path = p[0]
    data = {}
    data['asset'] = path

    if os.path.isdir(path):
        # print p
        op = assetUtils.assetOP(path.split('sam/')[1])
        op.loadOP()
        data = op.data
        data['whoCanImport'] = op.subOP._whoCanImport
        data['whoCanOpen']   = op.subOP._whoCanOpen
        data['nodeName']     = genericAsset._nodeName(data)
        data['stat']         = os.stat(path+'/data.txt')
        # data['op']           = IECore.ParameterParser().Serialize(op.op.parameters())
        # data['subOP']        = IECore.ParameterParser().Serialize(op.subOP.parameters())
        for n in data.keys():
            if 'IECore' in str(data[n]):
                data[n] = str(data[n])

        ap = path.split('sam/')[1]
        _loadOP_all[ap] = data
        data['asset'] = ap

    return data


import pickle
class asset2(dict):
    @staticmethod # because this doesn't make sense as a global function.
    def _process_args(mapping=(), **kwargs):
        return ( mapping, kwargs )

    def __init__(self, job=None, parent='', mapping=(), **kwargs):
        sqlFile = _DB(job)
        sqlFile = '/tmp/asset2.db'
        self.sql = sqlite3.connect(sqlFile)
        self.sql.execute('''CREATE TABLE IF NOT EXISTS ASSETS (
            ASSET        TEXT PRIMARY KEY NOT NULL,
            TYPE         TEXT,
            SUBTYPE      TEXT,
            NAME         TEXT,
            VERSION      TEXT,
            DATA         BLOB,
            STAT         TEXT,
            NODENAME     TEXT,
            WHOCANIMPORT TEXT,
            WHOCANOPEN   TEXT
        );''')
        self.sql.execute('''CREATE TABLE IF NOT EXISTS CURRENT (
            ASSET        TEXT PRIMARY KEY NOT NULL,
            VERSION      TEXT NOT NULL
        );''')
        self.sql.commit()
        super(asset2, self).__init__(mapping, **kwargs)

        self.__parent = parent

    # @staticmethod
    # def _getData(*p):
    #     self = p[0]
    #     path = p[1]
    #     if os.path.isdir(path):
    #         op = assetUtils.assetOP(path.split('sam/')[1])
    #         op.loadOP()
    #         data = op.data
    #         data['whoCanImport'] = op.subOP._whoCanImport
    #         data['whoCanOpen']   = op.subOP._whoCanOpen
    #         data['nodeName']     = genericAsset._nodeName(data)
    #         data['stat']         = os.stat(path+'/data.txt')
    #         for n in data.keys():
    #             if 'IECore' in str(data[n]):
    #                 data[n] = str(data[n])
    #
    #         ap = p.split('sam/')[1]
    #         self.__setitem__(ap,  data )
    #
    #         return data

    def refresh(self):
        import assetUtils, Asset, genericAsset
        import time, os, threading, sys
        from multiprocessing import Pool
        from glob import glob

        path = "%s/sam" % pipe.admin.job().path()

        t = time.time()
        print( "populateAssets->starting: %0.04f" %  (time.time()-t) )

        paths = glob( "%s/*/*/*/*" % path )

        cursor = self.sql.execute( 'SELECT ASSET FROM ASSETS' )
        db = [ x[0] for x in cursor ]
        paths = [ x for x in paths if x.split('sam/')[1] not in db]

        pool = Pool(8)
        ret = pool.map( _getData, paths )

        # ret = []
        # for p in glob( "%s/*/*/*/*" % path ):
        #     ret.append( _getData(p) )

        print( "populateAssets->commit to db: %0.04f" %  (time.time()-t) )
        current = glob( "%s/*/*/*/current" % path )
        for each in ret:
            if '/current' not in each['asset']:
                self.__setitem__( each['asset'], each )

        # def getAll(path, r={}, l=[]):
        #     paths = glob( "%s/*/*/*/*" % path )
        #     pool = Pool(8)
        #     ret = {}
        #     results = pool.map(loadOP, paths)
        #     return results
        #
        #
        # ret = getAll("%s/sam" % j.path())
        # print "populateAssets: %0.04f" %  (time.time()-t)
        # for r in ret:
        #     for k in r.keys():
        #         self[k] = r[k]
        #
        #
        print( "done: %0.04f" %  (time.time()-t) )



    def __getitem__(self, k):
        path = '/'.join([ self.__parent, k.strip('/') ]).strip('/').strip()
        assetPath = '/'.join(path.split('/')[:4])
        levels = len(path.split('/'))
        # cursor = self.sql.execute( 'SELECT ASSET, DATA FROM ASSETS WHERE ASSET LIKE "%s\/%%"' % path )
        # for line in  cursor:
        #     asset2()[line[0].split(self.__parent)[1].strip('/')] = line[1]
        # print self.__parent,path, k.strip('/'), asset2(parent = path).keys()
        if levels>3:
            cursor = [x for x in self.sql.execute( 'SELECT DATA FROM ASSETS WHERE ASSET LIKE "%s"' % assetPath )]
            # print assetPath,cursor
            ret={}
            if cursor:
                ret = pickle.loads(cursor[0][0])

        else:
            # print assetPath
            ret = asset2( parent = assetPath ) #super(asset2, self).__getitem__(k)

        return ret



    def __setitem__(self, k, value):
        # print value
        k = k.strip('/')
        p = k.split('/')
        if len(p)<4:
            # print( k )
            raise Exception('A key need to be a path with at least 4 levels. Ex: /model/maya/name/01.00.00')

        v = p[3].split('.')
        if len(v) < 3:
            # print( v )
            raise Exception('The 4th level of a path needs to be a version, specified as 1.0.0 . Ex: /model/maya/name/01.00.00')

        # format version number as 00.00.00
        p[3] = '%02d.%02d.%02d' % ( int(v[0]), int(v[1]), int(v[2]), )

        self.sql.execute( 'INSERT OR REPLACE INTO ASSETS (ASSET, TYPE, SUBTYPE, NAME, VERSION, DATA) VALUES ("%s", "%s", "%s", "%s", ?, ?);' %
            ( k, p[0], p[1], p[2],  ), (p[3],sqlite3.Binary(pickle.dumps(value)),) )
        self.commit()
        return super(asset2, self).__setitem__(k, v)

    def commit(self):
        self.sql.commit()

    def __delitem__(self, k):
        return super(asset2, self).__delitem__(k)

    def get(self, k, default=None):
        return super(asset2, self).get(k, default)

    def setdefault(self, k, default=None):
        return super(asset2, self).setdefault(k, default)

    # def pop(self, k, v=_RaiseKeyError):
    #     if v is _RaiseKeyError:
    #         return super(asset2, self).pop(k)
    #     return super(asset2, self).pop(k, v)

    def update(self, mapping=(), **kwargs):
        super(asset2, self).update(self._process_args(mapping, **kwargs))

    def __contains__(self, k):
        return super(asset2, self).__contains__(k)

    def copy(self): # don't delegate w/ super - dict.copy() -> dict :(
        return type(self)(self)

    def _field(self):
        FIELD = [
            'TYPE',
            'SUBTYPE',
            'NAME',
            'VERSION',
            'DATA'
        ]
        F = FIELD[0]
        if self.__parent:
            F = FIELD[len(self.__parent.split('/'))]

        return F

    def keys(self):
        F = self._field()
        G = ''
        if F != 'DATA':
            G = 'GROUP BY '+F

        sqlCmd = 'SELECT %s FROM ASSETS WHERE ASSET LIKE "%s%%" %s' % (F, self.__parent, G)
        # print sqlCmd
        cursor = self.sql.execute( sqlCmd )
        ret = []
        for line in  cursor:
            ret += [ str(line[0]) ]
        return ret


    @classmethod
    def fromkeys(cls, keys, v=None):
        return super(asset2, cls).fromkeys( ( k for k in keys), v )

    def __repr__(self):
        F = self._field()
        tmp = ''
        if F == 'DATA':
            # print self.keys()
            tmp = pickle.loads(self.keys()[0])
        else:
            tmp = self.keys()
        return '{0}({1})'.format( type(self).__name__, tmp )




def _DB( job=None ):
    if not job:
        return __DB % pipe.admin.job().path()
    return __DB % ( '%s/%s' % (pipe.roots.jobs(), job) )


def exists(job=None):
    import os
    if not job:
        job = pipe.admin.job().proj

    return os.path.exists( _DB(job) )

def create(job=None):
    import os, sys
    if not job:
        job = pipe.admin.job().proj

    if not exists(job):
        # use dbusService.py to create dabase in the sam folder
        sudo = pipe.admin.sudo()
        cmd = '''su -c "PYTHONPATH='%s' /bin/python2 %s %s"''' % (':'.join(sys.path),__file__, job)
        sudo.cmd(cmd)
        sudo.run()

    return sqlite3.connect( _DB(job) )

def createAll():
    import glob,os
    for job in glob.glob("%s/*" % pipe.roots.jobs()):
        create( job.split('/')[-1] )

def cacheAssetList( data ):
    return

    conn = create()
    # print 'UPDATE SAM_ASSET_LIST_CACHE set ASSET_LIST = "%s" where ID=1;' % str(data)
    conn.execute( 'UPDATE SAM_ASSET_LIST_CACHE set ASSET_LIST = "%s" where ID=1;' % str(data) )
    conn.commit()
    conn.close()

def retrieveAssetList( ):
    conn = create()
    cursor = conn.execute( 'SELECT ASSET_LIST from SAM_ASSET_LIST_CACHE' )
    lines = [ s[0] for s in cursor ]
    conn.close()
    # print len(lines)
    return eval( lines[0] )


def populateAssets():
    import assetListWidget
    assetListWidget.populateAssets(forceCache=True)



if __name__ == '__main__':
    import sys, os
    __DB = _DB( sys.argv[-1] )
    if not os.path.exists(__DB):
        os.system( 'mkdir -p %s' % os.path.dirname(__DB) )
        conn = sqlite3.connect(__DB)
        conn.execute('''CREATE TABLE SAM_ASSET_LIST_CACHE (
                                ID INT PRIMARY KEY NOT NULL,
                                ASSET_LIST TEXT
        );''')
        conn.execute( 'INSERT INTO SAM_ASSET_LIST_CACHE (ID,ASSET_LIST) VALUES (1,"");' )
        conn.commit()
        conn.close()
        os.system('chmod a+rwx -R %s' % os.path.dirname(__DB))
