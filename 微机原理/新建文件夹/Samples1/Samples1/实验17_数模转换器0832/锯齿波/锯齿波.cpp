/************************/
/*  ����ģת������һ��  */
/*  D/Aת����������ݲ� */
/************************/
#include<conio.h>
#include<stdio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	char	i = 0;		/*iΪ�����������*/
	printf("Press any key to exit!\n");
	if(!Startup())		/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	do{
		PortWriteByte(0x290,i++);	/*��D/A���i��,ʹi��1*/
	}while(!kbhit());
	Cleanup();			/*�ر��豸*/
}
