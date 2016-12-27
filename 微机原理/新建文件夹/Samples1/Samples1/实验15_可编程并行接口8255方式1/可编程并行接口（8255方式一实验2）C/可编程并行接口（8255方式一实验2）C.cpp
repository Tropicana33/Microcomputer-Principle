/*******************************/
/*     可编程并行接口（二）    */
/*   8255方式1输入实验 (A口)   */
/*******************************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

int Count=8;		/*响应中断次数为8*/
void IntS();
void main()
{
	printf("--------------------EXP21_10_8255-1_2---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (K0-K7)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. 8255 (PC3) === TPC (IRQ)\n");
	printf("4. 8255 (PC4) === (K8(DMC))\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())	/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Press DMC!Press any key to exit!\n");
	PortWriteByte(0x28b,0xb8);		/*设8255工作方式1输入*/
  	PortWriteByte(0x28b,0x09);		/*将PC4置位*/
	RegisterLocalISR(IntS);		/*注册中断程序*/
	EnableIntr();		/*开中断*/
	while(!kbhit()) Sleep(10);
	DisableIntr();	/*关中断*/
	Cleanup();		/*关闭设备*/
}
void IntS()
{
	BYTE	data;
	PortReadByte(0x288,&data);		/*以16进制打印自A口输入的数据*/
	printf("This is a Intrupt! In = %x\n",data);
	Count--;
	if(Count == 0)
		exit(0);
}
