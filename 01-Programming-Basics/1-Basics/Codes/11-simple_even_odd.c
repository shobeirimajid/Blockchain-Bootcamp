#include <stdio.h>

void main()
{
  int n;
  
  scanf("%d", &n);
  
  if(n % 2 == 0)
    printf("n=%d is even\n", n);
  else
    printf("n=%d is odd\n", n);
}