/************************/
/* �ɱ�̲��нӿڣ�һ�� */
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
	if(!Startup())			/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Press any key to exit!");
	while(!kbhit())			/*�м��������˳�*/
	{
		PortWriteByte(0x28b,0x8b);	/*��8255Ϊ��ʽ0,C������,A�����*/
		PortReadByte(0x28a,&data);
  		PortWriteByte(0x288,data);	/*��C�������������A�����*/
  	}
	Cleanup();				/*�ر��豸*/
}
