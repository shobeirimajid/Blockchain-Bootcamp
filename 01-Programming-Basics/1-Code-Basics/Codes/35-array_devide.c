#include <stdio.h>

void main() {

    int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int n = sizeof(a)/sizeof(a[0]);
    int even[5], odd[5];
    int e=0, o=0;

    for(int i=0; i<n; i++) {
        if(a[i]%2 == 0) {
            even[e] = a[i];
            e++;
        } else {
            odd[o] = a[i];
            o++;
        }
    }

    printf("original: ");
    for(int i=0; i<n; i++)
        printf("%d ", a[i]);

    printf("\neven: ");
    for(int i=0; i<e; i++)
        printf("%d ", even[i]);

    printf("\nodd: ");
    for(int i=0; i<o; i++)
        printf("%d ", odd[i]);

}
