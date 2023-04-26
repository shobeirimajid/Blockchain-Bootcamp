#include <stdio.h>

void main()
{
  int start, end;
  
  scanf("%d", &start);
  scanf("%d", &end);
  
  for(int i=start; i<=end; i++) {
    printf("%d, ", i);
  }
}