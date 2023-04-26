#include <stdio.h>

int getMax( int set[] ) {
   int i, max;
   
   max = set[0];
   i = 1;    
   while( i < 5 ) {
      if( max <  set[i] ) {
         max = set[i];
      }
      i = i + 1;
   }
   return max;
}
main() {
   int set1[5] = {10, 20, 30, 40, 50};
   int set2[5] = {101, 201, 301, 401, 501};
   int max;

   /* Process first set of numbers available in set1[] */
   max = getMax(set1);
   printf("Max in first set = %d\n", max );
    
   /* Now process second set of numbers available in set2[] */
   max = getMax(set2);
   printf("Max in second set = %d\n", max );
}