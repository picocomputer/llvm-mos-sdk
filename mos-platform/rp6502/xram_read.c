#include "rp6502.h"

void xram0_read(void *dest, unsigned src, unsigned count) {
  unsigned char *d = dest;
  RIA.addr0 = src;
  RIA.step0 = 1;
  while (count--)
    *d++ = RIA.rw0;
}

void xram1_read(void *dest, unsigned src, unsigned count) {
  unsigned char *d = dest;
  RIA.addr1 = src;
  RIA.step1 = 1;
  while (count--)
    *d++ = RIA.rw1;
}
