/**********************/
/*     竞赛抢答器     */
/**********************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"

#pragma comment(lib,"ApiEx.lib")

int led[9]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f};	/*数码表*/
int num[8]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
int  i=0;

void main()
{
	BYTE	data;
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("ESC is to exit!");
	PortWriteByte(0x28b,0x89);		/*设8255为A口输出,C口输入*/
  	for(;;)
	{
		do{
			PortReadByte(0x28a,&data);	/*若C口的数据为0,则继续从C口输入*/
		}while(!data);
		for(i=0;i<8;i++)			/*否则进行依次与num中数比较*/
		{
			if(data==num[i])
			{
				printf("\7");	//响铃
				break;
			}	/*若有相等*/
		}
		if(i<8)
		{
			PortWriteByte(0x288,led[i+1]);
			data=0;			/*从A口输出与之对应的LED段码*/
		}
        if(getch() == 27)
			exit(0);		/*等待按键,若为ESC则退出*/
		PortWriteByte(0x288,0);		/*否则关闭LED显示*/
	}
	Cleanup();				/*关闭设备*/
}
