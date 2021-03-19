
import maya.cmds as m
import re
processed = {}
created = []
remove = []

def atoi(text):
    return int(text) if text.isdigit() else text

def cleanName(name):
    return str(''.join(re.findall('[a-zA-Z]', name))).strip()

def difference(node):
    meshes = traverse(node)
    print "difference: ", meshes
    result=[]
    current = meshes[0]
    for n in range(1,len(meshes)):
        m.select(cl=1)
        tmp     = m.listRelatives(current,p=1,f=1)
        if not tmp:
            tmp = current
        tmp3    = m.polyCBoolOp(current, meshes[n], op=2, ch=1, preserveColor=0)
        tmp2    = filter(lambda x: m.nodeType(x) == 'transform', tmp3)
        current = m.duplicate(tmp2,rc=1)
        try:
          m.delete( tmp )
          m.delete( tmp2 )
        except:
          pass


    return current

def union(node):
    meshes = traverse(node)
    print "union: ", meshes
    current = meshes[0]
    for n in range(1,len(meshes)):
        m.select(cl=1)
        tmp     = m.listRelatives(current,p=1,f=1)
        if not tmp:
            tmp = current
        tmp3    = m.polyCBoolOp(current, meshes[n], op=1, ch=1, preserveColor=0)
        tmp2    = filter(lambda x: m.nodeType(x) == 'transform', tmp3)
        current = m.duplicate(tmp2,rc=1)
        m.delete( tmp )
        m.delete( tmp2 )

        #if node[:7] == '__union':
        #    name = node.split('union_')[-1]
        #    m.select( current )
        #    m.rename( name )
        #    return name

    return current

def intersect(node):
    print node
    meshes = traverse(node)
    print "intersect: ", meshes
    current = meshes[0]
    for n in range(1,len(meshes)):
        m.select(cl=1)
        tmp     = m.listRelatives(current,p=1,f=1)
        if not tmp:
            tmp = current
        tmp3    = m.polyCBoolOp(current, meshes[n], op=3, ch=1, preserveColor=0, classification=1 )
        tmp2    = filter(lambda x: m.nodeType(x) == 'transform', tmp3)
        current = m.duplicate(tmp2,rc=1)
        m.delete( tmp )
        m.delete( tmp2 )

        # if node[:7] == '__union':
        #     name = node.split('union_')[-1]
        #     m.select( current )
        #     m.rename( name )
        #     return name

    return current

def instance(node):
    meshes = None;
    all = m.ls('dbool_*',dag=1, type='transform')+m.ls('____tmp__dbool_*',dag=1, type='transform')
    if not meshes:
        parent=m.listRelatives(node, p=1)
        _name = node.split('instance_')[-1]
        name = 'dbool%s' % ( ''.join(re.findall('[a-zA-Z]', _name)) )
        meshes = []
        print "instance:",name, map(lambda x: ''.join(re.findall('[a-zA-Z]', x)), all), filter(lambda x: name in ''.join(re.findall('[a-zA-Z]', x)), all)
        for each in filter(lambda x: name in ''.join(re.findall('[a-zA-Z]', x)), all):
            print each
            mesh = m.duplicate(each,rc=1, name='____tmp_%s' % each)
            print name, mesh,  m.getAttr( "%s.translateY" % node )
            m.setAttr( "%s.translateX" % mesh[0], m.getAttr( "%s.translateX" % node ) )
            m.setAttr( "%s.translateY" % mesh[0], m.getAttr( "%s.translateY" % node ) )
            m.setAttr( "%s.translateZ" % mesh[0], m.getAttr( "%s.translateZ" % node ) )
            m.setAttr( "%s.rotateX" % mesh[0], m.getAttr( "%s.rotateX" % node ) )
            m.setAttr( "%s.rotateY" % mesh[0], m.getAttr( "%s.rotateY" % node ) )
            m.setAttr( "%s.rotateZ" % mesh[0], m.getAttr( "%s.rotateZ" % node ) )
            m.setAttr( "%s.scaleX" % mesh[0], m.getAttr( "%s.scaleX" % node ) )
            m.setAttr( "%s.scaleY" % mesh[0], m.getAttr( "%s.scaleY" % node ) )
            m.setAttr( "%s.scaleZ" % mesh[0], m.getAttr( "%s.scaleZ" % node ) )
            # m.select(mesh[0], parent)
            # m.parent(r=1)
            meshes += mesh
    return meshes

def delete(node):
    global created
    meshes = None;
    all = m.ls('dbool_*',dag=1, type='transform')+m.ls('____tmp__dbool_*',dag=1, type='transform')
    if not meshes:
        name = node.split('delete_')[-1]
        name = ''.join(re.findall('[a-zA-Z_]', name))
        print "delete: ", name
        meshes = []
        for each in filter(lambda x: name in x, all):
            print each
            if m.objExists(each):
                m.delete(each)
    return meshes

def traverse(script):
    print "traverse:", script
    global created
    meshes=[]
    children = m.listRelatives(script,c=1,f=1)
    if not children:
        return []
    for each in children:
        if m.objExists(each):
            type=m.nodeType(each)
            node = each.split('|')[-1]
            if type == 'transform':
                if node[:12] == '__difference':
                    if not processed.has_key(each):
                        processed[each] = True
                        mesh = difference(each)
                        name = "dbool_%s" % node.split('difference_')[-1]
                        meshes.append(m.rename( mesh, name ))

                if node[:7] == '__union':
                    if not processed.has_key(each):
                        processed[each] = True
                        mesh = union(each)
                        name = "dbool_%s" % node.split('union_')[-1]
                        meshes.append(m.rename( mesh, name ))

                if node[:11] == '__intersect':
                    if not processed.has_key(each):
                        processed[each] = True
                        mesh = intersect(each)
                        name = "dbool_%s" % node.split('intersect_')[-1]
                        meshes.append(m.rename( mesh, name ))

                if node[:10] == '__instance':
                    if not processed.has_key(each):
                        processed[each] = True
                        print "====>", meshes, created
                        mesh = instance(each)
                        meshes.extend( mesh )

                if node[:8] == '__delete':
                    if not processed.has_key(each):
                        processed[each] = True
                        mesh = delete(each)

                else:
                    meshes += traverse(each)

            elif type == 'mesh':
                if not m.getAttr('%s.intermediateObject' % each):
                    meshes.append( each )

            for mesh in meshes:
                if m.objExists(mesh):
                    m.polyMergeVertex( mesh, d=0.01, am=1, ch=1 )
            # m.select(cl=1)

    return meshes

def bindToPrintable():
    printable = {}
    for each in m.ls('print_*',type='transform'):
        cn = cleanName(each.replace('print_',''))
        if cn not in printable:
            printable[cn] = []
        printable[cn].append(each)
    for dbool in m.ls("dbool_*",type='transform'):
        realName = cleanName( dbool.replace('dbool_','') )
        print realName , filter(lambda x: realName==x, printable)
        for found in filter(lambda x: realName==x, printable):
            for printNode in printable[found]:
                dboolMesh = m.ls(dbool, dag=1, type='mesh')[0]
                printMesh = m.ls(printNode, dag=1, type='mesh')[0]
                print "mskin:", dboolMesh , printMesh
                try: m.connectAttr('%s.outMesh' % dboolMesh, '%s.inMesh' % printMesh, f=1);
                except: pass

def NormalAngle(degree=30):
    for each in m.ls(sl=1,type='mesh',dag=1,ni=1):
        m.polySoftEdge( each, angle=degree, ch=1 )

def cleanUp():
    ''' remove all created dbool_*, and unhide all scripts '''
    m.delete(m.ls('|dbool_*'))
    m.delete(m.ls("__tmp*"))
    for n in m.ls("|__script*"):
        m.setAttr("%s.visibility" % n, 1)

def mskin():
    '''
    turn all meshes into an instance of the first
    (connect the first outMesh into all others inMesh)
    '''
    sl = m.ls(sl=1,dag=1,ni=1,type='mesh',)
    for n in range(1,len(sl)):
        m.connectAttr('%s.outMesh' % sl[0], '%s.inMesh' % sl[n], f=1);


def run():
    ''' executa all __script* groups in the DAG root. '''
    global created
    old=[]
    meshes = []
    disabled = []

    cleanUp()

    try: disabled=m.listConnections('disable.dagSetMembers')
    except: True

    # dont execute scripts that are inside a display layer and are not visible!
    for each in m.ls(type='displayLayer'):
        if not m.getAttr('%s.visibility' % each):
            disabled += m.editDisplayLayerMembers(each,q=1)

    scripts=m.ls('__scrip*')
    def natural_keys(text):
        '''
        alist.sort(key=natural_keys) sorts in human order
        http://nedbatchelder.com/blog/200712/human_sorting.html
        (See Toothy's implementation in the comments
        '''
        res = [ atoi(c) for c in re.split(r'(\d+)', text) if c.isdigit() ]
        if not res:
            res = [text]
        return [res[0]]
    scripts.sort(key=natural_keys)
    print scripts

    for script in scripts:
        if script not in disabled:
            # move the script transform to 0,0,0
            transform=m.getAttr("%s.translate" % script)[0]
            m.setAttr( "%s.translate" % script, 0.0, 0.0, 0.0 )

            # execute
            print script, transform
            old.extend(meshes)
            m.duplicate(script,rc=1,name='__tmp')
            m.duplicate('__tmp',rc=1,name='__tmp2')
            m.delete('__tmp')
            m.hide(script)
            meshes = traverse('__tmp2')
            created.extend( meshes )
            m.delete('__tmp2')

            # move the script and the created meshes transforms back to original position
            m.setAttr( "%s.translate" % script, transform[0], transform[1], transform[2] )
            print meshes
            for mesh in [ x for x in meshes if 'dbool_' in x[0:7] ]:
                if m.objExists(mesh):
                    m.setAttr( "%s.translate" % mesh, transform[0], transform[1], transform[2] )

            # attach models to print_* equivalent!
            try:
                bindToPrintable()
            except: pass


    if m.ls('____tmp_*'):
    	m.delete('____tmp_*')
    if m.ls('__tmp*'):
    	m.delete('__tmp*')

    # noIntermediate = m.ls("dbool_*",dag=1,type='mesh',l=1,noIntermediate=1)
    # for each in filter(lambda x: x not in noIntermediate, m.ls("dbool_*",dag=1,type='mesh',l=1,noIntermediate=0)):
    #     m.delete(each.split('|')[1])

    try:
        bindToPrintable()
    except: pass
