#include <stdio.h>

void main() {
	
   int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9,10};
   int n = sizeof(a)/sizeof(a[0]);

   for(int i=0; i<n; i++)
      printf("%d ", a[i]);
}