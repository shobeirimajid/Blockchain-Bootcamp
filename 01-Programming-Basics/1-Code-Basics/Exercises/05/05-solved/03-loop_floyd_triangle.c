#include <stdio.h>

void main() {

    int n, k=1;
    scanf("%d", &n);


   for(int i=1; i<=n; i++) {
      for(int j=1; j<=i; j++)
         printf("%3d", k++);

      printf("\n");
   }
}
