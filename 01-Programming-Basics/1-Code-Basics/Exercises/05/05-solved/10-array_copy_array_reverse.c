#include <stdio.h>

void main() {
   int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
   int n = sizeof(a)/sizeof(a[0]);
   int copied[n];
   int j=n-1;


   for(int i=0; i<n; i++) {
      copied[j] = a[i];
      j--;
   }

   printf("    a -> copied \n");

   for(int i=0; i<n; i++)
      printf("   %2d        %2d\n", a[i], copied[i]);
}
