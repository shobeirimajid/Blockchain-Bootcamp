#include <stdio.h>

void main()
{
  int a, b;
  a = 10;
  b = 20;
  
  printf("[1]: a, b = %d\t%d\n", a, b);
  
  a = a + b;
  b = a - b;    // b = a - a + b = a
  a = a - b;    // a = a + b - a = b
  
  printf("[2]: a, b = %d\t%d\n", a, b);
}