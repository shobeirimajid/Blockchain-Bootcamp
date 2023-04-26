#include <stdio.h>

void main() {
   int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
   int n = sizeof(a)/sizeof(a[0]);
   int sum, i;
   float avg;

   sum = avg = 0;

   for(i=0; i<n; i++) {
      sum = sum + a[i];
   }

   avg = (float)sum/i;
   printf("Average of array values: %.2f", avg);
}
