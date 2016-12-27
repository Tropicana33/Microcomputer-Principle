/******************************/
/*   DMA传送（外部请求模式）  */
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

	if(!Startup())			//打开设备
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}

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
	printf("Press DMC!Press any key to exit!\n");
	
	//memcpy((char *)dwUser, "This is DMA tranfare.", 20);	//向微机内存中写数据
	for (i=0; i < len; i++){		//向6116填入待传送数据
		PortWriteByte(0x80000280+i, magic[i]);
	}
	DmaChannelOpen(FALSE,2);		//打开Block MODE DMA传送
	//RegisterDmaFinishedSR(MyDmaISR);	//注册DMA传送完成中断程序
	EnableDmaFinishedNotify();
	DmaTransferLocalToHost(0x80000280, dwPhy, len);	//启动6116向内存的DMA传送
	Sleep(200);
	DisableDmaFinishedNotify();
	DmaChannelClose();
	for (i=0; i<len; i++) {	
		PortWriteByte(0x80000280+i, i+0x30);
	}//清6116芯片中的数据

	DmaChannelOpen(TRUE);		//打开Single Cycle Demand Mode DMA传送
	RegisterDmaFinishedSR(MyDmaISR);	//注册DMA传送完成中断程序
	EnableDmaFinishedNotify();

	DmaTransferHostToLocal(dwPhy, 0x80000280, len);//将微机内存中数据通过dma方式传送至6116芯片中

	while (!kbhit()) {
		for (i=0; i<len; i++) {
			PortReadByte(0x80000280+i, &data);
			putchar((char)data);
		}
		putchar('\n');
		Sleep(100);
	}//显示6116芯片中的数据

	DisableDmaFinishedNotify();
	UNmapPhysicalMemoryToLinearSpace(&dwUser);	//
	DmaChannelClose();		//关闭DMA传送
	
	Cleanup();			//关闭设备
	
	getch();
}
