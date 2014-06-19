#
# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Don't build for unbundled branches
ifeq (,$(TARGET_BUILD_APPS))

LOCAL_PATH := $(call my-dir)

LIBCXXRT_SRC_FILES := \
	src/auxhelper.cc \
	src/cxa_atexit.c \
	src/cxa_finalize.c \
	src/dynamic_cast.cc \
	src/exception.cc \
	src/guard.cc \
	src/libelftc_dem_gnu3.c \
	src/memory.cc \
	src/stdexcept.cc \
	src/terminate.cc \
	src/typeinfo.cc \

LIBCXXRT_CFLAGS := \
	-I$(LOCAL_PATH)/src/ \

LIBCXXRT_RTTI_FLAG := -frtti
LIBCXXRT_CPPFLAGS := \
	-std=c++11 \
	-fexceptions \

include $(CLEAR_VARS)
LOCAL_MODULE := libcxxrt
LOCAL_CLANG := true
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := $(LIBCXXRT_SRC_FILES)
LOCAL_CFLAGS := $(LIBCXXRT_CFLAGS)
LOCAL_CPPFLAGS := $(LIBCXXRT_CPPFLAGS) -DNO_LIBDL
LOCAL_RTTI_FLAG := $(LIBCXXRT_RTTI_FLAG)
LOCAL_WHOLE_STATIC_LIBRARIES := libunwindbacktrace
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
include $(BUILD_STATIC_LIBRARY)

ifneq ($(HOST_OS),darwin)
include $(CLEAR_VARS)
LOCAL_MODULE := libcxxrt
LOCAL_CLANG := true
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := $(LIBCXXRT_SRC_FILES)
LOCAL_CFLAGS := $(LIBCXXRT_CFLAGS)
LOCAL_CPPFLAGS := $(LIBCXXRT_CPPFLAGS)
LOCAL_RTTI_FLAG := $(LIBCXXRT_RTTI_FLAG)
LOCAL_WHOLE_STATIC_LIBRARIES := libunwindbacktrace
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
LOCAL_MULTILIB := both
include $(BUILD_HOST_STATIC_LIBRARY)
endif

endif  # TARGET_BUILD_APPS
