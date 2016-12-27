/********************/
/*    �̵�������    */
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
	if(!Startup())			/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("press any key to return!\n");
	PortWriteByte(0x28b,0x90);		/*����8255ΪA������C�����*/
	while(true)
	{
		PortWriteByte(0x28b,1);		/*PC0��λ��ͨ�̵���*/
		m_delay();					/*��ʱ5S*/
		PortWriteByte(0x28b,0);		/*PC0��λ�Ͽ��̵���*/
		m_delay();					/*��ʱ5S*/
	}
	Cleanup();				/*�ر��豸*/
}
void m_delay()
{	
	BYTE	data;
	PortWriteByte(0x283,0x36);		/*��8254������0������ʽ3*/
	PortWriteByte(0x280,10000%256);	/*��д��������ֵ10000�ĵ��ֽ�*/
	PortWriteByte(0x280,10000/256);	/*��д��������ֵ10000�ĸ��ֽ�*/
	PortWriteByte(0x283,0x70);		/*��8254������1������ʽ2*/
	PortWriteByte(0x281,500%256);    /*д��������ֵ*/
	PortWriteByte(0x281,500/256);
	do{
		if(kbhit())exit(0);		/*�м��������˳�*/
		PortReadByte(0x288,&data);
	}while(!(data&0x01));		/*��PA0Ϊ1���������ʱ�䵽,����*/
}
