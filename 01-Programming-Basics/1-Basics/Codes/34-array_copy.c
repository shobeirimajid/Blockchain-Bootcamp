#include <stdio.h>

void main() {

    int original[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int n = sizeof(original)/sizeof(original[0]);
    int copied[n];

    for(int i=0; i<n; i++) {
        copied[i] = original[i];
    }

    printf("original -> copied \n");

    for(int i=0; i<n; i++) {
        printf("   %2d        %2d\n", original[i], copied[i]);
    }
}
