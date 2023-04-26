#include <stdio.h>
#include <string.h>

void main() {

    char str1[] = "advice";
    char str2[] = "advise";

    int i = 0;
    unsigned short isIdentical = 1;

    while(str1[i] != '\0') {
        if(str1[i] != str2[i]) {
            isIdentical = 0;
            break;
        }
        i++;
    }

    if(isIdentical)
        printf("'%s' and '%s' are identical \n", str1, str2);
    else
        printf("'%s' and '%s' are NOT identical \n", str1, str2);
}
