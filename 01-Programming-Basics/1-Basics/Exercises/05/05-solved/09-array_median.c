#include <stdio.h>

void swap(int *p, int *q) {
   int temp;
   temp = *p;
   *p = *q;
   *q = temp;
}

void sort(int a[],int n) {
   int temp;

   for(int i=0; i<n-1; i++) {
      for(int j=0; j<n-i-1; j++) {
         if(a[j+1] < a[j])
            swap(&a[j], &a[j+1]);
      }
   }
}

void main() {
   int a[] = {6,3,8,5,1};
   int n = sizeof(a)/sizeof(a[0]);

   sort(a,n);   // 1,3,5,6,8

   int medIdx = (n+1)/2 - 1;      // -1 as array indexing in C starts from 0

   printf("Median = %d ", a[medIdx]);
}
