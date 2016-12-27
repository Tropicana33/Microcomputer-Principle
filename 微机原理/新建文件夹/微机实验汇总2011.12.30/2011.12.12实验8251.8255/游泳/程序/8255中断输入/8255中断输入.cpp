#include <stdio.h>
#include <conio.h>
#include "ApiExusb.h"
#pragma comment(lib,"ApiExusb.lib")
int Count=8;
void IntS();
void main()
{
    if(!Startup())
    {
        printf("ERROR:Open Device Error!\n");
        return;
    }
    printf("Press DMC !Press any key to exit!\n");
    RegisterLocalISR(IntS,3);
    EnableIntr();
    PortWriteByte(0x28b,0xb8);
    PortWriteByte(0x28b,0x09);
    while(!kbhit());
    DisableIntr();
    Cleanup();
}
void IntS()
{
    byte data;
    PortReadByte(0x288,&data);
    printf("This is a Interrupt!In=%x\n",data);
    Count--;
    
    if(Count==0)
        exit(0);

}