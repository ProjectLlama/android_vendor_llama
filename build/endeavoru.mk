#
# HTC ONE X CONFIG
#	MAINTAINED BY BENJAMINGWYNN
#

### Project Llama configuration

# Bootanimation
BOOTANIMATION_NAME := XHDPI
# Ohhai Benjamin!
DEVICE_MAINTAINER := benjamingwynn

# This is an official build
LLAMA_OFFICIAL := true

### Specify phone tech before including full_phone
$(call inherit-product, vendor/llama/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := ENDEAVORU

### Call Project Llama stuff.
$(call inherit-product, vendor/llama/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/llama/config/nfc_enhanced.mk)

# Inherit device configuration
$(call inherit-product, device/htc/endeavoru/full_endeavoru.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := endeavoru
PRODUCT_NAME := llama_endeavoru
PRODUCT_BRAND := htc_europe
PRODUCT_MODEL := HTC One X
PRODUCT_MANUFACTURER := HTC
LLAMA_DEVICE := endeavoru
#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=endeavoru BUILD_FINGERPRINT="projectllama/llama/endeavoru:4.1.2/llama/01:user/release-keys" PRIVATE_BUILD_DESC="llama-user 4.1.2 onex endeavoru release-keys"
