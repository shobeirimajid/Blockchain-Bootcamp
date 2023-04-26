#include <stdio.h>

void main() {
   int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
   int n = sizeof(a)/sizeof(a[0]);

   for(int i=--n; i>=0; i--)
      printf("%d ", a[i]);
}
