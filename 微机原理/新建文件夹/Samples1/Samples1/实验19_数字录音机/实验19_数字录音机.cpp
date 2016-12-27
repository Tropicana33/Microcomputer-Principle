/*****************************/
/*        数字录音机         */
/*****************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void lu();		/*录音函数*/
void fang();	/*放音函数*/


int i;
BYTE *ii;

void main()
{
	printf("--------------------EXP22_13_LYJ---------------------\n");
	printf("1. MIC === J2\n");
	printf("2. I/O (298-29F) === 0809 (CS)\n");
	printf("3. (JUMP 2 TO 3) of JP2\n");
	printf("4. SPEAKER === J1\n");
	printf("5. I/O (290-297) === 0832 (CS)\n");
	printf("6. 8253 (CLK0) === (1MHz) or (2MHz)\n");
	printf("7. TPC (+5V) === 8253 (GATE0)\n");
	printf("8. 8253 (OUT0) === 8255 (PA0)\n");
	printf("9. I/O (280-287) === 8253 (CS)\n");
	printf("10. I/O (288-28F) === 8255 (CS)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	ii = (BYTE *)malloc(200000);		/*分配空间用于存放录音数据*/
	if(!ii)
	{
		printf("No memory!\7");
		exit(0);
	}
	PortWriteByte(0x28b,0x9b);		/*设8255A口为输入方式*/
	PortWriteByte(0x283,0x16);		/*初始化8253通道0为方式0*/
      PortWriteByte(0x280,70);	/*送计数器初值50*/
	printf("Press any key to record!\n");	/*录音提示*/
	getch();
	printf("Playing record!\n");
	lu();			/*按任意键后开始录音*/
	printf("Press any key to playing!ESC is exit!\n");	/*放音提示*/
	while(getch() != 0x1b)
	{
		fang();		/*按任意键后开始放音*/
		printf("Playing end!\n");
	}
	Cleanup();		/*关闭设备*/
}
void lu()
{
	BYTE data;
	for(i=0;i<200000;i++)	/*启动A/D,采集60000个数据放在ii中*/
	{
            do{
		    PortReadByte(0x288,&data);
	        }while(data&0x01);
		PortWriteByte(0x29a,0);
            PortReadByte(0x29a,&data);
		*(ii+i) = data;
            PortReadByte(0x288,&data);
            if  (data&0x01!=0);
               {
                do{
		       PortReadByte(0x288,&data);
	            }while(!data&0x01);
	         } 
		
	}
}
void fang()
{
	BYTE data;
	for(i=0;i<200000;i++)	/*将ii中的60000个从D/A输出*/
   	{
           do{
		    PortReadByte(0x288,&data);
	        }while(data&0x01);
		data = *(ii+i);
		PortWriteByte(0x290,data);
            PortReadByte(0x288,&data);
            if  (data&0x01!=0);
               {
                do{
	             PortReadByte(0x288,&data);
	             }while(!data&0x01);
               }
	}
}
