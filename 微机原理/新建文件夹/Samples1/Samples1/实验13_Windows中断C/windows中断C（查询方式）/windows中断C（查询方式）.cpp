/************************/
/* �ж�ʵ�飨��ѯ��ʽ�� */
/************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	printf("--------------------EXP15_9_INT1---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (L0-L7)\n");
	printf("2. 8255 (PC0) === TPC (DMC)\n");
	printf("3. 8255 (CS) === TPC (288H-28FH)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())		/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Please Press DMC! Press any key to exit!\n");
	PortWriteByte(0x28b,0x8b);	/*��8255Ϊ��ʽ0,C������,A�����*/
	while(!kbhit())
	{
		PortReadByte(0x28a,&data);
		if(data&0x01)
		{
			PortWriteByte(0x288,0x55);
			Sleep(1*1000);		/*�ӳ�*/
		}
		PortWriteByte(0x288,0xaa);
	}
	Cleanup();			/*�ر��豸*/
}
