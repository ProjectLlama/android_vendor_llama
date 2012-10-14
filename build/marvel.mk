#
# HTC WILDFIRE S CONFIG
#	MAINTAINED BY BENJAMINGWYNN
#

### Project Llama configuration

# Bootanimation
BOOTANIMATION_NAME := MDPI

# Ohhai Benjamin!
DEVICE_MAINTAINER := benjamingwynn

# This is an official build
LLAMA_OFFICIAL := true

### Specify phone tech before including full_phone
$(call inherit-product, vendor/llama/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := MARVEL

# Inherit device configuration
$(call inherit-product, device/htc/marvel/marvel.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := marvel
PRODUCT_NAME := llama_marvel
PRODUCT_BRAND := htc_europe
PRODUCT_MODEL := Wildfire S
PRODUCT_MANUFACTURER := HTC
LLAMA_DEVICE := marvel
# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=yakju BUILD_FINGERPRINT="projectllama/llama/marvel:4.1.1/llama/01:user/release-keys" PRIVATE_BUILD_DESC="llama-user 4.1.1 wildfires marvel release-keys"
