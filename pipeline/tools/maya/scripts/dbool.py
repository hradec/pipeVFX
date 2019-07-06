
import maya.cmds as m
import re
processed = {}
created = []
remove = []

m.delete(m.ls("dbool_*"))
m.delete(m.ls("__tmp*"))

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
        tmp3    = m.polyCBoolOp(current, meshes[n], op=3, ch=1, preserveColor=0)
        tmp2    = filter(lambda x: m.nodeType(x) == 'transform', tmp3)
        current = m.duplicate(tmp2,rc=1)
        m.delete( tmp )
        m.delete( tmp2 )
        
        if node[:7] == '__union':
            name = node.split('union_')[-1]
            m.select( current )
            m.rename( name )
            return name
            
    return current




def instance(node):
    meshes = None;#traverse(node)
    if not meshes:
        name = node.split('instance_')[-1]
        name = 'dbool%s' % ''.join(re.findall('[a-zA-Z]', name))
        meshes = []
        print "instance:",name, map(lambda x: ''.join(re.findall('[a-zA-Z]', x)), created), filter(lambda x: name in ''.join(re.findall('[a-zA-Z]', x)), created)
        for each in filter(lambda x: name in ''.join(re.findall('[a-zA-Z]', x)), created):
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
            #m.select([mesh[0],each])
            #m.parent(r=1)
            meshes += mesh
    return meshes
    
    
def delete(node):
    meshes = None;#traverse(node)
    if not meshes:
        name = node.split('delete_')[-1]
        name = ''.join(re.findall('[a-zA-Z_]', name))
        print "delete: ", name
        meshes = []
        for each in filter(lambda x: name in x, created):
            print each
            if m.objExists(each):
                m.delete(each)
    return meshes
    
    
    

def traverse(script):
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
            
    return meshes
            

old=[]
meshes = []
disabled = []
if m.objExists('disable'):
    disabled=m.listConnections('disable.dagSetMembers')
for script in m.ls('__scrip*'):
    if script not in disabled:
        print script
        old.extend(meshes)
        m.duplicate(script,rc=1,name='__tmp')
        m.duplicate('__tmp',rc=1,name='__tmp2')
        m.delete('__tmp')
        m.hide(script)
        meshes = traverse('__tmp2')
        created.extend( meshes )
        m.delete('__tmp2')

if m.ls('____tmp_*'):
	m.delete('____tmp_*')

noIntermediate = m.ls("dbool_*",dag=1,type='mesh',l=1,noIntermediate=1)
for each in filter(lambda x: x not in noIntermediate, m.ls("dbool_*",dag=1,type='mesh',l=1,noIntermediate=0)):
    m.delete(each.split('|')[1])



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
                print dboolMesh , printMesh 
                try: m.connectAttr('%s.outMesh' % dboolMesh, '%s.inMesh' % printMesh, f=1);
                except: pass


def run():
	bindToPrintable()



