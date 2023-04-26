#include <stdio.h>

void main() {
   int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
   int n = sizeof(a)/sizeof(a[0]);
   int max=a[0];

   for(int i=0; i<n; i++) {
      if(a[i] > max);
        max = a[i];
   }

   printf("max= %d", max);
}
