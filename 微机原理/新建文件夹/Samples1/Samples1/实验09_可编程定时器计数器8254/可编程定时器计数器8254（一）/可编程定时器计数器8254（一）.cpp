/********************************/
/*   �ɱ�̶�ʱ������������һ�� */
/********************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	if(!Startup())			/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	PortWriteByte(0x283,0x10);		/*��8254������0������ʽ0,ֻд���ֽ�*/
  	PortWriteByte(0x280,0x20);		/*д�������ֵ32*/
  	while(!kbhit())			/*�м��������˳�*/
	{
		PortReadByte(0x280,&data);
 		printf("%d\n",data);		/*��ӡ������ֵ*/
	}
	Cleanup();				/*�ر��豸*/
}
