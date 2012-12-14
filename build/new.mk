#
# HTC ONE X CONFIG
#	MAINTAINED BY BENJAMINGWYNN
#

### Project Llama configuration

# Bootanimation
BOOTANIMATION_NAME := XHDPI
OVERLAY_TARGET := pa_xhdpi
# Ohhai Benjamin!
DEVICE_MAINTAINER := benjamingwynn

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

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=endeavoru BUILD_FINGERPRINT="htc_europe/endeavoru/endeavoru:4.0.4/IMM76D/89015.2:user/release-keys" PRIVATE_BUILD_DESC="2.17.401.2 CL89015 release-keys"

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := endeavoru
PRODUCT_NAME := cm_endeavoru
PRODUCT_BRAND := htc_europe
PRODUCT_MODEL := HTC One X
PRODUCT_MANUFACTURER := HTC
