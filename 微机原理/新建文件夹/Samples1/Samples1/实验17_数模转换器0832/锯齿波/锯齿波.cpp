/************************/
/*  数／模转换器（一）  */
/*  D/A转换器产生锯齿波 */
/************************/
#include<conio.h>
#include<stdio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	char	i = 0;		/*i为输出的数字量*/
	printf("Press any key to exit!\n");
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	do{
		PortWriteByte(0x290,i++);	/*从D/A输出i后,使i加1*/
	}while(!kbhit());
	Cleanup();			/*关闭设备*/
}
