#include <stdio.h>

void main()
{
  int number, check, rem, sum;
  scanf("%d", &number);
  check = number;
  
  while(check != 0) {
    rem = check % 10;
    sum = sum + (rem * rem * rem);
    check = check / 10;
  }
  
  if(sum == number)
    printf("%d is an armstrong.\n", number);
  else
    printf("%d is not armstrong.\n", number);
}