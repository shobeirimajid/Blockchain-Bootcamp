#include <stdio.h>

void main()
{
  int a, b, hcf;
  
  scanf("%d", &a);  // 12
  scanf("%d", &b);  // 16
  
  for(int i=1; i<=a || i<=b; i++) {
    if(a%i == 0 && b%i == 0)
      hcf = i;
  }
  
  printf("HCF=%d\n", hcf);
}