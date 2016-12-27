/************************/
/*   七段数码管（三）   */
/************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")
char led[10]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
		/*上面为从0-9对应的段码表*/

void main()
{
	int i,j;
	printf("--------------------EXP11_5_LED_2---------------------\n");
	printf("1. 8255 (PA0-PA6) === LED (a-g)\n");
	printf("2. 8255 (PC0-PC1) === LED (S0-S1)\n");
	printf("3. I/O (288-28F) === 8255 (CS)\n");
	printf("4. TPC (GND) === LED (dp)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Please enter any key return!");
	do{
		PortWriteByte(0x28b,0x82);		/*设置8255的A口C口均为输出*/
		for(i=0;i<10;i++)
		{
			for(j=0;j<10;j++)
			{   PortWriteByte(0x288,0x3f);
				PortWriteByte(0x28a,0x08);
				Sleep(35);
				PortWriteByte(0x288,0x3f);
				PortWriteByte(0x28a,0x04);
				Sleep(35);

				PortWriteByte(0x288,led[i]);
				PortWriteByte(0x28a,0x02);
				Sleep(35);
				PortWriteByte(0x288,led[j]);
				PortWriteByte(0x28a,0x01);
				Sleep(35);
				if(kbhit()) break;		/*如有键按下则退出*/
			}
		}
	}while(!kbhit());
	PortWriteByte(0x28a,0x00);
	Cleanup();				/*关闭设备*/
}
