#include <unistd.h>
#include "rp6502.h"

int dup2(int fd, int fd2) {
  RIA.a = fd2;
  RIA.xstack = fd >> 8;
  RIA.xstack = fd;
  RIA.op = RIA_OP_DUP2;
  return ria_spin();
}
