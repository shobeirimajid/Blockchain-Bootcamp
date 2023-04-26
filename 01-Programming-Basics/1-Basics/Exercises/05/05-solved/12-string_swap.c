#include <stdio.h>

int main() {
   char str1[] = "TajMahal";
   char str2[] = "Dazzling";

   int i = 0;

   //Character by Character approach

   printf("\nBefore Swapping\n");
   printf("str1: %s \n", str1);
   printf("str2: %s \n", str2);

   while(str1[i] != '\0') {
      char temp;
      temp = str1[i];
      str1[i] = str2[i];
      str2[i] = temp;

      i++;
   }

   printf("\nAfter Swapping\n");
   printf("str1: %s \n", str1);
   printf("str2: %s \n", str2);
}
