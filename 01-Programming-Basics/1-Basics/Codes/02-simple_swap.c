#include <stdio.h>

void main()
{
  int a, b, temp;
  a = 10;
  b = 20;
  
  printf("[1]: a, b = %d\t%d\n", a, b);
  
  temp = a;
  a = b;
  b = temp;
  
  printf("[2]: a, b = %d\t%d\n", a, b);
}