/************************/
/* 可编程并行接口（一） */
/************************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()                                                    
{
	BYTE	data;
	printf("--------------------EXP10_4_8255-0---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (L0-L7)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. TPC (K0-K7) === 8255 (PC0-PC7)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Press any key to exit!");
	while(!kbhit())			/*有键按下则退出*/
	{
		PortWriteByte(0x28b,0x8b);	/*设8255为方式0,C口输入,A口输出*/
		PortReadByte(0x28a,&data);
  		PortWriteByte(0x288,data);	/*将C口输入的数据自A口输出*/
  	}
	Cleanup();				/*关闭设备*/
}
