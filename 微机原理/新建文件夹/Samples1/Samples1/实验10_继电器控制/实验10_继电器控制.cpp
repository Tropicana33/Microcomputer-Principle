/********************/
/*    继电器控制    */
/********************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void m_delay();
void main()
{
	printf("--------------------EXP12_6_JDQ---------------------\n");
	printf("1. 8254 (CLK0) === (1MHz) or (2MHz)\n");
	printf("2. TPC (+5V) === 8254 (GATE0,GATE1)\n");
	printf("3. 8254 (OUT0) === 8254 (CLK1)\n");
	printf("4. 8254 (OUT1) === 8255 (PA0)\n");
	printf("5. I/O (280-287) === 8254 (CS)\n");
	printf("6. 8255 (PC0) === JDQ (Ik)\n");
	printf("7. I/O (288-28F) === 8255 (CS)\n");
	printf("8. (J4) of JDQ === (JDQ)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("press any key to return!\n");
	PortWriteByte(0x28b,0x90);		/*设置8255为A口输入C口输出*/
	while(true)
	{
		PortWriteByte(0x28b,1);		/*PC0置位接通继电器*/
		m_delay();					/*延时5S*/
		PortWriteByte(0x28b,0);		/*PC0复位断开继电器*/
		m_delay();					/*延时5S*/
	}
	Cleanup();				/*关闭设备*/
}
void m_delay()
{	
	BYTE	data;
	PortWriteByte(0x283,0x36);		/*设8254计数器0工作方式3*/
	PortWriteByte(0x280,10000%256);	/*先写计数器初值10000的低字节*/
	PortWriteByte(0x280,10000/256);	/*后写计数器初值10000的高字节*/
	PortWriteByte(0x283,0x70);		/*设8254计数器1工作方式2*/
	PortWriteByte(0x281,500%256);    /*写计数器初值*/
	PortWriteByte(0x281,500/256);
	do{
		if(kbhit())exit(0);		/*有键按下则退出*/
		PortReadByte(0x288,&data);
	}while(!(data&0x01));		/*若PA0为1则表明计数时间到,返回*/
}
