/************************/
/* 中断实验（中断方式） */
/************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")
int i;
void MyISR()
{
	PortWriteByte(0x288,0x55);
	Sleep(1*1000);
	printf("%d\n",i++);
}
void main()
{
	printf("--------------------EXP15_9_INT2---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (L0-L7)\n");
	printf("2. 8255 (CS) === TPC (288H-28FH)\n");
	printf("3. TPC (IRQ) === TPC (DMC)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Please Press DMC! Press any key to exit!\n");
	PortWriteByte(0x28b,0xa0);
	RegisterLocalISR(MyISR);	/*注册中断程序*/
	EnableIntr();		/*开中断*/
	while(!kbhit())
	{
		//PortWriteByte(0x28b,0xa0);
		PortWriteByte(0x288,0xaa);
		//Sleep(100);
//		printf("Main\n");
	}
	DisableIntr();		/*关中断*/
	Cleanup();			/*关闭设备*/
}
