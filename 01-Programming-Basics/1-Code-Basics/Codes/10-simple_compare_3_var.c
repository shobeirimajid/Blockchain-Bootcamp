#include <stdio.h>

void main()
{
  int a, b, c;
  
  scanf("%d", &a);
  scanf("%d", &b);
  scanf("%d", &c);
  
  if(a > b && a > c)
    printf("a=%d is the max\n", a);
  else if(b > a && b > c)
    printf("b=%d is the max\n", b);
  else if(c > a && c > b)
    printf("c=%d is the max\n", c);
  else
    printf("Values are not unique");
}