#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "TajMahal";
    int n = strlen(str);        // n=8

    char reverse[n+1];          // reverse string
    reverse[n] = '\0';          // null at end


    // str      <-(i--)--
    // reverse  --(j++)->
    int i = n-1;
    int j = 0;
    while(i >= 0) {
        reverse[j] = str[i];
        j++;
        i--;
    }


   // str      -->
   // reverse  <--
   /*int i = 0;
   int j = n-1;
   while(j >= 0) {
      reverse[j] = str[i];
      j--;
      i++;
   }*/


   // str      -->
   // reverse  <--
   /*int j = n-1;
   for(int i=0; i<n; i++) {
     reverse[j] = str[i];
     j--;
   }*/


   // str      <--
   // reverse  -->
   /*int j = 0;
   for(int i=--n; i>=0; i--) {
     reverse[j] = str[i];
     j++;
   }*/


    printf("\n String:   %s", str);
    printf("\n Reverse:  %s", reverse);
}

/*
    index   : |0|1|2|3|4|5|6|7| 8  |
    str     : |T|a|j|M|a|h|a|l|null|
    reverse : |l|a|h|a|M|j|a|T|null|
*/
