#include <stdio.h>

void main() {
  
  int number, fact;
  scanf("%d", &number);
  fact = 1;

  for(int i=1; i<=number; i++){
    fact = fact * i;  // fact *= i
  }

  printf("Factorial of %d= %d", number, fact);
}

// 1! = 1*1     = 1 * 0! = 1
// 2! = 1*2     = 2 * 1! = 2
// 3! = 1*2*3   = 3 * 2! = 6
// 4! = 1*2*3*4 = 4 * 3! = 24