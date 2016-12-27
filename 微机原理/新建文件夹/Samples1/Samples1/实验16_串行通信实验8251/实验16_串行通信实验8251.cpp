/******************/
/*８２５１串行通信*/
/******************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

void main()
{
	int	i;
	BYTE	data;
  	if(!Startup())	/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	PortWriteByte(0x283,0x16);		/*设8253计数器0工作方式*/
	Sleep(1*100);		/*延时*/
	PortWriteByte(0x280,52);		/*给8253通道0送初值*/
	Sleep(1*100);		/*延时*/
	for(i=0;i<3;i++)
	{
		PortWriteByte(0x2b9,0);		/*初始化8251,向8251控制端口送3个0*/
		Sleep(1*100);		/*延时*/
	}
	PortWriteByte(0x2b9,0x40);		/*复位8251*/
	Sleep(1*100);		/*延时*/
	PortWriteByte(0x2b9,0x4e);		/*设置为1个停止位，8个数据位，波特率因子为16*/
	Sleep(1*100);		/*延时*/
	PortWriteByte(0x2b9,0x27);		/*向8251送控制字允许其接收和发送*/
	Sleep(1*100);		/*延时*/
	printf("You can Press a key to start:\n");	/*提示*/
	printf("ESC is exit!\n");	/*提示*/
	for(;;)
	{
		do{
			PortReadByte(0x2b9,&data);
		}while(!(data&0x01));		/*发送未准备好则继续接收*/
		data = getch();
		if(data == 0x1b) exit(0);	/*若有ESC键按下则返回*/
		putchar(data);
		PortWriteByte(0x2b8,data+1);	/*发送*/
		Sleep(1*100);		/*延时*/
		do{
			PortReadByte(0x2b9,&data);
		}while(!(data&0x02));		/*接收没准备好则等待*/
		PortReadByte(0x2b8,&data);
		printf("%c",data);		/*准备好则将接收后的字符显示*/
   	}
	Cleanup();		/*关闭设备*/
}
