/*******************************/
/*     �ɱ�̲��нӿڣ�����    */
/*   8255��ʽ1����ʵ�� (A��)   */
/*******************************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

int Count=8;		/*��Ӧ�жϴ���Ϊ8*/
void IntS();
void main()
{
	printf("--------------------EXP21_10_8255-1_2---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (K0-K7)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. 8255 (PC3) === TPC (IRQ)\n");
	printf("4. 8255 (PC4) === (K8(DMC))\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())	/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Press DMC!Press any key to exit!\n");
	PortWriteByte(0x28b,0xb8);		/*��8255������ʽ1����*/
  	PortWriteByte(0x28b,0x09);		/*��PC4��λ*/
	RegisterLocalISR(IntS);		/*ע���жϳ���*/
	EnableIntr();		/*���ж�*/
	while(!kbhit()) Sleep(10);
	DisableIntr();	/*���ж�*/
	Cleanup();		/*�ر��豸*/
}
void IntS()
{
	BYTE	data;
	PortReadByte(0x288,&data);		/*��16���ƴ�ӡ��A�����������*/
	printf("This is a Intrupt! In = %x\n",data);
	Count--;
	if(Count == 0)
		exit(0);
}
