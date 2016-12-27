/**********************/
/*     竞赛抢答器     */
/**********************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

int led[8]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07};	/*数码表*/
int num[8]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
int  i=0;

void main()
{
    printf("----------EXP7_1_I/O-----------\n");
	printf("1. I/O (2A0-2A7) === D (CLK)\n");
	printf("2. I/O (2A8-2AF) === D (RD)\n");
	printf("3. TPC (+5V) === D (D, SD)\n");
	printf("4. TPC (L7) === D (Q)\n");
	printf("Press any key to begin!\n\n");
	getch();
	printf("Press any key to exit!\n");
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	while(!kbhit())			/*判断是否有键按下*/
	{
	 	PortWriteByte(0x2A0,0x10);	/*或PortReadByte(0x2A0, &data)*/
	 	Sleep(1000);		/*延迟一秒钟*/
	 	PortWriteByte(0x2A8,0x10);	/*或PortReadByte(0x2A8, &data)*/
		Sleep(1000);		/*延迟一秒钟*/
	}
	Cleanup();				/*关闭设备*/
}
