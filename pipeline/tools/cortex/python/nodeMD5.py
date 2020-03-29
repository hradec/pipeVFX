


class nodeMD5:
    ''' a class to index nodes by md5, so to workaround applications that
    don't keep node names intact, like maya!
    for now only supports maya '''
    def __init__(self):
        import md5
        try:
            import maya.cmds as m
        except:
            m = None
        self.m = m
        self.md5 = md5


    def nodeMD5(self, name):
        ''' calculate the md5 for a given string '''
        return self.md5.md5(name).hexdigest()

    def setNodeMD5(self, n):
        ''' create a md5 attribute for the given node and fill it up with
        the md5 value of its name '''
        h = self.nodeMD5(n)
        md5Attr = n+'.md5'
        if self.m:
            if not self.m.objExists(md5Attr):
                self.m.addAttr(n, ln='md5', dt='string')
                self.m.setAttr(md5Attr, h, type='string')

    def bakeAllMD5(self):
        ''' create md5 attributes on all nodes and fill with the md5 of the
        node name '''
        if self.m:
            for n in self.m.ls(geometry=1, transforms=1, l=1):
                self.setNodeMD5(n)

    def delNodeMD5(self, n):
        ''' delete md5 attribute from a node '''
        md5Attr = n+'.md5'
        if self.m:
            if self.m.objExists(md5Attr):
                self.m.deleteAttr(md5Attr)

    def getNodeMD5(self, n):
        ''' get the md5 value stored in an md5 attribute of the given node '''
        md5Attr = n+'.md5'
        res = ''
        if self.m:
            if self.m.objExists(md5Attr):
                res = self.m.getAttr(md5Attr)
        return res

    def indexMD5(self):
        ''' create an cache index of all md5s for all nodes, so we can find
        the node names for a given md5 '''
        res = {}
        if self.m:
            # if len(self.__indexMD5) != len(allNodes):
            # allNodes = self.m.ls(geometry=1, transforms=1, l=1)
            #     del self.__indexMD5
            if not hasattr( self, '__indexMD5'):
                allNodes = self.m.ls(geometry=1, transforms=1, l=1)
                self.__indexMD5 = {}
                for n in allNodes:
                    h = self.getNodeMD5(n)
                    if h not in self.__indexMD5:
                        self.__indexMD5[h] = []
                    self.__indexMD5[h] += [n]
            res = self.__indexMD5
        return res

    def getNodeByMD5(self, h):
        ''' return the node names that contain the given md5 hash '''
        z = self.indexMD5()
        if z and h:
            return z[h]
        return ''


# m.select(getNodeByMD5('3e940e700db14791a8d8aa756330ad86'))
# x=getNodeMD5('SAM_rigging_maya_personagem_maca_01_01_00_asset')
