/*****************************/
/*        ����¼����         */
/*****************************/
#include<stdio.h>
#include<conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void lu();		/*¼������*/
void fang();	/*��������*/


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
	if(!Startup())		/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	ii = (BYTE *)malloc(200000);		/*����ռ����ڴ��¼������*/
	if(!ii)
	{
		printf("No memory!\7");
		exit(0);
	}
	PortWriteByte(0x28b,0x9b);		/*��8255A��Ϊ���뷽ʽ*/
	PortWriteByte(0x283,0x16);		/*��ʼ��8253ͨ��0Ϊ��ʽ0*/
      PortWriteByte(0x280,70);	/*�ͼ�������ֵ50*/
	printf("Press any key to record!\n");	/*¼����ʾ*/
	getch();
	printf("Playing record!\n");
	lu();			/*���������ʼ¼��*/
	printf("Press any key to playing!ESC is exit!\n");	/*������ʾ*/
	while(getch() != 0x1b)
	{
		fang();		/*���������ʼ����*/
		printf("Playing end!\n");
	}
	Cleanup();		/*�ر��豸*/
}
void lu()
{
	BYTE data;
	for(i=0;i<200000;i++)	/*����A/D,�ɼ�60000�����ݷ���ii��*/
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
	for(i=0;i<200000;i++)	/*��ii�е�60000����D/A���*/
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
