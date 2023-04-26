#include <stdio.h>

void main()
{
  int number;
  int isPrime;
  scanf("%d", &number);
  isPrime = 1;
  
  for(int i=2; i<number; i++) {
    if(number%i == 0)
      isPrime = 0;
  }
  
  if(isPrime)
    printf("%d is Prime.\n", number);
  else
    printf("%d is not Prime.\n", number);
}