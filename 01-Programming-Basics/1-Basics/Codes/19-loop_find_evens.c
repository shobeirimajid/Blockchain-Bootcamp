#include <stdio.h>

void main()
{
  int start, end;
  scanf("%d", &start);
  scanf("%d", &end);
  
  for(int i=start; i<=end; i++) {
    if(i%2==0)
      printf("%d is even\n", i);
  }
}