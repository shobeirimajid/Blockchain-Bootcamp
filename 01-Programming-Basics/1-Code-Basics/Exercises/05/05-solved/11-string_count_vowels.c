#include <stdio.h>

void main() {
   char str[] = "TajMahal";     // String Given
   int i = 0;
   int vowels = 0;            // Vowels counter
   int consonants = 0;        // Consonants counter

   while(str[i++] != '\0') {
      if(str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u' )
         vowels++;
      else
         consonants++;
   }

   printf("'%s' contains %d vowels.\n", str, vowels);
   printf("'%s' contains %d consonants.\n", str, consonants);
}
