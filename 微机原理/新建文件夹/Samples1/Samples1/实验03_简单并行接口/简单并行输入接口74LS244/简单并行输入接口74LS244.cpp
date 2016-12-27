 /*********************************/
/*      简单并行接口（输入）     */
/*********************************/
#include  <conio.h>
#include  <stdio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
  	BYTE data;
	
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR:Open Device Error!\n");
		return;
	}
	while(!kbhit())			/*有键按下则退出*/
	{
		PortReadByte(0x2A0,&data);	/*读端口0x2A0的数据*/
		printf("%x\n",data);	 	/*将自端口2A0H输入的数据以字符输出*/
            Sleep(100);		/*延迟0.1秒钟*/
	}
	Cleanup();				/*关闭设备*/
}
