# Configuration for Linux on ARM.
# Generating binaries for the ARMv7-a architecture and higher with NEON
#
ARCH_ARM_HAVE_ARMV7A            := true
ARCH_ARM_HAVE_VFP               := true
ARCH_ARM_HAVE_VFP_D32           := true
ARCH_ARM_HAVE_NEON              := true


ifeq (,$(filter-out krait cortex-a15, $(strip $(TARGET_CPU_VARIANT))))
	arch_variant_cflags := -march=armv7-a -mtune=cortex-a15
else ifeq (,$(filter-out scorpion cortex-a9, $(strip $(TARGET_CPU_VARIANT))))
	arch_variant_cflags := -march=armv7-a -mtune=cortex-a9
else ifeq ($(strip $(TARGET_CPU_VARIANT)),cortex-a8)
	arch_variant_cflags := -march=armv7-a -mtune=cortex-a8
else ifeq ($(strip $(TARGET_CPU_VARIANT)),cortex-a7)
	arch_variant_cflags := -mcpu=cortex-a7
else
	arch_variant_cflags := -march=armv7-a
endif

arch_variant_cflags += \
    -mfloat-abi=softfp \
    -mfpu=neon

ifeq (,$(filter-out scorpion cortex-a8, $(strip $(TARGET_CPU_VARIANT))))
arch_variant_ldflags := \
	-Wl,--fix-cortex-a8
else
arch_variant_ldflags :=
endif
