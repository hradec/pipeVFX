

import os
try:
    import maya.cmds as m
except:
    m=None

thisModule = os.path.splitext( os.path.basename(__file__) )[0]
pythonpath = os.path.dirname(__file__)

def xgenGlobalEditor():
    '''
        an global editor to edit all modifiers in all xgen descriptions
    '''
    if m:
        import pymel.core as pm
        import xgenm as xg
        import xgenm.xgGlobal as xgg
        import os
        p=os.environ['MAYA_PROJECT']


        def densityPar(parent):
             pal = desc.keys()[0]
             each = desc[pal].keys()[0]
             v = xg.getAttr( 'density',pal,each,'RandomGenerator' )
             def density(*args):
                 v = pm.floatField( dens, v=1, q=1)
                 for attrName in pars:
                     for pal in desc:
                         for each in desc[pal]:
                             xg.setAttr( 'density',str(v), pal, each, 'RandomGenerator' )
             dens = parameter( 'density', float(v), parent, 100, density )


        def buttonPressed(*args):
            for attrName in pars:
                for pal in desc:
                    for each in desc[pal]:
                        v = pm.floatField( pars[attrName], v=1, q=1)
                        a = '_'.join(attrName.split('_')[0:-1])
                        m = attrName.split('_')[-1]
                        print( a, v, pal, each, m )
                        xg.setAttr( a, str(v), pal, each, m )

        def createWin(name):
            if m.dockControl( name.replace(' ','_'), exists=1 ):
                m.deleteUI(name.replace(' ','_'))

            win = pm.window(name+'_window',
                nestedDockingEnabled=1,
                resizeToFitChildren=1,
                sizeable = True,
        #        width = 180,
        #        height = 600,
                minimizeButton = True,
                maximizeButton = False
            )
            pm.scrollLayout()
            dock = m.dockControl( name, area='right', content=win, visible=1,allowedArea='all', fh=0, fw=1, w=168, h=6000, retain=0,floating=0)
            return dock

        def tab(name, win):
            return pm.columnLayout(name+'_col')

        def parameter(name, value, l, w=100, callback=None):
            r=pm.rowLayout(numberOfColumns = 2, parent = l, h = 18, columnAlign2=('right','left'))
            pm.text(name, parent = r, annotation = "", width = w)
            if callback:
                return pm.floatField(parent = r, width = 50, annotation = "", v=value, changeCommand=callback)
            return pm.floatField(parent = r, width = 50, annotation = "", v=value)


        for pal in xg.palettes():
            xg.exportPalette( pal, '%s/data/sam_xgen_collection_%s.xgen' % (p,pal))

            desc={ pal : {} }
            for each in xg.descriptions():
                desc[pal][each] = {
                    'attrs' : xg.allAttrs( pal, each ),
                    'mods' : {}
                }
                modules = desc[pal][each]['mods']
                for n in xg.fxModules( pal, each ):
                    modules[n] =  {
                        'name': n,
                        'attrs' :  xg.allAttrs( pal, each, n )
                    }


        win = createWin('xgen global editor')
        l=tab('modifiers parameters', win)
        #chkBox = pm.checkBox(label = "My Checkbox", value=True, parent=l)
        densityPar(l)
        pars={}
        frames={}
        for pal in desc:
            for each in desc[pal]:
                for mod in desc[pal][each]['mods']:
                  if mod not in frames:
                      frames[mod]=pm.frameLayout(mod+' Parameters', parent=l, w=160,collapsable=1, collapse=0, backgroundColor=(0.2,0.2,0.7),backgroundShade=1)
                  print( pal,each,mod )
                  if 'true' in xg.getAttr( 'active', pal, each, mod ):
                    modules = desc[pal][each]['mods']
                    for mod_attr in modules[mod]['attrs']:
                        attrName = "%s_%s" % ( mod_attr, mod )
                        v = xg.getAttr( mod_attr , pal, each, mod )
                        v = v.strip()
                        if ( not [ x for x in ['pt','map','control','mode','texels','radiusvariance','bake'] if x in attrName.lower() ] ) and v:
                            if '# backup original:' in v:
                                v = float(v.replace('# backup original:', '').strip().replace('\\','').replace('\n','n').split('n')[0])
                            elif v[0].isdigit():
                                v = float(v)
                            else:
                                v = None

                            if v != None and attrName not in pars:
                                pars[attrName] = parameter( mod_attr, v, frames[mod], 100,buttonPressed )

        btn = pm.button(label="Apply to all", parent=l)

        btn.setCommand(buttonPressed)

def farmTime():
    if m:
        frame = int(m.currentTime(q=1))
        # account for running in the farm
        if "FRAME_NUMBER" in os.environ:
            frame = int(os.environ["FRAME_NUMBER"])
        return frame

def xgen_collection_path(collection='collection8', xgen_path=''):
    if m:
        proj  = m.workspace(rd=1,q=1)
        path = "%s/data/" % proj
        if xgen_path:
            path = xgen_path
        return "%s/%s-%04d.xgen" % (path, collection, farmTime())
    return ""

def xgen_export_for_ribbox(selection=None, frame=1):
    ''' export all xgen in the selection to .xgen files, which
    can be rendered directly in renderman '''
    exported_data=[]
    if m:
        import xgenm as xg
        from maya.mel import eval as meval
        import os

        # collection = xg.palettes()
        collection = m.ls(selection, type='xgmPalette', dag=1, l=0)

        if m.nodeType(collection) != 'xgmPalette':
            collection = m.ls(collection, type='xgmPalette', dag=1, l=0)

        if type(collection) == type(""):
            collection = [collection]

        # if there's nothing to export, just return empty!
        if not collection:
            return exported_data

        proj  = m.workspace(rd=1,q=1)

        for col in collection:
            m.currentTime(frame,e=1)
            path = str(xgen_collection_path(col))
            print( col, path )
            xg.exportPalette( str(col), path )
            descriptions = [ m.listRelatives(x, p=1)[0] for x in m.ls(col, type='xgmDescription', dag=1, l=1) ]
            patchName = ','.join( [ ','.join(m.listConnections(patchName+'.geometry')) for patchName in m.ls(selection, type='xgmSubdPatch', dag=1, l=1) ] )
            exported_data += [(path, col, descriptions, patchName)]

    return exported_data


def xgen_ribbox(collection='collection8', descriptions='tranca_1_,trance_2_,trance_3_', abc='/atomo/jobs/0669.batavo_nuv/sam/animation/alembic/1120.cabeca_e_chapeu/01.17.00/1120.cabeca_e_chapeu.asset.abc', patch_name='baseCabeloXgen', xgen_path=''):
    '''
        this function is called at rendertime, inside renderman, and set the procedural loading of the xgen procedural, passing the .xgen file to it
    '''
    res=''
    if m:
        from maya.mel import eval as meval
        import os, tempfile

        proj = m.workspace(rd=1,q=1).rstrip('/')
        pal = collection
        # abc = '/atomo/jobs/0669.batavo_nuv/sam/animation/alembic/1120.cabeca_e_chapeu/01.17.00/1120.cabeca_e_chapeu.asset.abc'
        # patch = 'baseCabeloXgen'

        xgen = xgen_collection_path(collection, xgen_path)

        # lets edit the xgen file now...
        xgen_file = []
        for line in open(xgen, 'r').readlines():
            if 'meshFile' in line:
                # replace meshFile parameter by the sam alembic
                xgen_file += ["\tmeshFile\t\t%s\n" % abc]
            else:
                xgen_file += [line]

        # now we create a temp xgen file
        xgen_file_tmp = tempfile.mktemp()

        # and save our edited one
        f=open(xgen_file_tmp,'w')
        f.write(''.join(xgen_file))
        f.close()



        fps = 24
        extra = '-debug 1'
        for desc in descriptions.split(','):
            res += '''
                Procedural "DynamicLoad" ["XGenProcPrim" " -frame %s -file %s -palette %s -geom %s -patch %s -description %s -fps %s  %s"] [-1000 1000 -1000 1000 -1000 1000]
            ''' % (str(farmTime()), xgen_file_tmp, pal, abc, patch_name, desc, fps, extra)
        print( res )
    return res

def xgen_create_ribbox(collection='collection8', descriptions=['tranca_1_', 'trance_2_', 'trance_3_'], abc='/tmp/xx.abc', patch_name='baseCabeloXgen', xgen_path=''):
    if m:
        from maya.mel import eval as meval
        import os

        ribbox = meval('''
             delete `ls "rmanWorld*"`;
             string $attrName = `rmanGetAttrName "ribBox"`;
             string $attrNameInterp = `rmanGetAttrName ribBoxInterpolation`;
             string $sg = `sets -renderable true -noSurfaceShader true -empty -name rmanWorld`;
             rmanAddAttr $sg $attrName "#your rib here";
             rmanAddAttr $sg $attrNameInterp "";
             select -r -ne $sg;
             $attr=($sg+"."+$attrName);
        ''')

        value = '''[mel "python(\\"import sys;sys.path.insert(0,'%s');import %s;reload(%s);%s.xgen_ribbox('%s','%s','%s','%s','%s')\\")"]''' % (
            pythonpath,
            thisModule, thisModule, thisModule,
            collection,
            ','.join(descriptions),
            abc,
            patch_name,
            xgen_path
        )
        print( "===>",value )
        m.setAttr( ribbox, value, type='string' )
        m.setAttr( ribbox.split('.')[0]+".rman__torattr___ribBoxInterpolation", 'TCL', type='string' )
