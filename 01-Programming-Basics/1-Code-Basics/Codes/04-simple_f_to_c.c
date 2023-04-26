#include <stdio.h>

void main()
{
  float c, f;
  
  f = 50;
  c = (float) 5/9 * (f - 32);   // type casting
  
  printf("f = %.2f\n", f);
  printf("c = %.2f\n", c);
}