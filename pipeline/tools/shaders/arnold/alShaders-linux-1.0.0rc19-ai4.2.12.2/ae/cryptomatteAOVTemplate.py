import pymel.core as pm
from alShaders import *

class AEcryptomatteAOVTemplate(alShadersTemplate):
	controls = {}
	params = {}
	def setup(self):
		self.params.clear()
		self.params["passthrough"] = Param("passthrough", "Passthrough", "Plug your surface in here to trigger shader evaluation", "rgb", presets=None)
		self.params["crypto_asset_override"] = Param("crypto_asset_override", "Crypto asset override", "Override the cryptomatte asset string for this shader", "string", presets=None)
		self.params["crypto_object_override"] = Param("crypto_object_override", "Crypto object override", "Override the cryptomatte object string for this shader", "string", presets=None)
		self.params["crypto_material_override"] = Param("crypto_material_override", "Crypto material override", "Override the cryptomatte material string for this shader", "string", presets=None)
		self.params["aov_crypto_asset"] = Param("aov_crypto_asset", "Asset AOV name", "", "rgb", presets=None)
		self.params["aov_crypto_object"] = Param("aov_crypto_object", "Object AOV name", "", "rgb", presets=None)
		self.params["aov_crypto_material"] = Param("aov_crypto_material", "Material AOV name", "", "rgb", presets=None)

		self.addSwatch()
		self.beginScrollLayout()

		self.addCustomRgb("passthrough")
		self.beginLayout("AOVs", collapse=True)
		self.addControl("crypto_asset_override", label="Crypto asset override", annotation="Override the cryptomatte asset string for this shader")
		self.addControl("crypto_object_override", label="Crypto object override", annotation="Override the cryptomatte object string for this shader")
		self.addControl("crypto_material_override", label="Crypto material override", annotation="Override the cryptomatte material string for this shader")
		self.addControl("aov_crypto_asset", label="Asset AOV name", annotation="")
		self.addControl("aov_crypto_object", label="Object AOV name", annotation="")
		self.addControl("aov_crypto_material", label="Material AOV name", annotation="")
		self.endLayout() # END AOVs

		pm.mel.AEdependNodeTemplate(self.nodeName)
		self.addExtraControls()

		self.endScrollLayout()
