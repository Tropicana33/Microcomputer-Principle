#include <stdio.h>
#include <conio.h>
#include "ApiExusb.h"
#pragma comment(lib,"ApiExusb.lib")
byte Count=0x01;
void IntS();
void main()
{
	if(!Startup())
	{
		printf("ERROR:Open Device Error!\n");
		return;
	}
	printf("Press DMC !Press any key to exit!\n");
	RegisterLocalISR(IntS,3);
	EnableIntr();
	PortWriteByte(0x28b,0xa0);
	PortWriteByte(0x28b,0x0d);
	while(!kbhit());
	DisableIntr();
	Cleanup();
}
void IntS()
{
	
	PortWriteByte(0x288,Count);
	printf("This is a Interrupt!Out=%x\n",Count);
	Count<<=1;
	if(Count==0)
		exit(0);
	Sleep(1000);
	
	
}
