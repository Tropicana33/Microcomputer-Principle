/******************/
/*������������ͨ��*/
/******************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

void main()
{
	int	i;
	BYTE	data;
  	if(!Startup())	/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	PortWriteByte(0x283,0x16);		/*��8253������0������ʽ*/
	Sleep(1*100);		/*��ʱ*/
	PortWriteByte(0x280,52);		/*��8253ͨ��0�ͳ�ֵ*/
	Sleep(1*100);		/*��ʱ*/
	for(i=0;i<3;i++)
	{
		PortWriteByte(0x2b9,0);		/*��ʼ��8251,��8251���ƶ˿���3��0*/
		Sleep(1*100);		/*��ʱ*/
	}
	PortWriteByte(0x2b9,0x40);		/*��λ8251*/
	Sleep(1*100);		/*��ʱ*/
	PortWriteByte(0x2b9,0x4e);		/*����Ϊ1��ֹͣλ��8������λ������������Ϊ16*/
	Sleep(1*100);		/*��ʱ*/
	PortWriteByte(0x2b9,0x27);		/*��8251�Ϳ�������������պͷ���*/
	Sleep(1*100);		/*��ʱ*/
	printf("You can Press a key to start:\n");	/*��ʾ*/
	printf("ESC is exit!\n");	/*��ʾ*/
	for(;;)
	{
		do{
			PortReadByte(0x2b9,&data);
		}while(!(data&0x01));		/*����δ׼�������������*/
		data = getch();
		if(data == 0x1b) exit(0);	/*����ESC�������򷵻�*/
		putchar(data);
		PortWriteByte(0x2b8,data+1);	/*����*/
		Sleep(1*100);		/*��ʱ*/
		do{
			PortReadByte(0x2b9,&data);
		}while(!(data&0x02));		/*����û׼������ȴ�*/
		PortReadByte(0x2b8,&data);
		printf("%c",data);		/*׼�����򽫽��պ���ַ���ʾ*/
   	}
	Cleanup();		/*�ر��豸*/
}
