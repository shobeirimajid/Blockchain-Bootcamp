#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "TajMahal";
    int n = strlen(str);         // 8

    char strCopy[n+1];
    strCopy[n] = '\0';

    int i = 0;
    while(str[i] != '\0') {
        strCopy[i] = str[i];

        i++;
    }

    printf("\n str:     %s", str);
    printf("\n strCopy: %s", strCopy);
}
