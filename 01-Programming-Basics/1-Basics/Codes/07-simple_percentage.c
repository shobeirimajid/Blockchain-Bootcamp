#include <stdio.h>

void main()
{
  float percentage;
  int total = 1200;
  int part = 32;

  percentage = (float) part / total * 100.00;   // type casting
  
  // a / b * c   =>   (a / b) * c
  // a + b * c   =>   a + (b * c) ;
  
  printf("total = %d\n", total);
  printf("part = %d\n", part);
  printf("percentage = %.2f\n", percentage);
}