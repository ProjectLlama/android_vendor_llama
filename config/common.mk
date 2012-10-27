PRODUCT_BRAND ?= Project-Llama

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

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/llama/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Nam configuration script
PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/common/bin/modelid_cfg.sh:system/bin/modelid_cfg.sh

PRODUCT_COPY_FILES +=  \
    vendor/llama/prebuilt/common/app/Superuser.apk:system/app/Superuser.apk

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

# -- What version of Project Llama are we building?

#TODO: Change PRODUCT_VERSION_MAJOR and _MINOR to follow the current Android version automatically. 
PRODUCT_VERSION_MAJOR = 4
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_CODENAME_SMALL = 1
PRODUCT_VERSION_CODENAME = Hydrogen

# -- Uncomment this to change all weekly builds intto stable builds.
#LLAMA_BUILD_STABLE = true

# -- Set buildtype:

ifdef LLAMA_OFFICIAL
    LLAMA_BUILDTYPE := WEEKLY
    ifdef LLAMA_BUILD_STABLE
	LLAMA_BUILDTYPE := STABLE
    endif
endif

# -- Is it official?

ifdef LLAMA_BUILDTYPE
    # If the buildtype was defined above, don't do anything.
else
    # If the buildtype wasn't defined, call the build UNOFFICIAL.
    LLAMA_BUILDTYPE := UNOFFICIAL
endif

# -- Decide on the final version name:

ifdef LLAMA_BUILD_STABLE
    # llama_maguro-4.1-Hydrogen-1
    LLAMA_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_CODENAME)-$(PRODUCT_VERSION_CODENAME_SMALL)
else
    # llama_shooteru-4.1-2012-WEEK43.zip
    LLAMA_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y)-WEEK$(shell date -u +%W)
endif

#-- Tell build.prop our new settings

ifdef LLAMA_BUILD_STABLE
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.llama.codename=$(PRODUCT_VERSION_CODENAME)
      ro.llama.codenamesmall=$(PRODUCT_VERSION_CODENAME_SMALL)
endif

# Don't make any build.prop changes anymore if not building stable, we add the "Weekly" string in settings instead. This also allows us to translate it.

# TODO: Use the ro.llama.official flag for something.

ifdef DEVICE_MAINTAINER
    PRODUCT_PROPERTY_OVERRIDES += \
     ro.llama.maintainer=$(DEVICE_MAINTAINER)
     ro.llama.official=true
else
    PRODUCT_PROPERTY_OVERRIDES += \
     ro.llama.official=false
endif

# ParanoidAndroid Packages
PRODUCT_PACKAGES += \
    ParanoidPreferences \

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/llama/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/llama/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/llama/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

PRODUCT_COPY_FILES += \
    vendor/llama/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/llama/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

	
PRODUCT_PROPERTY_OVERRIDES += \
  ro.llamaversion=$(LLAMA_VERSION) \
  ro.llama.version=$(LLAMA_VERSION) \
  ro.modversion=$(LLAMA_VERSION)
