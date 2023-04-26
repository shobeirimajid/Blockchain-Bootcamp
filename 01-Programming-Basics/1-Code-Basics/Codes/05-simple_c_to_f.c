#include <stdio.h>
void main()
{
  float c, f;
  
  c = 10.00;
  f = (float) 9/5 * c + 32;   // type casting
  
  printf("c = %.2f\n", c);
  printf("f = %.2f\n", f);
}