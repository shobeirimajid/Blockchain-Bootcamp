#include <stdio.h>
#include <string.h>

void main() {

    char str[] = "simplyeasylearning";
    char temp;

    int i,j;
    int n = strlen(str);

    printf("before sorting: %s \n", str);

    for(int i=0; i<n-1; i++) {
        for(int j=i+1; j<n; j++) {
            if(str[j] < str[i]) {
                // swap
                temp = str[i];
                str[i] = str[j];
                str[j] = temp;
            }
        }
    }

    printf("after sorting: %s \n", str);
}

// idx : |0|1|2|3|4|5|6|7| 8|
// str : |T|a|j|M|a|h|a|l|\0|
// strlen(str) = 8
