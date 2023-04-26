#include <stdio.h>

void main() {

    int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int n = sizeof(a)/sizeof(a[0]);
    int min = a[0];

    for(int i=1; i<n; i++)
        if(a[i] < min)
            min = a[i];

    printf("min=%d\n", min);
}
