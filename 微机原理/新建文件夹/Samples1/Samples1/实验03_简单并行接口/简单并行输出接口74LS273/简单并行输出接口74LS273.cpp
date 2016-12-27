/*********************************/
/*      简单并行接口（输出）     */
/*********************************/
#include  <conio.h>
#include  <stdio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	char	k;
	printf("--------------------EXP8_2_273---------------------\n");
	printf("1. I/O (2A8-2AF) === OR (A)\n");
	printf("2. TPC (/IOW) === OR (B)\n");
	printf("3. OR (Y) === 74LS273 (11)\n");
	printf("4. TPC (D0-D7) === 74LS273 (3,4,7,8,13,14,17,18)\n");
	printf("5. 74LS273 (2,5,6,9,12,15,16,19) === TPC (L0-L7)\n");
	printf("6. TPC (+5) === 74LS273 (1, 20)\n");
	printf("7. TPC (GND) === 74LS273 (10)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR:Open Device Error!\n");
		return;
	}
	printf("ESC is to exit!\n");
  	while((k=getch())!=27)		/*从键盘接收一个字符,若为ESC则退出*/
	{
    	printf("%x\n",k);		/*将其ASCII码显示在屏幕上*/
    	PortWriteByte(0x2A8,(BYTE)k);	/*将其ASCII码自端口2A8H输出*/
   	}
	Cleanup();				/*关闭设备*/
}