#include <stdio.h>

int fact(int n) {
  if(n==1)
    return 1;
  else
    return n*fact(n-1);
}

int nCr(int n, int r) {
  return fact(n) / (fact(n-r) * fact(r));
}

int nPr(int n, int r) {
  return fact(n) / fact(n-r);
}

void main() {
  int n, r;
  scanf("%d", &n);
  scanf("%d", &r);
  
  printf("%dC%d = %d\n", n, r, nCr(n,r));
  printf("%dP%d = %d\n", n, r, nPr(n,r));
}