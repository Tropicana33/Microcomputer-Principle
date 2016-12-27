/******************************/
/*   DMA���ͣ��ⲿ����ģʽ��  */
/******************************/
#include<stdio.h>
#include<conio.h>
#include<assert.h>

#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

#include "ApiEx3.h"

#define magic	"This is DMA tranfare."
#define len		strlen(magic)

void MyDmaISR()
{
	printf("DMA finished!\n");
}

void main()
{
	int i;
	BOOL ok;
	BYTE data;
	DWORD dwPhy, dwUser, dwSize;

	if(!Startup())			//���豸
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}

	dwSize = 0x1000;
	ok = DmaCommonBufferGet(&dwPhy, &dwUser, &dwSize);
	if (!ok) {
		printf("ERROR: Get Phy Mem Error!\n");
		Cleanup();			//�ر��豸
		return;
	}
	if (dwUser == 0x0ffffffff) {
		ok = MapPhysicalMemoryToLinearSpace(&dwUser, &dwPhy, &dwSize);
		if (!ok) {
			UNmapPhysicalMemoryToLinearSpace(&dwUser);	//
			Cleanup();			//�ر��豸
			return;
		}
	}

	printf("DmaCommonBufferGet: phy=%x, local=%x, size=%x\n", dwPhy, dwUser, dwSize);
	printf("Press DMC!Press any key to exit!\n");
	
	//memcpy((char *)dwUser, "This is DMA tranfare.", 20);	//��΢���ڴ���д����
	for (i=0; i < len; i++){		//��6116�������������
		PortWriteByte(0x80000280+i, magic[i]);
	}
	DmaChannelOpen(FALSE,2);		//��Block MODE DMA����
	//RegisterDmaFinishedSR(MyDmaISR);	//ע��DMA��������жϳ���
	EnableDmaFinishedNotify();
	DmaTransferLocalToHost(0x80000280, dwPhy, len);	//����6116���ڴ��DMA����
	Sleep(200);
	DisableDmaFinishedNotify();
	DmaChannelClose();
	for (i=0; i<len; i++) {	
		PortWriteByte(0x80000280+i, i+0x30);
	}//��6116оƬ�е�����

	DmaChannelOpen(TRUE);		//��Single Cycle Demand Mode DMA����
	RegisterDmaFinishedSR(MyDmaISR);	//ע��DMA��������жϳ���
	EnableDmaFinishedNotify();

	DmaTransferHostToLocal(dwPhy, 0x80000280, len);//��΢���ڴ�������ͨ��dma��ʽ������6116оƬ��

	while (!kbhit()) {
		for (i=0; i<len; i++) {
			PortReadByte(0x80000280+i, &data);
			putchar((char)data);
		}
		putchar('\n');
		Sleep(100);
	}//��ʾ6116оƬ�е�����

	DisableDmaFinishedNotify();
	UNmapPhysicalMemoryToLinearSpace(&dwUser);	//
	DmaChannelClose();		//�ر�DMA����
	
	Cleanup();			//�ر��豸
	
	getch();
}
