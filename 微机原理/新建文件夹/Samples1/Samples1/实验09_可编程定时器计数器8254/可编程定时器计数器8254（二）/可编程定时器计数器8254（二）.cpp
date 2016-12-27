/******************************/
/* 可编程定时器／计数器（二） */
/******************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	printf("--------------------EXP9_3_8254_2---------------------\n");
	printf("1. 8254 (CLK0) === (1MHz) or (2MHz)\n");
	printf("2. TPC (+5V) === 8254 (GATE0,GATE1)\n");
	printf("3. 8254 (OUT0) === 8254 (CLK1)\n");
	printf("4. 8254 (OUT1) === LJB (Ui)\n");
	printf("5. I/O (280-287) === 8254 (CS)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
    PortWriteByte(0x283,0x36);			/*写方式字通道0方式3*/
  	PortWriteByte(0x280,1000%256);		/*送计数初值*/
  	PortWriteByte(0x280,1000/256);
  	PortWriteByte(0x283,0x76);			/*设置计数器1方式字*/
  	PortWriteByte(0x281,1000%256);		/*送计数初值*/
  	PortWriteByte(0x281,1000/256);
	Cleanup();				/*关闭设备*/
	printf("Press any key to exit!");
	getch();
}
