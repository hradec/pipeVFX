import pymel.core as pm
from alShaders import *

class AEalLayerFloatTemplate(alShadersTemplate):
	controls = {}
	params = {}
	def setup(self):
		self.params.clear()
		self.params["layer1name"] = Param("layer1name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer1enabled"] = Param("layer1enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer1"] = Param("layer1", "Input", "The value of the background layer", "float", presets=None)
		self.params["layer1a"] = Param("layer1a", "Alpha", "The alpha of the background layer", "float", presets=None)
		self.params["layer2name"] = Param("layer2name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer2enabled"] = Param("layer2enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer2"] = Param("layer2", "Input", "The value to be layered", "float", presets=None)
		self.params["layer2a"] = Param("layer2a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)
		self.params["layer3name"] = Param("layer3name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer3enabled"] = Param("layer3enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer3"] = Param("layer3", "Input", "The value to be layered", "float", presets=None)
		self.params["layer3a"] = Param("layer3a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)
		self.params["layer4name"] = Param("layer4name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer4enabled"] = Param("layer4enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer4"] = Param("layer4", "Input", "The value to be layered", "float", presets=None)
		self.params["layer4a"] = Param("layer4a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)
		self.params["layer5name"] = Param("layer5name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer5enabled"] = Param("layer5enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer5"] = Param("layer5", "Input", "The value to be layered", "float", presets=None)
		self.params["layer5a"] = Param("layer5a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)
		self.params["layer6name"] = Param("layer6name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer6enabled"] = Param("layer6enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer6"] = Param("layer6", "Input", "The value to be layered", "float", presets=None)
		self.params["layer6a"] = Param("layer6a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)
		self.params["layer7name"] = Param("layer7name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer7enabled"] = Param("layer7enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer7"] = Param("layer7", "Input", "The value to be layered", "float", presets=None)
		self.params["layer7a"] = Param("layer7a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)
		self.params["layer8name"] = Param("layer8name", "Name", "A descriptive name for this layer", "string", presets=None)
		self.params["layer8enabled"] = Param("layer8enabled", "Enabled", "Toggle this layer on or off", "bool", presets=None)
		self.params["layer8"] = Param("layer8", "Input", "The value to be layered", "float", presets=None)
		self.params["layer8a"] = Param("layer8a", "Alpha", "The alpha used to blend this layer over the layers below.", "float", presets=None)

		self.addSwatch()
		self.beginScrollLayout()

		self.beginLayout("Background", collapse=False)
		self.addControl("layer1name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer1enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer1")
		self.addCustomFlt("layer1a")
		self.endLayout() # END Background
		self.beginLayout("Layer 2", collapse=False)
		self.addControl("layer2name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer2enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer2")
		self.addCustomFlt("layer2a")
		self.endLayout() # END Layer 2
		self.beginLayout("Layer 3", collapse=False)
		self.addControl("layer3name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer3enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer3")
		self.addCustomFlt("layer3a")
		self.endLayout() # END Layer 3
		self.beginLayout("Layer 4", collapse=False)
		self.addControl("layer4name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer4enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer4")
		self.addCustomFlt("layer4a")
		self.endLayout() # END Layer 4
		self.beginLayout("Layer 5", collapse=False)
		self.addControl("layer5name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer5enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer5")
		self.addCustomFlt("layer5a")
		self.endLayout() # END Layer 5
		self.beginLayout("Layer 6", collapse=False)
		self.addControl("layer6name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer6enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer6")
		self.addCustomFlt("layer6a")
		self.endLayout() # END Layer 6
		self.beginLayout("Layer 7", collapse=False)
		self.addControl("layer7name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer7enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer7")
		self.addCustomFlt("layer7a")
		self.endLayout() # END Layer 7
		self.beginLayout("Layer 8", collapse=False)
		self.addControl("layer8name", label="Name", annotation="A descriptive name for this layer")
		self.addControl("layer8enabled", label="Enabled", annotation="Toggle this layer on or off")
		self.addCustomFlt("layer8")
		self.addCustomFlt("layer8a")
		self.endLayout() # END Layer 8

		pm.mel.AEdependNodeTemplate(self.nodeName)
		self.addExtraControls()

		self.endScrollLayout()
