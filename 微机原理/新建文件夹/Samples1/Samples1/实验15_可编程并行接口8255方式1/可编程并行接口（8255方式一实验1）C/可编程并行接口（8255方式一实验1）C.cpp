/*******************************/
/*     �ɱ�̲��нӿڣ�����    */
/*   8255��ʽ1���ʵ�� (A��)   */
/*******************************/
#include <stdio.h>
#include <conio.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

int Count=0x01;		/*��Ӧ�жϴ���Ϊ8*/
void IntS();
void main()
{
	printf("--------------------EXP21_10_8255-1_1---------------------\n");
	printf("1. 8255 (PA0-PA7) === TPC (L0-L7)\n");
	printf("2. I/O (288-28F) === 8255 (CS)\n");
	printf("3. 8255 (PC3) === TPC (IRQ)\n");
	printf("4. 8255 (PC6) === (K8(DMC))\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())	/*���豸*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("Press DMC!Press any key to exit!\n");
	RegisterLocalISR(IntS);		/*ע���жϳ���*/
	EnableIntr();		/*���ж�*/
	PortWriteByte(0x28b,0xa8);		/*��8255������ʽ1���*/
	PortWriteByte(0x28b,0x0d);		/*��PC6��λ*/
	while(!kbhit()) Sleep(10);
	DisableIntr();	/*���ж�*/
	Cleanup();		/*�ر��豸*/
}
void IntS()
{
	PortWriteByte(0x288,Count);		/*��PA�����i,��ֵΪ0x80*/
	printf("This is a Intrupt! Out = %x \n",Count);
	Count<<=1;			/*Count����һλ*/
	if(Count == 0x100)
		exit(0);
}
