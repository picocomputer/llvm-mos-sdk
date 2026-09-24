#include <errno.h>
#include <rp6502.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int rmdir(const char *name) {
  unsigned char i = offsetof(f_stat_t, fattrib) + 1, attr;
  size_t namelen = strlen(name);
  if (namelen > 255) {
    errno = EINVAL;
    return -1;
  }
  while (namelen)
    ria_push_char(name[--namelen]);
  if (ria_call_int(RIA_OP_STAT) < 0)
    return -1;
  while (i--)
    attr = ria_pop_char();
  ria_drop();
  if (!(attr & 0x10)) {
    errno = EINVAL;
    return -1;
  }
  return remove(name);
}
