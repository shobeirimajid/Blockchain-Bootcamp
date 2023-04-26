#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "TajMahal";    // length = 8

    int i=0;
    while(str[i] != '\0') {
        i++;
    }

    printf("Length of string '%s' = %d\n", str, i);
}

// idx : |0|1|2|3|4|5|6|7| 8|
// str : |T|a|j|M|a|h|a|l|\0|
