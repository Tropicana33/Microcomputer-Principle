/************************/
/*  ����ģת����������  */
/*  D/Aת�����������Ҳ� */
/************************/
#include<conio.h>
#include<stdio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	int i;
	int m_sin[]={0x80,0x96,0x0ae,0x0c5,0x0d8,0x0e9,0x0f5,0x0fd,0x0ff,
		0x0fd,0x0f5,0x0e9,0x0d8,0x0c5,0x0ae,0x96,0x80,0x66,0x4e,0x38,
		0x25,0x15,0x09,0x04,0x00,0x04,0x09,0x15,0x25,0x38,0x4e,0x66};
	/*m_sinΪ��������Ҳ�����*/
	printf("--------------------EXP16_11_D-A_2---------------------\n");
	printf("1. I/O (290-297) === 0832 (CS)\n");
	printf("Press any key to begin!\n\n");
	getch();
	printf("--------- TEST Ub(-5V~+5V) ----------\n");
	printf("Press any key to exit!\n");
	if(!Startup())		/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	do{
		for(i=0;i<32;i++)
		{
			PortWriteByte(0x290,m_sin[i]);	/*��D/A���i��,ʹi��1*/
			if(kbhit())
				break;			/*���м��������˳�*/
		}
	}while(!kbhit());
	Cleanup();			/*�ر��豸*/
}
