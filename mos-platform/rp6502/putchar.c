#include "rp6502.h"
#include <stdio.h>
#include <unistd.h>

// Minimal stdio routes stderr here as well, so stderr text goes to fd 1.
// Full stdio writes it to fd 2, and a call to fflush(stderr) links it in.
void __putchar(char c) {
  ria_push_char(c);
  ria_set_a(STDOUT_FILENO);
  ria_call_int(RIA_OP_WRITE_XSTACK);
}
