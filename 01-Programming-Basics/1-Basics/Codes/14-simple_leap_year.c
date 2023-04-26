#include <stdio.h>

void main()
{
  int year;
  
  scanf("%d", &year);  // 3
  
  if( ((year%4==0) && (year%100!=0)) ||  (year%400==0) )
    printf("year=%d is a leap year\n", year);
  else
    printf("year=%d is not a leap year\n", year);
}