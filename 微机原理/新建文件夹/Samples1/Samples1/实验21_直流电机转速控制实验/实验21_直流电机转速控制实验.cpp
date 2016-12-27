/******************/
/*    直流电机    */
/******************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	int d;
	printf("--------------------EXP28_20_ZLDJ---------------------\n");
	printf("1. 8255 (PC0-PC5) === TPC (K0-K5)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. 0832 (Ub) === ZLDJ (DJ)\n");
	printf("4. I/O (290-297) === 0832 (CS)\n");
	printf("5. ZLDJ (J6) === (ZLDJ)\n");
	printf("Press any key to begin!\n\n");
	getch();
	printf("K0-K5 are speed control \n");
	printf("K0 is the lowest speed \n");
	printf("K5 is the highest speed \n");
	printf("press any key to return!\n");
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	PortWriteByte(0x28b,0x8b);		/*设置8255工作方式,C口输入, A口输出*/
	while(!kbhit())
	{	
		PortWriteByte(0x290,0x80);	/*D/A 输出*/
		PortReadByte(0x28a,&data);
		if (data & 1) d = 15;	
		else if (data & 2) d = 25;
		else if (data & 4) d = 35;
		else if (data & 8) d = 50;
		else if (data & 16) d = 70;
		else if (data & 32) d = 80;
		else d = 0;
 		Sleep(200);
		PortWriteByte(0x290,0xff);	/*D/A 输出*/
		Sleep(d);		/*延时*/
	}
	Cleanup();		/*关闭设备*/
}
