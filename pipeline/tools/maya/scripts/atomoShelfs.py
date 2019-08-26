# encoding: utf-8
import maya
import maya.cmds as m
from maya.mel import eval as meval
import glob,os
import pipe
import rfm.rlf2maya as rlf2maya
from os import stat
from pwd import getpwuid

__menuline__ = u'▬'*40

import pymel.core as pm



def listShelfs():
    topLevelShelf = meval('string $m = $gShelfTopLevel')
    shelves = pm.shelfTabLayout(topLevelShelf, query=True, tabLabelIndex=True)
    for index, shelf in enumerate(shelves):
        pm.optionVar(stringValue=('shelfName%d' % (index+1), str(shelf)))
        print shelf



def find_owner(filename):
    ret = stat(filename).st_uid
    try:ret = getpwuid(ret).pw_name
    except: pass
    return "(%s)" % str(ret)


class progress:
    def __init__(self, steps=10, title='Fixing Shader Dynamic Rules'):
        self.amount = 0
        self.title = title
        self.gMainProgressBar = meval('global string $gMainProgressBar;$tmp=$gMainProgressBar')
        m.progressBar(self.gMainProgressBar, edit=1, beginProgress=1, isInterruptable=1, status=title+"...", maxValue=steps+1)

    def next(self):
        if m.progressBar( self.gMainProgressBar, query=1, isCancelled=1, ):
            self.done()
            raise Exception("Interrupted by user")
        m.progressBar(self.gMainProgressBar, edit=1, step=1)

    def done(self):
        m.progressBar(self.gMainProgressBar, edit=1, endProgress=1)





def addShelf(name):
    maya.mel.eval('if (`shelfLayout -exists %s `) deleteUI %s;' % (name,name))
    maya.mel.eval('global string $gShelfTopLevel;')
    maya.mel.eval('global string $scriptsShelf;')
    maya.mel.eval('$scriptsShelf = `shelfLayout -cellWidth 33 -cellHeight 33 -p $gShelfTopLevel %s`;' % name)


def addEmptyShelf(shelfname):
    addShelf(shelfname)
    #
    # if m.shelfLayout(shelfname, exists=1):
    #     m.deleteUI(shelfname)
    #     m.optionVar( intValue=("numShelves", int(m.optionVar(q="numShelves"))-1) )
    #
    #
    # shelfTab = maya.mel.eval('global string $gShelfTopLevel;$tempMelVar=$gShelfTopLevel')
    # m.optionVar( intValue=("numShelves", int(m.optionVar(q="numShelves"))+1) )
    # m.optionVar(stringValue=("shelfName%s" % str(int(m.optionVar(q="numShelves"))), shelfname))
    # m.shelfLayout( shelfname, cellWidth=33, cellHeight=33, p=shelfTab,preventOverride=1 )

def selectShelf(name):
    shelfTab = maya.mel.eval('global string $gShelfTopLevel;$tempMelVar=$gShelfTopLevel')
    m.shelfTabLayout(shelfTab,selectTab=name,e=1)


def addShelfButton(name, help, icon="menuIconWindow.png", cmd="", python=False, menu=(), extra={}, enable=1):
    if not python:
        sourceType = "mel"
    else:
        sourceType = "python"
    m.shelfButton(
            enableCommandRepeat=1,
            enable=enable,
            width=35,
            height=35,
            manage=1,
            visible=1,
            preventOverride=1,
            annotation=help,
            command=cmd,
            enableBackground=0,
            align="center",
            label=name,
            labelOffset=0,
            font="plainLabelFont",
            imageOverlayLabel=name,
            image=icon,
            image1=icon,
            style="iconOnly",
            marginWidth=1,
            marginHeight=1,
            sourceType=sourceType,
            commandRepeatable=1,
            flat=1,
            mip=range(len(menu)),
            mi=menu,
            overlayLabelColor=(0.854,0.950917,1),
            overlayLabelBackColor=(0,0,0,0.3),
    )




def removeReferences(filt="dynamic"):
    n = filter(lambda x: filt in x, m.file(q=1,r=1))
    p = progress(len(n))
    for each in n:
        m.file(each ,rr=1)
        p.next()
    p.done()

    if m.objExists("mtorPartition.rlfData"):
        m.setAttr( "mtorPartition.rlfData", "", type='string' )

def reloadReferences(filt="dynamic"):
    n = filter(lambda x: filt in x, m.file(q=1,r=1))
    p = progress(len(n))
    for each in n:
        loadReference(each)
        p.next()
    p.done()



def reloadOtherReferences():
    all = filter(lambda x: "dinamic" not in x, m.file(q=1,r=1))
    dinamic = filter(lambda x: "dinamic" in x, m.file(q=1,r=1))
    files = filter(lambda x: "dinamic" not in x, m.file(q=1,r=1))
    p = progress(len(all)*2)
    for each in all:
        m.file(each ,rr=1)
        p.next()
    for each in files:
        namespace = os.path.splitext(os.path.basename(each))[0].replace('.','_')
        m.file( each,
                r=1, gn=namespace,
                mergeNamespacesOnClash=1,
                namespace=namespace,
                options="v=0;"
            )
        p.next()
    for each in dinamic:
        loadReference(dinamic)
        p.next()
    p.done()


def loadReference(refFile):
    def delayed():

        namespace = os.path.splitext(os.path.basename(refFile))[0].replace('.','_')
        removeReferences(refFile)

        # stop IPR if running so maya won't crash!!
        meval("rmanRerenderStop();")


        s = rlf2maya.GetActiveScope()

        if "dynamic" in namespace:
            removeReferences("dynamic")

        m.file( refFile,
            r=1, gn=namespace,
            loadReferenceDepth='topOnly',
            mergeNamespacesOnClash=1,
            namespace=namespace,
            options="v=0;"
        )

        rlf2maya.SetActiveScope(s)

        fixRulesNamespace()


    m.scriptJob( runOnce=True,  idleEvent=delayed )


def fixGolaem():
    for each in meval('$tmpz=getObjectsOfType("CrowdRenderProxy")'):
        meval('glmPreRenderCallbackRenderman("%s")' % each)




def fixRulesNamespace():
    def fixRulesNamespaceInIdleEvent():
        nodes = m.ls("dynamic*:mtor*")
        if nodes:
            # run over all dynamic*:mtor* and adds the namespace
            for n in nodes:
                # we revert any editing to the scope
                m.referenceEdit( n, failedEdits=1, successfulEdits=1, editCommand='setAttr', removeEdits=1 )
                # now we fix it with the namespace
                data = m.getAttr("%s.rlfData" % n)
                data = data.replace('Id="', 'Id="%s:' % n.split(':')[0])
                data = data.replace('Label="', 'Label="%s:' % n.split(':')[0])
                m.setAttr("%s.rlfData" % n, data, type='string')

            # fix all dynamic*:mtor* scopes and fills the global scope with correct and namespaced rules!
            cleanupRulesGarbage("dynamic*:mtor*")
            buildShelf()

        # Create a nodescript to fix rules once a scene is loaded, all the time!!
        for each in m.ls('fixDynamicRules*'):
            m.delete(each)
        if nodes:
            m.scriptNode( st=1, bs='import atomoShelfs;atomoShelfs.fixRulesNamespace()', n='fixDynamicRules', stp='python')

        fixGolaem()

    # this garantees to run the rebuild ONLY once after reloading all references!
    if m.scriptJob(lj=1):
        if not filter(lambda x: 'fixRulesNamespaceInIdleEvent' in x, m.scriptJob(lj=1)):
            m.scriptJob(runOnce=True,  idleEvent=fixRulesNamespaceInIdleEvent)
    else:
        fixRulesNamespaceInIdleEvent()



def cleanupRulesGarbage(mtor="mtorPartition"):
    '''
        The dynamic rules in prman get trashed with old non-existing shading groups,
        which makes shaders that have the same name but a different shading group not being
        attached to the geometry, SILENTLY!!!!
        This function looks into the the scopes specified by a pattern and cleans up shading groups that don't exist,
        so making the rules clean and showing up a rule without a payload when it's shading
        group doesnt exist anymore!
        After cleaning, it fills the globalScope with the correct data from the specified scopes
    '''
    import maya.cmds as m
    import rfm.rlf2maya as rlf2maya
    import rfm.rlf as rlf
    import xmltodict


    rlf2maya.SetActiveScope(rlf.RLFScope())

    s = rlf2maya.GetActiveScope()
#    p = progress(len(s.GetRules()))
#    while len(s.GetRules())>0:
#        s.DeleteRuleAtIndex(0);rlf2maya.SetActiveScope(s)
#        p.next()
#    p.done()

    # fix if using wrong shading group!!!
    for n in m.ls(mtor):
        xml = m.getAttr("%s.rlfData" % n)

        # CLEANUP NON_EXISTING SHADING GROUPS
        # ==============================================================
        mprogress = progress(len(xml.split('\n'))*2)
        newxml = []
        for l in xml.split('\n'):
            if 'Payload Id=' in l:
                sg = l.split('Id="')[1].split('"')[0]
                if m.ls(sg):
                    newxml += [l]
                else:
                    print l
            else:
                newxml += [l]
            mprogress.next()

        xml = '\n'.join(newxml)


        # CREATE INDEX TO SEARCH FOR THE CORRECT SHADING GROUP OF A SHADER NAME
        # ========================================================================
        x=xmltodict.parse(xml)
        # get all shading groups for the shaders, and check which is connected to the shader!
        shaders={}
        for p in x['RenderManLookFile']['InjectablePayloads']['Payload']:
            if p['@Label'] not in shaders:
                shaders[p['@Label']] = {} # x['RenderManLookFile']['RuleSet']['Rule'][rule]
            if p['@Id'] not in shaders[p['@Label']]:
                shaders[p['@Label']][p['@Id']] = []

            connections=[]
            try: connections=m.connectionInfo("%s.surfaceShader" % p['@Id'], sourceFromDestination=1)
            except:pass
            shaders[p['@Label']][p['@Id']] += [connections]

        # now based on the shadingGroup in the xml, check what is the real one being connected to the shader node and use that one!
        shadingGroups={}
        for p in x['RenderManLookFile']['InjectablePayloads']['Payload']:
            if p['@Id'] not in shadingGroups:
                shadingGroups[p['@Id']] = [] # x['RenderManLookFile']['RuleSet']['Rule'][rule]
            shadingGroups[p['@Id']] = filter(lambda x: shaders[p['@Label']][x] != [u''], shaders[p['@Label']])


        # NOW PARSE THE RULES AND USE THE SHADING GROUP INDEX FROM ABOVE TO FIND THE
        # CORRECT (ATTACHED) SHADING GROUP OF A SHADER
        # ===========================================================================
        newxml = []
        for l in xml.split('\n'):
            if 'MatchMethod' in l:
                sg = l.split('Id="')[1].split('"')[0]
                if sg in shadingGroups:

                    l = l.replace( sg, shadingGroups[sg][0] )
                    print l
                else:
                    l = l.replace( sg, '' )
            newxml += [l]
            mprogress.next()

        mprogress.done()


        # set global rules for the scene!
        # ===========================================================================
        newxml = '\n'.join(newxml)
        m.setAttr("%s.rlfData" % n, newxml , type='string')
        s.Deserialize(newxml )

    rlf2maya.SetActiveScope(s)



def openSceneFromPublishedRef(scene):
#    def delayed():
        m.file(new=1,f=1)
        workspace = m.workspace( q=1, rd=1 )
        editFile = "%s/scenes/%s" % (workspace, os.path.basename(scene))
        os.system('rsync -avWpP "%s" "%s"' % (scene, editFile))
        m.file(editFile, o=1, f=1, options="v=0;")

        fixRulesNamespace()


#    m.scriptJob( runOnce=True,  idleEvent=delayed )



def loadRefs():
    all = m.file(q=1,r=1)
    dinamic = filter(lambda x: "dinamic" in x, all)
    files = filter(lambda x: "dinamic" not in x, all)
    p = progress(len(all))
    for each in files:
        m.file( each, loadReference=1)
        p.next()
    for each in dinamic:
        m.file( each, loadReference=1)
        p.next()
    p.done()

def unloadRefs():
    all = m.file(q=1,r=1)
    dinamic = filter(lambda x: "dinamic" in x, all)
    files = filter(lambda x: "dinamic" not in x, all)
    p = progress(len(all))
    for each in files:
        m.file( each, unloadReference=1)
        p.next()
    for each in dinamic:
        m.file( each, unloadReference=1)
        p.next()
    p.done()


def saveSceneToPublishedRef():
  def delayed():
    import maya.cmds as m
    import os
    from glob import glob
    filename = m.file( q=1,sn=1 )
    pubPath = filename.split('/users/')[0] + '/published/ref/'
    newfile = pubPath  + os.path.basename(filename)
    newnewfile  = ""

    versions = []
    b = ['Salvar com nome original: '+os.path.basename(newfile), 'Cancel']
    v = 0
    if '_v' in newfile:
        v = newfile.split('_v')[-1].split('.')[0]
    else:
        v = '%03d' % 1
        tmp = os.path.splitext(newfile)
        newfile = tmp[0]+'_v%s%s' % (v, tmp[1])
        b.insert(0,'Salvar com versao: '+os.path.basename(newfile))

    if int(v) > 0:
        #check if there are other versions published in the current shot/asset
        versions = glob(newfile.split('_v')[0]+'_v*')
        if versions:
            versions = filter(lambda x:  x.split('_v')[-1][0].isdigit()  ,versions)
            versions.sort()
            nv = versions[-1].split('_v')[-1].split('.')[0]
            newnewfile = newfile.replace( '_v'+v, '_v%03d' % (int(nv)+1) )

            if 'Salvar com versao:' in b[0]:
                b[0] = 'Salvar com versao: '+os.path.basename(newnewfile)
            else:
                b.insert(0,'Salvar como nova versao: '+os.path.basename(newnewfile))

    ret = 'Cancel'
    if os.path.exists(newfile):
       ret = m.confirmDialog( title='Confirm', message='Ja existe o arquivo '+newfile+'\n\n Qual nome quer usar?', button=b, defaultButton='Cancel', cancelButton='Cancel', dismissString='Cancel' )
    elif versions:
       ret = m.confirmDialog( title='Confirm', message='Existem outras versoes do arquivo '+newfile+'\n\n Qual nome quer usar?', button=b, defaultButton='Cancel', cancelButton='Cancel', dismissString='Cancel' )
    else:
       ret = m.confirmDialog( title='Confirm', message='Salvar a cena no published/ref com o nome\n\n'+os.path.basename(newfile)+'?\n', button=b, defaultButton='Cancel', cancelButton='Cancel', dismissString='Cancel' )

    if "nome original" in ret:
        # wee need to publish it in MA allways
        # we need to add "-dr 1" to all references after publishing!
        m.file(f=1,save=1,options="v=0;",saveReferencesUnloaded=1)
        tmp = pubPath+'/'+os.path.basename(ret.split(':')[-1].strip())
        cmd =  "rsync -avWpP %s %s" % (filename, tmp)
        print cmd
        os.system( cmd )

    elif 'Cancel' not in ret:
        #unloadRefs()
        tmp = os.path.dirname(filename)+'/'+os.path.basename(ret.split(':')[-1].strip())
        m.file(rn=tmp)
        m.file(f=1,save=1,options="v=0;")
        cmd = "rsync -avWpP %s %s" % (filename, pubPath + "/" + ret.split(':')[-1].strip())
        print cmd
        os.system( cmd )


    if ret != 'Cancel':
        import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;
        m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )

    buildShelf()
  m.scriptJob( runOnce=True,  idleEvent=delayed )


def editReference(filt="dynamic"):
    import os
    for each in filter(lambda x: filt in x, m.file(q=1,r=1)):
        cmd = "maya %s &" % os.path.abspath(each)
        print cmd
        os.system( cmd )


def rmanReRender():
    from maya.mel import eval as meval
    #reloadReferences()
    meval('rmanRerenderStart(1);')




def getPublishRefFileList(filt="dynamic", fileCmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.loadReference('%s')"):

    import maya.cmds as m
    referencesLoaded = m.file(q=1,r=1)

    import time
    m = ['', 'jan','fev','mar','abr','mai','jun','jul','ago','set','out','nov','dez']
#    files = {}
#    for each in glob.glob('%s/assets/*/published/ref/%s*' % (pipe.job.current(),filt)):
#        if not os.path.isdir(each):
#            files[ os.path.getmtime(each) ] = each

    def getFiles(path, files = {}):
        print path
        filez=glob.glob(path)
        for each in filez:
            if os.path.isdir(each):
#                getFiles( "%s/%s" % (each, os.path.basename(path)), files )
                getFiles( "%s/*" % (each), files )
            else:
                if '.ma' in each.lower() or '.mb' in each.lower():
                    files[ os.path.getmtime(each) ] = each
        return files


    files = getFiles( '%s/assets/*/published/ref/%s*' % (pipe.job.current(),filt) )
    files = getFiles( '%s/shots/*/published/ref/%s*' % (pipe.job.current(),filt) )

    dates = files.keys()
    dates.sort()
    dates.reverse()

    grouping = {}
    for date in dates:
        tmp = files[date].split('published')
        group = tmp[0]
        tmp = tmp[1].split('ref/')[-1]
        if '/' in tmp:
            group += os.path.dirname(tmp)
        if group not in grouping:
            grouping[group] = []
        grouping[group].append(date)

    groupingSorted = grouping.keys()
    groupingSorted.sort()

    menus = []
    for g in groupingSorted:
#        for d in dates:
        menus += [(__menuline__,"pass")]
        for d in grouping[g]:
            t = time.localtime(d)
            each = files[d]
            splitStr = '/assets/'
            if 'shots' in each:
                splitStr = '/shots/'

            loaded = '    '
            if filter(lambda x: each in x, referencesLoaded):
                loaded='█ '
                loaded='✹ '

#            shortName = "%s / %s / %s  " % ( splitStr.strip('/'), each.split(splitStr)[1].split('/')[0], os.path.basename(each) )
            shortName = "%s / %s / %s  " % ( splitStr.strip('/'), each.split(splitStr)[1].split('/')[0], each.split('ref/')[-1].replace('/',' / ') )
            shortName = loaded+"%s / %s - %02d:%02d:%02d - %s %s" % (t.tm_mday, m[t.tm_mon], t.tm_hour, t.tm_min, t.tm_sec, shortName, find_owner(each) )
            menus.append( (shortName, fileCmd % each) )


    return menus

def openPublishRef():
    return  getPublishRefFileList("", "import atomoShelfs;reload(atomoShelfs);atomoShelfs.openSceneFromPublishedRef('%s')")

def shaderRules_menus():
    menus = getPublishRefFileList("dynamic", "import atomoShelfs;reload(atomoShelfs);atomoShelfs.loadReference('%s')")

    menus += [(__menuline__,"pass")]
    menus += [("RECREATE rules from dynamic reference","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.fixRulesNamespace)")]
    menus += [("RELOAD dynamic_ reference scene","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.reloadReferences )")]
    menus += [("EDIT the dynamic_ reference in a new maya","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.editReference )")]
    menus += [(__menuline__,"pass")]
    menus += [("REMOVE dynamic_ reference scene","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.removeReferences )"),("","pass")]
    menus += [("RELOAD ALL references!!!! *** VAI DEMORAR ***","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.reloadOtherReferences )")]
    return menus

def generic_menus(classe='light'):
    menus = getPublishRefFileList(classe, "import atomoShelfs;reload(atomoShelfs);atomoShelfs.loadReference('%s')")

    menus += [(__menuline__,"pass")]
    menus += [("EDIT the "+classe+" reference in a new maya","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=lambda:atomoShelfs.editReference('"+classe+"') )")]
    menus += [("RELOAD "+classe+" reference scene","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=lambda:atomoShelfs.reloadReferences('"+classe+"') )")]
    menus += [(__menuline__,"pass")]
    menus += [("REMOVE "+classe+" reference scenes","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=lambda:atomoShelfs.removeReferences('"+classe+"') )"),("","pass")]
    menus += [("RELOAD ALL references!!!! *** VAI DEMORAR ***","import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.reloadOtherReferences )")]
    return menus


def xgenGlobalEditor():
    '''
        an global editor to edit all modifiers in all xgen descriptions
    '''
    import pymel.core as pm
    import maya.cmds as m
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
                    print a, v, pal, each, m
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
              print pal,each,mod
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




def buildShelf():
    addEmptyShelf("ATOMO_RENDER")

    addShelfButton(
        name="Shadr",
        help="\nBotao direito do mouse pra selecionar qual cena de shaders vc quer referenciar. \n\nBotao esquerdo da refresh no shelf, e remonta o menu se mais arquivos forem encontrados!\n",
        icon = "cluster.png",
        cmd="import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )",
        python=True,
        menu=shaderRules_menus(),
    )
#    addShelfButton(
#        name="Reload",
#        help="Reload Dynamic Reference",
#        icon="cluster.png",
#        python=True,
#        cmd="import atomoShelfs;import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.reloadReferences )",
#    )

    addShelfButton(
        name="",
        help="Dynamic Rules...",
        icon="rman_DynamicRulesEditor.png",
        cmd="execRmanMenuItem(\"Dynamic Rules...\")",
    )
#    addShelfButton(
#        name="CLR",
#        help="Limpa e conserta rules que nao estao sendo attachadas na geometria!\n\nUse esse botao pra limpar uma cena q vai ser usada como dynamic_ \n antes de salva-la!",
#        icon="",
#        python=True,
#        cmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.fixRulesNamespace()",
#    )

    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )
    addShelfButton(
        name="Light",
        help="\nBotao direito do mouse pra selecionar qual cena de light rigs vc quer referenciar. \n\nBotao esquerdo da refresh no shelf, e remonta o menu se mais arquivos forem encontrados!\n",
        icon = "ambientlight.png",
        cmd="import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )",
        python=True,
        menu=generic_menus('light'),
    )
    addShelfButton(
        name="Asset",
        help="\nBotao direito do mouse pra selecionar qual modelo vc quer referenciar. \n\nBotao esquerdo da refresh no shelf, e remonta o menu se mais arquivos forem encontrados!\n",
        icon = "",
        cmd="import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )",
        python=True,
        menu=generic_menus('asset'),
    )
    addShelfButton(
        name="Rig",
        help="\nBotao direito do mouse pra selecionar qual cena de rig vc quer referenciar. \n\nBotao esquerdo da refresh no shelf, e remonta o menu se mais arquivos forem encontrados!\n",
        icon = "",
        cmd="import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )",
        python=True,
        menu=generic_menus('rig'),
    )
    addShelfButton(
        name="Anim",
        help="\nBotao direito do mouse pra selecionar qual cena de animacao rigs vc quer referenciar. \n\nBotao esquerdo da refresh no shelf, e remonta o menu se mais arquivos forem encontrados!\n",
        icon = "",
        cmd="import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )",
        python=True,
        menu=generic_menus('animacao'),
    )
    addShelfButton(
        name="Shot",
        help="\nBotao direito do mouse pra selecionar qual cena de Shot scenes vc quer referenciar. \n\nBotao esquerdo da refresh no shelf, e remonta o menu se mais arquivos forem encontrados!\n",
        icon = "",
        cmd="import atomoShelfs;reload(atomoShelfs);import maya.cmds as m;m.scriptJob( runOnce=True,  idleEvent=atomoShelfs.buildShelf )",
        python=True,
        menu=generic_menus('Shot'),
    )


    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
        name="RE",
        help="Reference Editor Window",
        icon="menuIconFile.png",
        cmd="ReferenceEditor",
    )

    addShelfButton(
        name="",
        help="loadAllRefs",
        icon="loadRefs.bmp",
        python=True,
        cmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.loadRefs()",
    )
    addShelfButton(
        name="",
        help="loadAllRefs",
        icon="unloadRefs.bmp",
        python=True,
        cmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.unloadRefs()",
    )

    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
        name="",
        help="START IPR",
        icon="rman_rerender_controls.png",
        python=True,
        cmd="import atomoShelfs;atomoShelfs.rmanReRender()",
    )
    addShelfButton(
        name="",
        help="STOP IPR",
        icon="rman_rerender_stop.png",
        cmd="rmanRerenderStop();",
    )

    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
        name="Hshd",
        help="Abre o hypershade",
        icon="menuIconWindow.png",
        cmd="HypershadeWindow",
    )

    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
        name="",
        help="Abre uma cena do published/ref pra editar (Nao importa como referencia...Abre mesmo!!! rss)",
        icon="openPublished.bmp",
        python=True,
        cmd="",
        menu=openPublishRef()
    )
    addShelfButton(
        name="",
        help="Salva a cena corrente no published/ref do asset ou shot.",
        icon="save2Published.bmp",
        python=True,
        cmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.saveSceneToPublishedRef()",
    )


    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
        name="",
        help="Fix golaem cacheProxyNode if rendering crashes maya!",
        icon="golaemCacheProxyFix.bmp",
        python=True,
        cmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.fixGolaem()",
    )

    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
	name="STLIB",
	help="Tool for managing poses and animation \n Save poses and animation \n Mirror poses and animation \n Create easy to use selection sets \n MMB drag for fast pose blending \n"
	"Organize poses into folders \n LMB drag and drop to sort poses \n Switch between local and shared libraries \n Insert, marge and replace animation \n More information ttp://www.studiolibrary.com",
	icon="icon.png",
	python=True,
	cmd="import studiolibrary; studiolibrary.main()"
    )

    addShelfButton( name="", help="",icon="spacer.png",cmd="",enable=0,    )

    addShelfButton(
    	name="XgnGlb",
    	help="Tool to edit all modifiers in all xgen descriptions",
    	icon="Objects.png",
    	python=True,
    	cmd="import atomoShelfs;reload(atomoShelfs);atomoShelfs.xgenGlobalEditor()"
    )


    selectShelf("ATOMO_RENDER")

    progress().done()

    import assetUtils
    assetUtils.shelf._fixOptionVars
