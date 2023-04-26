#include <stdio.h>

void main() {
   int n, sum;
   
   scanf("%d", &n);
   
   for(i = 1; i <= n; i++) {
	   sum += i;
   }
   printf("sum=%d\n", sum);
}