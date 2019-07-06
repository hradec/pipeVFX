
#!/$ROOT/pipeline/tools/scripts/run rmanpy
import prman

class Rif(prman.Rif):
    def __init__(self, ri, scale):
        self.scale = float(scale)
        prman.Rif.__init__(self, ri)
    def PointsGeneralPolygons(self, nloops, nverts, verts, params):
        opcodes = []
        numblobs = len(params['P'])/3
        for n in range(numblobs):
            opcodes.append(1001)
            opcodes.append(n * 16)
        opcodes.append(0)        # blending code
        opcodes.append(numblobs)# blend all blobs
        for n in range(numblobs):
            opcodes.append(n)    # indices of the blobs to blend
        common = (self.scale,0,0,0,0,self.scale,0,0,0,0,self.scale,0)
        transforms = (self.scale,0,0,0,0,self.scale,0,0,0,0,self.scale,0)
        xyz = params['P']
        numxyz = len(xyz)
        for n in range(0, numxyz, 3):
            pos = (xyz[n], xyz[n+1], xyz[n+2])
            if n == 0:
                transforms = common + pos + (1,)
            else:
                transforms = transforms + common + pos + (1,)
        params = {}
        strs = ('',)
        self.m_ri.Blobby(numblobs,opcodes,transforms, strs, params)




if __name__=='__main__':
    import sys
    ri = prman.Ri()
    rif1 = Rif(ri)
    prman.RifInit([rif1])  # you can build a list of rif instances, comprising a Rif Chain

    ri.Begin(ri.RENDER)
    for r in ribfilelist:
        ri.ReadArchive(sys.argv)
    ri.End()
