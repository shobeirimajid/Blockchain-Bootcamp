#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "TajMahal";    // length = 8
    char ch = 'a';
    int count=0;

    int i=0;
    while(str[i] != '\0') {
        if(str[i] == ch)
            count++;

        i++;
    }

    if(count>0)
        printf("Count if %c in '%s' = %d \n", ch, str, count);
    else
        printf("'%c' did not appear in '%s'\n", ch, str);
}

// idx : |0|1|2|3|4|5|6|7| 8|
// str : |T|a|j|M|a|h|a|l|\0|
