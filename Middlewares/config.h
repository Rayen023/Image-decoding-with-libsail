
#ifndef SAIL_CONFIG_H
#define SAIL_CONFIG_H

#define SAIL_VERSION_MAJOR 0
#define SAIL_VERSION_MINOR 9
#define SAIL_VERSION_PATCH 0

#define SAIL_VERSION_STRING "0.9.0"

#define SAIL_BUILD_VERSION(major, minor, patch) ((major << 16) | (minor << 8) | (patch))

#define SAIL_VERSION SAIL_BUILD_VERSION(0, 9, 0)

/* Unused when SAIL_COMBINE_CODECS is ON. */

#define SAIL_AZRTOS
/* #undef SAIL_WIN32 */
/* #undef SAIL_MINGW */
/* #undef SAIL_CYGWIN */
/* #undef SAIL_APPLE */

#define SAIL_HAVE_ALIGNAS

#ifdef SAIL_HAVE_ALIGNAS
    #define SAIL_ALIGNAS(x) _Alignas(x)
#else
    #define SAIL_ALIGNAS(x)
#endif

/* Do we compile for VCPKG (port or client)? */
/* #undef SAIL_VCPKG */

/* Build static libs. SAIL_SHARED_[ON|OFF] is a helper macro, use SAIL_STATIC instead. */
#define SAIL_SHARED_OFF

#ifdef SAIL_SHARED_OFF
    #define SAIL_STATIC
#endif

/* Combine all codecs into a single library. */
#define SAIL_COMBINE_CODECS

/* Buffer size to read from I/O sources to detect file types by magic numbers. */
#define SAIL_MAGIC_BUFFER_SIZE 16

#ifdef SAIL_AZRTOS
#include "fx_api.h"
#include "tx_api.h"
extern TX_BYTE_POOL sail_byte_pool;
extern FX_MEDIA sdio_disk;
#define sail_media &sdio_disk
#endif
#endif
