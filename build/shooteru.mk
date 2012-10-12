#
# HTC EVO 3D (GSM) CONFIG
#	MAINTAINED BY HELICOPTER88
#

### Project Llama configuration

# Bootanimation
BOOTANIMATION_NAME := HDPI

# Ohhai Domenico!
DEVICE_MAINTAINER := helicopter88

# This is an official build
LLAMA_OFFICIAL := true

### Specify phone tech before including full_phone
$(call inherit-product, vendor/llama/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := SHOOTERU

### Call Project Llama stuff.
$(call inherit-product, vendor/llama/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/htc/shooteru/full_shooteru.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := shooteru
PRODUCT_NAME := llama_shooteru
PRODUCT_BRAND := HTC
PRODUCT_MODEL := Evo 3D
PRODUCT_MANUFACTURER := HTC

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=yakju BUILD_FINGERPRINT="projectllama/llama/shooteru:4.1.1/shooteru/01:user/release-keys" PRIVATE_BUILD_DESC="llama-user 4.1.1 evo3g shooteru release-keys"
