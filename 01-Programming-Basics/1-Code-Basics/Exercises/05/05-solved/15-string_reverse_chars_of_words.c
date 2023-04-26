#include <stdio.h>
#include <string.h>

void string_reverse(char str[]) {
   int j = strlen(str)-1;
   int i = 0;
   char temp;

   while(i < j) {
      temp = str[j];
      str[j] = str[i];
      str[i] = temp;

      i++;
      j--;
   }
}

void main (void) {
   char line[] = "Taj Mahal is one of the seven wonders of the world";
   int n = strlen(line);
   char reverse[100]="";
   char temp[50];
   int j;

   n = strlen(line);

   for(int i=0; i<n; i++) {

      for(j=0; i<n && line[i]!=' '; ++i,++j) {
         temp[j] = line[i];
      }

      temp[j] = '\0';

      string_reverse(temp);
      strcat(reverse, temp);
      strcat(reverse, " ");
   }

   printf("Original: %s\n", line);
   printf("Reversed: %s\n",reverse);
}
