/*********************************/
/*         模/数转换器 （一）    */
/* A/D转换器采集数据在屏幕上显示 */
/*********************************/
#include <conio.h>
#include <stdio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	printf("--------------------EXP17_12_A-D_1---------------------\n");
	printf("1. I/O (298-29F) === 0809 (CS)\n");
	printf("2. 0809 (JP3) === Jump 1 to 2\n");
	printf("3. (RW1) or (RW2) === 0809 (IN0)\n");
	printf("Press any key to begin!\n\n");
	getch();
	printf("*. Rotate RW1,2 Display 00 - FF\n");
	printf("Press any key to exit!\n");
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	while(!kbhit())
	{
		PortWriteByte(0x298,0x00);	/*启动A/D通道0*/
		Sleep(70);		/*延时*/
		PortReadByte(0x298,&data);
		printf("%d\n",data);	/*将转换后的数据在屏幕上显示*/
	}					/*如有键按下则退出*/
	Cleanup();			/*关闭设备*/
}
