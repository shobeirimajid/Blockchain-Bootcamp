#include <stdio.h>

int facorial(int n) {
  if(n==1)
    return 1;
  else
    return n*facorial(n-1);
}

void main() {
  int number, result;
  scanf("%d", &number);
  result = facorial(number);
  printf("Factorial of %d= %d", number, result);
}

// 1! = 1*1     = 1 * 0! = 1
// 2! = 1*2     = 2 * 1! = 2
// 3! = 1*2*3   = 3 * 2! = 6
// 4! = 1*2*3*4 = 4 * 3! = 24