 /*********************************/
/*      �򵥲��нӿڣ����룩     */
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
	if(!Startup())			/*���豸*/
	{
		printf("ERROR:Open Device Error!\n");
		return;
	}
	while(!kbhit())			/*�м��������˳�*/
	{
		PortReadByte(0x2A0,&data);	/*���˿�0x2A0������*/
		printf("%x\n",data);	 	/*���Զ˿�2A0H������������ַ����*/
            Sleep(100);		/*�ӳ�0.1����*/
	}
	Cleanup();				/*�ر��豸*/
}
