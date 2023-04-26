#include <stdio.h>
#include <string.h>

void main() {

    char str1[] = "Taj";
    char str2[] = "Mahal";

    int n1 = strlen(str1);
    int n2 = strlen(str2);

    char concat[n1+n2+1];
    concat[n1+n2] = '\0';
    int j=0;

    for(int i=0; i<n1; i++) {
        concat[j] = str1[i];
        j++;
    }

    for(int i=0; i<n2; i++) {
        concat[j] = str2[i];
        j++;
    }

    printf("\n str1:   %s", str1);
    printf("\n str2:   %s", str2);
    printf("\n concat: %s", concat);
}
