/*******************************/
/*     可编程并行接口（二）    */
/*   8255方式1输出实验 (A口)   */
/*******************************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

int Count=0x01;		/*响应中断次数为8*/
void IntS();
void main()
{
	printf("--------------------EXP21_10_8255-1_1---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (L0-L7)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. 8255 (PC3) === TPC (IRQ)\n");
	printf("4. 8255 (PC6) === (K8(DMC))\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())	/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Press DMC!Press any key to exit!\n");
	RegisterLocalISR(IntS);		/*注册中断程序*/
	EnableIntr();		/*开中断*/
	PortWriteByte(0x28b,0xa8);		/*设8255工作方式1输出*/
	PortWriteByte(0x28b,0x0d);		/*将PC6置位*/
	while(!kbhit()) Sleep(10);
	DisableIntr();	/*关中断*/
	Cleanup();		/*关闭设备*/
}
void IntS()
{
	PortWriteByte(0x288,Count);		/*从PA口输出i,初值为0x80*/
	printf("This is a Intrupt! Out = %x \n",Count);
	Count<<=1;			/*Count左移一位*/
	if(Count == 0x100)
		exit(0);
}
