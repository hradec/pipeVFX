
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

if check_nuke_version_and_os('11.1', 'LINUX', print_error_message=True):
    import os
    # add icons and plugin_libs directories to nuke path
    nuke.pluginAddPath('./icons')
    nuke.pluginAddPath('./plugin_libs')

    # preload KeenTools so all the nodes will be available
    if os.path.exists('%s/KeenTools' % os.path.dirname(__file__)):
        nuke.load('KeenTools')
    else:
        print('loading KeenTools for Nuke11.1 LINUX skipped')
else:
    print('loading KeenTools for Nuke11.1 LINUX skipped')
