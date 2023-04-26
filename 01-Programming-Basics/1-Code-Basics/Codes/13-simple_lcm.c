#include<stdio.h>

void main() {
   int a, b, i, lcm;

   scanf("%d", &a);  // 3
   scanf("%d", &b);  // 4
   i = 1;

   while(1) {
	   if(i%a==0 && i%b==0){
		   lcm = i;
		   break;
	   }
	
	i++;	
   }

   printf("LCM=%d", lcm);	// 12
}