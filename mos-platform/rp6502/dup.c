#include <unistd.h>
#include "rp6502.h"

int dup(int fd) {
  RIA.a = fd;
  RIA.op = RIA_OP_DUP;
  return ria_spin();
}
