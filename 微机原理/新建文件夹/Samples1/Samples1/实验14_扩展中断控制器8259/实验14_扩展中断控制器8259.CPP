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
       BYTE   data;
	PortWriteByte(0x2B0,0x0C);
       PortReadByte(0x2B0,&data);
       data=data&0x07;
       if  (data==0x00)
           printf("Hello! This is interrupt    *  0  * \n");
       else if (data==0x01)
           printf("Hello! This is interrupt    *  1  * \n");
       else if (data==0x02)
           printf("Hello! This is interrupt    *  2  * \n");
       else if (data==0x03)
           printf("Hello! This is interrupt    *  3  * \n");
       else if (data==0x04)
           printf("Hello! This is interrupt    *  4  * \n");
       else if (data==0x05)
           printf("Hello! This is interrupt    *  5  * \n");
       else if (data==0x06)
           printf("Hello! This is interrupt    *  6  * \n");
       else if (data==0x07)
           printf("Hello! This is interrupt    *  7  * \n");
       else
    
       PortWriteByte(0x2B0,0x20);
       PortWriteByte(0x2B0,0x13);
}
void main()
{
	
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Please Press DMC! Press any key to exit!\n");
	PortWriteByte(0x2B0,0x13);
       PortWriteByte(0x2B1,0xB0);
       PortWriteByte(0x2B1,0x00);
       PortWriteByte(0x2B1,0x00);

	RegisterLocalISR(MyISR);	/*注册中断程序*/
	EnableIntr();		/*开中断*/
       
	while(!kbhit())
	{

		//PortWriteByte(0x288,0x00);
		//Sleep(100);

	}
	DisableIntr();		/*关中断*/
	Cleanup();			/*关闭设备*/
}

 