#include <stdint.h>
#include "kconfig.h"
#include "stddef.h"

#ifndef ROMFS_H
#define ROMFS_H

#define ROMFS_TYPE "romfs"

struct romfs_file {
    int fd;
    int device;
    int start;
    size_t len;
};

struct romfs_entry {
    uint32_t parent;
    uint32_t prev;
    uint32_t next;
    uint32_t isdir;
    uint32_t len;
    uint8_t name[PATH_MAX];
};

void romfs_server();

#endif
