 /************************/
/*      LCD汉字显示     */
/************************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")
char lcd2[16]={0xa3,0xb3,0xa3,0xb2,0xce,0xbb,0xce,0xa2,0xbb,0xfa,0xbd,0xcc,0xd1,0xa7,0xca,0xb5};
char lcd3[16]={0xd1,0xe9,0xcf,0xb5,0xcd,0xb3,0xd5,0xfd,0xd4,0xda,0xd1,0xdd,0xca,0xbe,0xd6,0xd0};
void clear();
void cmdsetup();
void datasetup();
void main()                                                    
{
      int i;
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}

       PortWriteByte(0x28b,0x80);	/*设8255为方式0,C口输出,A口输出*/
       clear();
       PortWriteByte(0x288,0x90);
       cmdsetup();
       Sleep(10);
       for (i=0;i<16;i++)
          {
            PortWriteByte(0x288,lcd2[i]);
            datasetup();  
           };
       PortWriteByte(0x288,0x88);
       cmdsetup();
       Sleep(10);
       for (i=0;i<16;i++)
          {
            PortWriteByte(0x288,lcd3[i]);
            datasetup();
           };
	Cleanup();				/*关闭设备*/
}

void  clear()
{
     PortWriteByte(0x288,0x0c);	
      cmdsetup();

}


void cmdsetup()
   {
     PortWriteByte(0x28a,0x00);
     Sleep(1);	
     PortWriteByte(0x28a,0x04);
     Sleep(1);	
     PortWriteByte(0x28a,0x00);
     Sleep(1);	
   }
void datasetup()
   {
     PortWriteByte(0x28a,0x01);
    Sleep(1);	
     PortWriteByte(0x28a,0x05);	
      Sleep(1);
      PortWriteByte(0x28a,0x01);	
     Sleep(1);
   }