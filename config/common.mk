PRODUCT_BRAND ?= llama

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

# Copy bootanimation
ifneq ($(BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/llama/prebuilt/common/bootanimation/bootanimation-$(BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/llama/prebuilt/common/bootanimation/bootanimation-HDPI.zip:system/media/bootanimation.zip
endif

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
    vendor/llama/prebuilt/common/apps/Superuser.apk:system/app/Superuser.apk

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/llama/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/llama/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# CM NFC
PRODUCT_COPY_FILES += \
    vendor/llama/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# T-Mobile theme engine
include vendor/llama/config/themes_common.mk

# CM/Android Packages
PRODUCT_PACKAGES += \
    Camera \
    Development \
    LatinIME \
    SpareParts \
    Superuser \
    Superuser.apk \
    su \
    VideoEditor \
    VoiceDialer \
    SoundRecorder \
    Basic \
    DSPManager \
    SuperSU \
    libcyanogen-dsp \
    audio_effects.conf \
    UnicornPorn \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs

# Project Llama packages
PRODUCT_PACKAGES += \
    LlamaWallpapers \
    ProTips \
    Slingshot \
    Pinata \
    PhoneMotion \
    ROMControl

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
ifdef LLAMA_NIGHTLY
    LLAMA_BUILDTYPE := NIGHTLY
endif
ifdef LLAMA_EXPERIMENTAL
    LLAMA_BUILDTYPE := EXPERIMENTAL
endif
ifdef LLAMA_RELEASE
    LLAMA_BUILDTYPE := RELEASE
endif

ifdef LLAMA_BUILDTYPE
    ifdef LLAMA_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        LLAMA_BUILDTYPE := EXPERIMENTAL
        # Add leading dash to llama_EXTRAVERSION
        LLAMA_EXTRAVERSION := -$(llama_EXTRAVERSION)
    endif
else
    # If llama_BUILDTYPE is not defined, set to UNOFFICIAL
    LLAMA_BUILDTYPE := UNOFFICIAL
    LLAMA_EXTRAVERSION :=
endif

ifdef LLAMA_RELEASE
    LLAMA_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(LLAMA_BUILD)
else
    LLAMA_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(LLAMA_BUILDTYPE)-$(llama_BUILD)$(LLAMA_EXTRAVERSION)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.llama.version=$(LLAMA_VERSION) \
  ro.modversion=$(LLAMA_VERSION)
