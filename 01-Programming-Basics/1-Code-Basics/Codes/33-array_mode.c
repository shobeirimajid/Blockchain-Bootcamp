#include <stdio.h>

void main() {

    int a[] = {0, 6, 7, 2, 7};
    int n = sizeof(a)/sizeof(a[0]);

    int maxValue=0, maxCount=0, count=0;

    for(int i=0; i<n; i++) {

        count = 0;

        for(int j=0; j<n; j++) {
            if(a[j] == a[i])
                count++;
        }

        if(count > maxCount) {
            maxCount = count;
            maxValue = a[i];
        }

    }

    printf("Array: ");
    for(int i=0; i<n; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
    printf("Mode=%d\n", maxValue);
    printf("Count=%d\n", maxCount);
}
