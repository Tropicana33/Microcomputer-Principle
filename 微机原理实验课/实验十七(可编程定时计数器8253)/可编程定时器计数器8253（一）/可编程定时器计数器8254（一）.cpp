/********************************/
/*   可编程定时器／计数器（一） */
/********************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	PortWriteByte(0x283,0x10);		/*设8254计数器0工作方式0,只写低字节*/
  	PortWriteByte(0x280,0x20);		/*写入计数初值32*/
  	while(!kbhit())			/*有键按下则退出*/
	{
		PortReadByte(0x280,&data);
 		printf("%d\n",data);		/*打印计数器值*/
	}
	Cleanup();				/*关闭设备*/
}
