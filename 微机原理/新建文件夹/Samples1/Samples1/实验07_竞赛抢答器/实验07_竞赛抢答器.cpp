/**********************/
/*     ����������     */
/**********************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

int led[9]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f};	/*�����*/
int num[8]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
int  i=0;

void main()
{
	BYTE	data;
	if(!Startup())			/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("ESC is to exit!");
	PortWriteByte(0x28b,0x89);		/*��8255ΪA�����,C������*/
  	for(;;)
	{
		do{
			PortReadByte(0x28a,&data);	/*��C�ڵ�����Ϊ0,�������C������*/
		}while(!data);
		for(i=0;i<8;i++)			/*�������������num�����Ƚ�*/
		{
			if(data==num[i])
			{
				printf("\7");	//����
				break;
			}	/*�������*/
		}
		if(i<8)
		{
			PortWriteByte(0x288,led[i+1]);
			data=0;			/*��A�������֮��Ӧ��LED����*/
		}
        if(getch() == 27)
			exit(0);		/*�ȴ�����,��ΪESC���˳�*/
		PortWriteByte(0x288,0);		/*����ر�LED��ʾ*/
	}
	Cleanup();				/*�ر��豸*/
}
