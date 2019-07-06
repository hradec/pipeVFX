#!/bin/python2


import os
import pipe



prman = pipe.apps.prman()
prman.fullEnvironment()
prman.expand()

denoise = os.environ['RMANTREE']+'/bin/denoise'

args = ' --crossframe --override filterLayersIndependently true --image_variance.{$d,$d,$d}.exr diffuse_key.{%d,6,7}.exr specular_key.{5,6,7}.exr'







#
