 /************************/
/*   年字显示           */
/************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")
char line[8]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
char ldat[8]={0x44,0x54,0x54,0x7f,0x54,0xdc,0x44,0x24};


void main()
{
	int i,j;
	printf("press any key to return!\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
            printf("press any key to exit");
            while(!kbhit())
		{   for (i=0;i<10;i++)
                  {
                   for(j=0;j<8;j++)
			{      PortWriteByte(0x288,line[j]);
				PortWriteByte(0x280,ldat[j]);
			       Sleep(1);
                           if(kbhit()) break;		/*如有键按下则退出*/

			}
                  }
                    PortWriteByte(0x288,0x00);
                    PortWriteByte(0x290,0x00);
                   Sleep(1000);
                  for (i=0;i<10;i++)
                   {
                    for(j=0;j<8;j++)
			{      PortWriteByte(0x290,line[j]);
				PortWriteByte(0x280,ldat[j]);
			       Sleep(1);
                           if(kbhit()) break;		/*如有键按下则退出*/
			}
                   }
                   PortWriteByte(0x288,0x00);
                   PortWriteByte(0x290,0x00);
                  Sleep(1000);
	       }

	Cleanup();				/*关闭设备*/
}

