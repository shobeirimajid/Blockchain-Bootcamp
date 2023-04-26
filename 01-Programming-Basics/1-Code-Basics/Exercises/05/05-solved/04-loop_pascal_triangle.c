#include <stdio.h>

int fact(int n) {
   int f;
   for(f=1; n>1; n--)
      f = f * n;
   return f;
}

int ncr(int n,int r) {
   return fact(n) / ( fact(n-r) * fact(r) );
}

void main() {
   int n=5;

   for(int i=0; i<=n; i++) {
      for(int j=0; j<=n-i; j++)
         printf("  ");

      for(int j=0; j<=i; j++)
         printf(" %3d", ncr(i, j));

      printf("\n");
   }
}
