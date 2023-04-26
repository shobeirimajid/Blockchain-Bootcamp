#include <stdio.h>

void main()
{
  int a, b;
  
  //a = 10;
  //b = 50;
  
  scanf("%d", &a);
  scanf("%d", &b);
  
  if( a > b)
    printf("max is a = %d\n", a);
  else
    printf("max is b = %d\n", b);
}