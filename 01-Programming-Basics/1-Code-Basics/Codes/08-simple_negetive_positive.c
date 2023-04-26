#include <stdio.h>

void main()
{
  int a = -10;
  
  if( a > 0)
    printf("%d is positive\n", a);
  else if(a == 0)
    printf("%d is zero\n", a);
  else
    printf("%d is negative\n", a);
}