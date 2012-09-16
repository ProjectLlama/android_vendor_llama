# Inherit common llama stuff
$(call inherit-product, vendor/llama/config/common.mk)

# Bring in all audio files
include frameworks/base/data/sounds/NewAudio.mk

# Include llama audio files
include vendor/llama/config/llama_audio.mk

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=CyanTone.ogg \
    ro.config.notification_sound=CyanMessage.ogg \
    ro.config.alarm_alert=CyanAlarm.ogg

PRODUCT_PACKAGES += \
  Mms

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/llama/prebuilt/common/bootanimation/320.zip:system/media/bootanimation.zip
endif
