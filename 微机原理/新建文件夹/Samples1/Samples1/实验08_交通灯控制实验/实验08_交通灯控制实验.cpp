/********************/
/*    交通灯控制    */
/********************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

void main()
{
	int	i;
	int	portc[]={0x24,0x44,0x04,0x44,0x04,0x44,0x04,
		0x81,0x82,0x80,0x82,0x80,0x82,0x80,0xff};
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Enter any key will return:\n");
	PortWriteByte(0x28b,0x80);
	for(;;)
	{
		for(i=0;i<14;i++)
		{
			PortWriteByte(0x28a,portc[i]);
			if(kbhit())
				exit(0);
			if(portc[i]&0x21)
				Sleep(1800);
			else
				Sleep(600);
		}
	}
	Cleanup();			/*关闭设备*/
}
