#include <stdio.h>

void main() {
   int a[] = {101, 11, 3, 4, 50, 69, 7, 8, 9, 0};
   int n = sizeof(a)/sizeof(a[0]);
   int max, second;

   if(a[0] > a[1]) {
      max = a[0];
      second = a[1];
   } else {
      max = a[1];
      second = a[0];
   }

   for(int i=2; i<n; i++) {
      if(a[i] > max) {
         second = max;
         max = a[i];
      } else if(a[i] > second) {
         second = a[i];
      }
   }

    printf("Max: %d \n", max);
    printf("Second: %d \n", second);
}
