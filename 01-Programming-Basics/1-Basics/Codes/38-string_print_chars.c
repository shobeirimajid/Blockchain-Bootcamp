#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "Hello World";

    int i=0;
    while(str[i] != '\0') {
        printf("%c \n", str[i]);
        i++;
    }
}


// str : |H|e|l|l|o| |W|o|r|l|d|\0|
