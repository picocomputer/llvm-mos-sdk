#include "rp6502.h"

void xram0_write(unsigned dest, const void *src, unsigned count) {
  const unsigned char *s = src;
  RIA.addr0 = dest;
  RIA.step0 = 1;
  while (count--)
    RIA.rw0 = *s++;
}

void xram1_write(unsigned dest, const void *src, unsigned count) {
  const unsigned char *s = src;
  RIA.addr1 = dest;
  RIA.step1 = 1;
  while (count--)
    RIA.rw1 = *s++;
}
