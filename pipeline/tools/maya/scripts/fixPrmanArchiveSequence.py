

def fix():
    import sys
    import maya.cmds as m
    from maya.mel import eval as meval
    for each in m.ls(type='RenderManArchive'):
        if not m.objExists( "%s.filename_back" % each):
           m.addAttr( each, ln="filename_back", dt="string")
           t=str(m.getAttr('%s.filename' % each))
        else:
           t=str(m.getAttr('%s.filename_back' % each))
        if t and '<f4>' in t:

            if not m.getAttr('%s.filename_back' % each):
                m.setAttr('%s.filename_back' % each, t, type='string')

            frame='%04d' % meval('farmFrame')
            t_new = t.replace('<f4>',frame)
            sys.stderr.write("\nfixing filename on node %s:\n\t%s\n\t%s\n" % (each, t, t_new) )
            m.setAttr('%s.filename' % each, t_new, type='string')
