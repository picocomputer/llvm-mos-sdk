#include <unistd.h>
#include "rp6502.h"

// 1 for the console, CON: or TTY:, on any descriptor. A closed one is -1
// with errno set, and is not a terminal either.
int isatty(int fd) {
  RIA.a = fd;
  RIA.op = RIA_OP_ISATTY;
  return ria_spin() > 0;
}
