/************************/
/*   DMA���ͣ���ģʽ��  */
/************************/
#include<stdio.h>
#include<conio.h>
#include<assert.h>

#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

#include "ApiEx3.h"

#define magic	"This is Block MODE DMA transfare."
#define magic1	"*************************************"
#define len		strlen(magic)
#define len1	strlen(magic1)

void MyDmaISR()
{
	printf("DMA finished!\n");
}

void main()
{
	int		i;
	BOOL	ok;
	BYTE	data;
	DWORD	dwPhy, dwUser, dwSize;

	printf("--------------------EXP18_15_DMA_1---------------------\n");
	printf("1. DIP-D(DIP40) === 6116\n");
	printf("2. TPC (DO-D7) === 6116 (9,10,11,13,14,15,16,17)\n");
	printf("3. TPC (A0-A10) === 6116 (8,7,6,5,4,3,2,1,23,22,19)\n");
	printf("4. TPC (MEMR) === 6116 (20)\n");
	printf("5. TPC (MEMW) === 6116 (21)\n");
	printf("6. TPC (GND) === 6116 (18, 12)\n");
	printf("7. TPC (+5V) === 6116 (24)\n");
	printf("Press any key to begin!\n\n");
	getch();
	if(!Startup())			//���豸
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("--------- COMP Display Data! --------\n");

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
	putchar('\n');

	//memcpy((char *)dwUser, magic, len);		//����������д��΢���ڴ�
	//memcpy((char *)dwUser+0x400, magic1, len1);		//����ش��ڴ�ռ�
	for (i=0x00; i < len; i++){		//��6116�������������
		MemWriteByte(i, magic[i]);
	}
	for (i=0x00; i < len1; i++){		//����6116���������ݿռ�
		MemWriteByte(i+0x400, magic1[i]);
	}

	for (i=0; i < len; i++) {		//����ǰ��ʾ6116�д���������
		MemReadByte(i,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len1; i++) {		//����ǰ��ʾ6116�д��ص�����
		MemReadByte(i+0x400,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len; i++) {		//����ǰ��ʾ�ڴ��д�������
		putchar(((char *)dwUser)[i]);
	}
	putchar('\n');

	DmaChannelOpen(FALSE,2);		//��Block MODE DMA����
	RegisterDmaFinishedSR(MyDmaISR);	//ע��DMA��������жϳ���
	EnableDmaFinishedNotify();

	DmaTransferLocalToHost(0, dwPhy, len);	//����6116���ڴ��DMA����
	Sleep(200);
	DmaTransferHostToLocal(dwPhy, 0+0x400, len);	//�����ڴ���6116��DMA����
	Sleep(200);

	DisableDmaFinishedNotify();
	for (i=0; i < len; i++) {		//���ͺ���ʾ6116�д���������
		MemReadByte(i,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len1; i++) {		//���ͺ���ʾ6116�д��ص�����
		MemReadByte(i+0x400,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len; i++) {		//���ͺ���ʾ�ڴ��д�������
		putchar(((char *)dwUser)[i]);
	}
	putchar('\n');

	DmaChannelClose();		//�ر�DMA����
	UNmapPhysicalMemoryToLinearSpace(&dwUser);	//
	Cleanup();			//�ر��豸

	printf("Press any key ...");
	getch();

	return ;
}
