#include <stdio.h>

void main() {
  
  double i, n, precision;
  scanf("%lf", &n);
  precision = 0.00001;
  
  for(i=1; i*i <= n; ++i);              //Integer part
  for(--i; i*i < n; i += precision);    //Fractional part
  
  printf("Square root of %d= %lf", (int)n, i);
}