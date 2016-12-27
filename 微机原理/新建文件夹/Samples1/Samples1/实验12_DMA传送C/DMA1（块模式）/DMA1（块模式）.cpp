/************************/
/*   DMA传送（块模式）  */
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
	if(!Startup())			//打开设备
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	printf("--------- COMP Display Data! --------\n");

	dwSize = 0x1000;
	ok = DmaCommonBufferGet(&dwPhy, &dwUser, &dwSize);
	if (!ok) {
		printf("ERROR: Get Phy Mem Error!\n");
		Cleanup();			//关闭设备
		return;
	}
	if (dwUser == 0x0ffffffff) {
		ok = MapPhysicalMemoryToLinearSpace(&dwUser, &dwPhy, &dwSize);
		if (!ok) {
			UNmapPhysicalMemoryToLinearSpace(&dwUser);	//
			Cleanup();			//关闭设备
			return;
		}
	}

	printf("DmaCommonBufferGet: phy=%x, local=%x, size=%x\n", dwPhy, dwUser, dwSize);
	putchar('\n');

	//memcpy((char *)dwUser, magic, len);		//待传送数据写入微机内存
	//memcpy((char *)dwUser+0x400, magic1, len1);		//清理回传内存空间
	for (i=0x00; i < len; i++){		//向6116填入待传送数据
		MemWriteByte(i, magic[i]);
	}
	for (i=0x00; i < len1; i++){		//清理6116待传回数据空间
		MemWriteByte(i+0x400, magic1[i]);
	}

	for (i=0; i < len; i++) {		//传送前显示6116中待传送数据
		MemReadByte(i,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len1; i++) {		//传送前显示6116中传回的数据
		MemReadByte(i+0x400,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len; i++) {		//传送前显示内存中传送数据
		putchar(((char *)dwUser)[i]);
	}
	putchar('\n');

	DmaChannelOpen(FALSE,2);		//打开Block MODE DMA传送
	RegisterDmaFinishedSR(MyDmaISR);	//注册DMA传送完成中断程序
	EnableDmaFinishedNotify();

	DmaTransferLocalToHost(0, dwPhy, len);	//启动6116向内存的DMA传送
	Sleep(200);
	DmaTransferHostToLocal(dwPhy, 0+0x400, len);	//启动内存向6116的DMA传送
	Sleep(200);

	DisableDmaFinishedNotify();
	for (i=0; i < len; i++) {		//传送后显示6116中待传送数据
		MemReadByte(i,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len1; i++) {		//传送后显示6116中传回的数据
		MemReadByte(i+0x400,&data);
		putchar(data);
	}
	putchar('\n');
	for (i=0; i < len; i++) {		//传送后显示内存中传送数据
		putchar(((char *)dwUser)[i]);
	}
	putchar('\n');

	DmaChannelClose();		//关闭DMA传送
	UNmapPhysicalMemoryToLinearSpace(&dwUser);	//
	Cleanup();			//关闭设备

	printf("Press any key ...");
	getch();

	return ;
}
