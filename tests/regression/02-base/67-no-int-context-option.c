// PARAM: --enable ana.int.interval --disable ana.context.widen --enable ana.base.context.int --set annotation.goblint_context.base.no-int[+] f
#include <assert.h>

int f(int x) {
  if (x)
    return f(x+1);
  else
    return x;
}

int main () {
  int a = f(1);
  assert(!a);
  return 0;
}
