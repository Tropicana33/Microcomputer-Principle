/******************/
/*    步进电机    */
/******************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	int buf = 0x33,d;
	printf("--------------------EXP27_19_BJDJ---------------------\n");
	printf("1. 8255 (PA0-PA3) === BJDJ (BA-BD)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. 8255 (PC0-PC7) === TPC (K0-K7)\n");
	printf("4. BJDJ (J5) === (BJDJ)\n");
	printf("Press any key to begin!\n\n");
	getch();
	printf("K0-K6 are speed control \n");
	printf("K0 is the lowest speed \n");
	printf("K6 is the highest speed \n");
	printf("K7 is the direct control \n");
	printf("press any key to return! \n");
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	PortWriteByte(0x28b,0x8b);		/*设置8255工作方式,C口输入, A口输出*/
	while(!kbhit())
	{	
		PortReadByte(0x28a,&data);
		if (data & 1) d = 1200;	
		else if (data & 2) d = 600;
		else if (data & 4) d = 500;
		else if (data & 8) d = 300;
		else if (data & 16) d = 200;
		else if (data & 32) d = 100;
		else if (data & 64) d = 50;
		else d = 0;
		if (d != 0)
		{
			Sleep(d);
			if (data & 128)
				buf = ((buf&1)<<7)|(buf>>1);
			else
				buf = ((buf&128)>>7)|(buf<<1);
			PortWriteByte(0x288,buf);
		}
		else
			PortWriteByte(0x288,0xff);
	}
	Cleanup();		/*关闭设备*/
}
