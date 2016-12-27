/******************/
/*   存储器读写   */
/******************/
#include <stdio.h>
#include <conio.h>
#include <assert.h>
#include "ApiEx.h"
#pragma comment(lib,"ApiEx.lib")

void main()
{
	BYTE	data;
	printf("--------------------EXP30_22_MEM---------------------\n");
	printf("1. DIP-D(DIP40) === 6116\n");
	printf("2. TPC (DO-D7) === 6116 (9,10,11,13,14,15,16,17)\n");
	printf("3. TPC (A0-A10) === 6116 (8,7,6,5,4,3,2,1,23,22,19)\n");
	printf("4. TPC (MEMR) === 6116 (20)\n");
	printf("5. TPC (MEMW) === 6116 (21)\n");
	printf("6. TPC (GND) === 6116 (18, 12)\n");
	printf("7. TPC (+5V) === 6116 (24)\n");
	printf("Press any key to begin!\n\n");
	getch();
	printf("--------- View Display Data! --------\n");
	if(!Startup())		/*打开设备*/
	{
		printf("ERROR: Open Device Error!\n");
		return;
	}
	int j='A';
	for (int i=0; i<2048; i++){		/*向6116循环填入A-Z*/
		MemWriteByte(i, j++);
		if (j=='Z') j='A';
	}
	for (i=0; i<256; i++){		/*读出并显示6116中的内容*/
		MemReadByte(i,&data);
		putchar(data);
	}
	Cleanup();		/*关闭设备*/
	printf("\nPress any key to exit!\n");
	getch();
}
