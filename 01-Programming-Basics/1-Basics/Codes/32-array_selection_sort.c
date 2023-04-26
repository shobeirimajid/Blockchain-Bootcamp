#include <stdio.h>

void selectionSort(int ary[], int n) {

    int min_idx;

    // One by one move boundary of unsorted subarray
    for(int i=0; i<n-1; i++) {

        // Find the minimum element in unsorted array
        min_idx = i;

        for(int j=i+1; j<n; j++)
            if(ary[j] < ary[min_idx])
                min_idx = j;

        // Swap the found minimum element with the first element
        if(min_idx != i) {
            int temp = ary[min_idx];
            ary[min_idx] = ary[i];
            ary[i] = temp;
        }
    }
}

void main() {

    int a[] = {64, 25, 12, 22, 11};
    int n = sizeof(a)/sizeof(a[0]);

    /* print unsorted array */
    printf("unsorted: ");
    for(int i=0; i<n; i++)
        printf("%d ", a[i]);
    printf("\n");

    selectionSort(a, n);

    /* print sorted array */
    printf("sorted: ");
    for(int i=0; i<n; i++)
        printf("%d ", a[i]);
    printf("\n");
}


// Selection Sort
// 64, 25, 12, 22, 11

// i=0    11, 25, 12, 22, 64
// i=1    11, 12, 25, 22, 64
// i=2    11, 12, 22, 25, 64
// i=3    11, 12, 22, 25, 64
