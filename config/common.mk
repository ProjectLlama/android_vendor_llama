PRODUCT_BRAND ?= llama

# To deal with CM9 specifications
# TODO: remove once all devices have been switched
ifneq ($(TARGET_BOOTANIMATION_NAME),)
TARGET_SCREEN_DIMENSIONS := $(subst -, $(space), $(subst x, $(space), $(TARGET_BOOTANIMATION_NAME)))
ifeq ($(TARGET_SCREEN_WIDTH),)
TARGET_SCREEN_WIDTH := $(word 2, $(TARGET_SCREEN_DIMENSIONS))
endif
ifeq ($(TARGET_SCREEN_HEIGHT),)
TARGET_SCREEN_HEIGHT := $(word 3, $(TARGET_SCREEN_DIMENSIONS))
endif
endif

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# clear TARGET_BOOTANIMATION_NAME in case it was set for CM9 purposes
TARGET_BOOTANIMATION_NAME :=

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/llama/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=dd-MM-yyyy \
    ro.com.android.dataroaming=false

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/llama/CHANGELOG.mkdn:system/etc/CHANGELOG-llama.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/llama/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/llama/prebuilt/common/bin/50-llama.sh:system/addon.d/50-llama.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/llama/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/etc/init.local.rc:system/etc/init.local.rc \
    vendor/llama/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/llama/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Nam configuration script
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/bin/modelid_cfg.sh:system/bin/modelid_cfg.sh

PRODUCT_COPY_FILES +=  \
    vendor/llama/proprietary/RomManager.apk:system/app/RomManager.apk \
    vendor/llama/proprietary/Term.apk:system/app/Term.apk \
    vendor/llama/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so \
    vendor/llama/prebuilt/common/apps/Superuser.apk:system/app/Superuser.apk

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/llama/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/llama/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# This is llama!
PRODUCT_COPY_FILES += \
    vendor/llama/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# T-Mobile theme engine
include vendor/llama/config/themes_common.mk

# Required llama packages
PRODUCT_PACKAGES += \
    Camera \
    Development \
    LatinIME \
    SpareParts \
    Superuser \
    Superuser.apk \
    su

# Other llama packages
PRODUCT_PACKAGES += \
    VideoEditor \
    VoiceDialer \
    SoundRecorder \
    Basic \
    LlamaTips \
    Trebuchet \
    DSPManager \
    SuperSU \
    libcyanogen-dsp \
    audio_effects.conf \
    LlamaWallpapers \
    Apollo \
    UnicornPorn \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

PRODUCT_PACKAGE_OVERLAYS += vendor/llama/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/llama/overlay/common

PRODUCT_VERSION_MAJOR = 10
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0-RC0

# Set llama_BUILDTYPE
ifdef llama_NIGHTLY
    llama_BUILDTYPE := NIGHTLY
endif
ifdef llama_EXPERIMENTAL
    llama_BUILDTYPE := EXPERIMENTAL
endif
ifdef llama_RELEASE
    llama_BUILDTYPE := RELEASE
endif

ifdef llama_BUILDTYPE
    ifdef llama_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        llama_BUILDTYPE := EXPERIMENTAL
        # Add leading dash to llama_EXTRAVERSION
        llama_EXTRAVERSION := -$(llama_EXTRAVERSION)
    endif
else
    # If llama_BUILDTYPE is not defined, set to UNOFFICIAL
    llama_BUILDTYPE := UNOFFICIAL
    llama_EXTRAVERSION :=
endif

ifdef llama_RELEASE
    llama_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(llama_BUILD)
else
    llama_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(llama_BUILDTYPE)-$(llama_BUILD)$(llama_EXTRAVERSION)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.llama.version=$(llama_VERSION) \
  ro.modversion=$(llama_VERSION)
