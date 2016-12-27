/************************/
/*   键盘显示           */
/************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")
char led[17]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f,0x77,0x7c,0x39,0x5e,0x79,0x71,0x00};
		/*上面为从0-f对应的段码表*/
void main()
{

      byte data;
      byte i,j;
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
       printf("press any key to exit");
       j=16;
      while(!kbhit())
       {
        PortWriteByte(0x28b,0x81);		/*设置8255的A口C口均为输出*/
        PortWriteByte(0x288,led[j]);
        PortWriteByte(0x28a,0x0f);	
        PortReadByte(0x28a,&data);
        i=data;
        if (i!=0x0f)
          {
            i=data;
            Sleep(50);
            PortWriteByte(0x28b,0x88);
            PortWriteByte(0x28a,0xf0);	
            PortReadByte(0x28a,&data);
            i=i|data;
            if (i==0x77) j=0;
              else if(i==0x7b) j=1;
              else if(i==0x7d) j=2;
              else if(i==0x7e) j=3;
              else if(i==0xb7) j=4;
              else if(i==0xbb) j=5;
              else if(i==0xbd) j=6;
              else if(i==0xbe) j=7;
              else if(i==0xd7) j=8;
              else if(i==0xdb) j=9;
              else if(i==0xdd) j=10;
              else if(i==0xde) j=11;
              else if(i==0xe7) j=12;
              else if(i==0xeb) j=13;
              else if(i==0xed) j=14;
              else if(i==0xee) j=15;
              else; 

          }
       }
	Cleanup();				/*关闭设备*/
}