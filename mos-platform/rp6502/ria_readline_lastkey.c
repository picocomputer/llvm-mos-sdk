#include <errno.h>
#include <rp6502.h>

int ria_readline_lastkey(char *key, int size) {
  int i, ax;
  ax = ria_call_int(RIA_OP_RLN_LASTKEY);
  if (ax > size) {
    RIA.op = RIA_OP_ZXSTACK;
    errno = ENOMEM;
    return -1;
  }
  for (i = 0; i < ax; i++) {
    key[i] = ria_pop_char();
  }
  return ax;
}
