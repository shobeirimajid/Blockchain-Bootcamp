#include <stdio.h>

void main() {
  int a, b, fib, terms;
  scanf("%d", &terms);	// number of terms.
  
  a = 0;
  b = 1;
  
  printf("%d %d ", a, b);
  
  for(int i=1; i<=terms-2; i++) {
    fib = a+b;
    printf("%d ", fib);
    
    // a , b , fib
    a = b;
    b = fib;
  }
}