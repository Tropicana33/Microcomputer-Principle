/*********************************/
/*      �򵥲��нӿڣ������     */
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
	if(!Startup())			/*���豸*/
	{
		printf("ERROR:Open Device Error!\n");
		return;
	}
	printf("ESC is to exit!\n");
  	while((k=getch())!=27)		/*�Ӽ��̽���һ���ַ�,��ΪESC���˳�*/
	{
    	printf("%x\n",k);		/*����ASCII����ʾ����Ļ��*/
    	PortWriteByte(0x2A8,(BYTE)k);	/*����ASCII���Զ˿�2A8H���*/
   	}
	Cleanup();				/*�ر��豸*/
}