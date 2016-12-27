 /************************/
/*   逐行逐列显示实验   */
/************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")
char line[8]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};



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
		{      PortWriteByte(0x288,0x00);
                   PortWriteByte(0x290,0x00);
                   for(j=0;j<8;j++)
			   {      PortWriteByte(0x288,line[j]);
				PortWriteByte(0x280,0xff);
			       Sleep(100);
                           if(kbhit()) break;		/*如有键按下则退出*/
			   }
                    PortWriteByte(0x288,0x00);
                    PortWriteByte(0x290,0x00);
                   Sleep(300);
                   for(j=0;j<8;j++)
			   {      PortWriteByte(0x290,line[j]);
				    PortWriteByte(0x280,0xff);
			          Sleep(100);
                           if(kbhit()) break;		/*如有键按下则退出*/
			    }
                   PortWriteByte(0x288,0x00);
                   PortWriteByte(0x290,0x00);
                   Sleep(300);
                   for(j=0;j<8;j++)
			   {      PortWriteByte(0x288,0xff);
				    PortWriteByte(0x280,line[j]);
			          Sleep(100);
                           if(kbhit()) break;		/*如有键按下则退出*/
			    }
                   PortWriteByte(0x288,0x00);
                   PortWriteByte(0x290,0x00);
                   Sleep(300);
                   for(j=0;j<8;j++)
			   {      PortWriteByte(0x290,0xff);
				    PortWriteByte(0x280,line[j]);
			          Sleep(100);
                           if(kbhit()) break;		/*如有键按下则退出*/
			    }
                   PortWriteByte(0x288,0x00);
                   PortWriteByte(0x290,0x00);
                   Sleep(300);

	       }

	Cleanup();				/*关闭设备*/
}

