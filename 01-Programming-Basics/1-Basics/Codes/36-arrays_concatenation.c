#include <stdio.h>

void main() {

    int even[] = {2, 4, 6, 8, 10};
    int odd[] = {1, 3, 5, 7, 9};

    int e_size = sizeof(even)/sizeof(even[0]);
    int o_size = sizeof(odd)/sizeof(odd[0]);

    int n = e_size + o_size;

    int concat[n];
    int j;


    for(int i=0; i<o_size; i++) {
        concat[j] = even[i];
        j++;
    }

    for(int i=0; i<e_size; i++) {
        concat[j] = odd[i];
        j++;
    }

    printf("Even: ");
    for(int i=0; i<e_size; i++)
        printf("%d ", even[i]);

    printf("\nOdd: ");
    for(int i=0; i<o_size; i++)
        printf("%d ", odd[i]);

    printf("\nConcat: ");
    for(int i=0; i<n; i++)
        printf("%d ", concat[i]);
}
