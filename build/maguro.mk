#
# SAMSUNG GALAXY NEXUS CONFIG
#	MAINTAINED BY DUDEMAN1996
#

### Project Llama configuration

# Bootanimation
BOOTANIMATION_NAME := XHDPI

# Ohhai Ivan!
DEVICE_MAINTAINER := dudeman1996

# This is an official build
LLAMA_OFFICIAL := true

### Specify phone tech before including full_phone
$(call inherit-product, vendor/llama/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := GN-GSM

### Call Project Llama stuff.
$(call inherit-product, vendor/llama/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/llama/config/nfc_enhanced.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/maguro/full_maguro.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := maguro
PRODUCT_NAME := llama_maguro
PRODUCT_BRAND := Google
PRODUCT_MODEL := Galaxy Nexus
PRODUCT_MANUFACTURER := Samsung

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=yakju BUILD_FINGERPRINT="projectllama/llama/maguro:4.1.1/llama/01:user/release-keys" PRIVATE_BUILD_DESC="llama-user 4.1.1 gnexus maguro release-keys"
