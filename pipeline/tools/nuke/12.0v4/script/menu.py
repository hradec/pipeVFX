import nuke

nuke.menu('Nodes').addMenu('OpenImageDenoiser')
nuke.menu('Nodes').addCommand('OpenImageDenoiser/Denoiser', lambda: nuke.createNode('Denoiser'))

nuke.load('denoiser')
