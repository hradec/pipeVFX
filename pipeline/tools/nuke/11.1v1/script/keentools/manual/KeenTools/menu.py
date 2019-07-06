import nuke

# TODO remove duplicate code
def nuke_version_corresponds(nuke_version):
    import nuke
    current_nuke_version = str(nuke.NUKE_VERSION_MAJOR) + '.' + str(nuke.NUKE_VERSION_MINOR)
    return current_nuke_version == nuke_version

def os_corresponds(os_suffix):
    from sys import platform
    if os_suffix == 'WIN':
        return platform == "win32"
    if os_suffix == 'LINUX':
        return platform == "linux" or platform == "linux2"
    if os_suffix == 'OSX':
        return platform == "darwin"
    assert(False)

def check_nuke_version_and_os(nuke_version, os_suffix, print_error_message=False):
    if not os_corresponds(os_suffix):
        if print_error_message:
            print('platform doesn\'t match')
        return False
    if not nuke_version_corresponds(nuke_version):
        if print_error_message:
            print('nuke version doesn\'t match')
        return False
    return True

if check_nuke_version_and_os('11.1', 'LINUX'):
    # add KeenTools menu to Nodes toolbar
    toolbar = nuke.menu('Nodes')
    kt_menu = toolbar.addMenu('KeenTools', icon='KeenTools.png')
    kt_menu.addCommand('GeoTracker', lambda: nuke.createNode('GeoTracker'), icon='GeoTracker.png')
    kt_menu.addCommand('PinTool', lambda: nuke.createNode('PinTool'), icon='PinTool.png')
    kt_menu.addCommand('ReadRiggedGeo', lambda: nuke.createNode('ReadRiggedGeo'), icon='ReadRiggedGeo.png')
    if 'ON' == 'ON':
        kt_menu.addCommand('FaceBuilder (beta)', lambda: nuke.createNode('FaceBuilder'), icon='FaceBuilder.png')
    if 'ON' == 'ON':
        kt_menu.addCommand('FaceTracker (beta)', lambda: nuke.createNode('FaceTracker'), icon='FaceTracker.png')
    if 'OFF' == 'ON':
        kt_menu.addCommand('FlowEvaluationTool', lambda: nuke.createNode('FlowEvaluationTool'), icon='KeenTools.png')
