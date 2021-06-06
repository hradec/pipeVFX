# code extracted from http://evgeniyzaitsev.com/2015/11/16/get-all-extra-attributes-maya-python-api/

import maya.cmds as cmds
import maya.OpenMaya as OpenMaya

def getMObjectFromSelection(node=None):
    m_selectionList = OpenMaya.MSelectionList()
    if not node:
        OpenMaya.MGlobal.getActiveSelectionList( m_selectionList )
    else:
        OpenMaya.MGlobal.getSelectionListByName( node, m_selectionList )
    m_node = OpenMaya.MObject()
    try:
        m_selectionList.getDependNode( 0, m_node )
        if ( m_node.isNull() ): return None
    except:
        return None
    return m_node

def getAllExtraAttributes(node):
    m_result = []
    m_obj         = getMObjectFromSelection(node)
    m_workMFnDep  = OpenMaya.MFnDependencyNode()
    m_workMDagMod = OpenMaya.MDagModifier()
    if ( m_obj ):
        m_objFn    = OpenMaya.MFnDependencyNode()
        m_objFn.setObject( m_obj ) # get function set from MObject
        m_objRef = m_workMFnDep.create( m_objFn.typeName() ) # Create reference MObject of the given type
        # -- get the list --
        m_result = _getAttrListDifference( m_obj,m_objRef )
        # --
        m_workMDagMod.deleteNode( m_objRef ) # set node to delete
        m_workMDagMod.doIt() # execute delete operation
    # return [ '%s.%s' % (node,x) for x in m_result ]
    return m_result

def _getAttrListDifference( m_obj, m_objRef ):
    m_objFn    = OpenMaya.MFnDependencyNode()
    m_objRefFn = OpenMaya.MFnDependencyNode()
    m_objFn.setObject( m_obj )
    m_objRefFn.setObject( m_objRef )
    m_result = []
    if ( m_objFn.attributeCount() > m_objRefFn.attributeCount() ):
        for i in range( m_objRefFn.attributeCount(), m_objFn.attributeCount()  ):
            m_atrr = m_objFn.attribute(i)
            m_fnAttr = OpenMaya.MFnAttribute( m_atrr )
            m_result.append( m_fnAttr.name() )
    return m_result
