#include <stdio.h>

void main()
{
  float inch, cm;
  
  inch = 5;
  cm = (float) 2.54 * inch;   // type casting
  
  printf("inch = %.2f\n", inch);
  printf("cm = %.2f\n", cm);
}