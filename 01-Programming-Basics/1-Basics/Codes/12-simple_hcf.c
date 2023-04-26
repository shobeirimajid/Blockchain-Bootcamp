#include<stdio.h>

void main() 
{
   int a, b, hcf;

   scanf("%d", &a); //12
   scanf("%d", &b); // 16

   while(a!=b) {
	   if(a>b)
		   a = a-b;
	   else
		   b = b-a;
   }
   hcf = a;	// a=b
   
   printf("HCF = %d", hcf); //4
}