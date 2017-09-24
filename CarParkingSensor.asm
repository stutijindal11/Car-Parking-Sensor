// P3_5 as trigger
// p0.7 as buzzer
// P3_2 as echo

#include<8051.h>
#define rs P0_0
#define rw P0_1
#define en P0_2
#define data P1
int flag=0;
unsigned char templ,temph,templ1,temph1,num[3];
unsigned int time=0;
unsigned int range=0;
unsigned char t=0,z=0,b=0,m=0;
int i;
void busy()
{
for(t=0;t<40;t++);
return;
}
void lcdsetcommand(unsigned char a)
{
busy();
rs=0;
rw=0;
data=a;
en=1;
en=0;
return;
}
void lcddisplay(unsigned char x[])
{
rs=1;
rw=0;
for(m=0;x[m]!='\0';m++)
{
busy();
data=x[m];
en=1;
en=0;
}
return;
}
void lcddisplaychar(unsigned char y)
{
rs=1;
rw=0;
busy();
data=y;
en=1;
en=0;
}

void delay()
{
	TH1=0x00;
	TL1=0x00;
	TR1=1;
	while(TF1==0);
	TR1=0;
	TF1=0;

}
void delay10us()
{
	TH1=0xFF;
	TL1=0xF6;
	TR1=1;
	while(TF1==0);
	TR1=0;
	TF1=0;
}
void delay1()
{
	for(i=0;i<10;i++)
	{
		delay();
	}
}
void main()
{
	P0_7=0;
	TMOD=0x11;
	P3_5=0;//make trigger 0
	P3_2=1;	 // echo port as input
while(1)
	{
lcdsetcommand(0x38);
lcdsetcommand(0x0e);
lcdsetcommand(0x06);
lcdsetcommand(0x82);
lcdsetcommand(0x01);
lcddisplay("DISTANCE: ");
	P0_7=1;
	TH0=0;
	TL0=0;
	P3_5=1;//give trigger
	delay10us();
	P3_5=0;//make trigger 0 again
	while(P3_2==0);
	TR0=1;
	while(P3_2==1);
	TR0=0;
	TF0=0;
	time=(TH0 << 8) | TL0;
	if(time<35000)
	{
		range=time/59;
	}
	else
	{
		flag=1;
		range=0;
	}
	num[2]=range%10;
	num[1]=(range/10)%10;
	num[0]=(range/10)/10;
	for(z=0;z<3;z++) 
	{
		num[z]=num[z]+0x30;
		lcddisplaychar(num[z]);
	}
	if(range<20&&flag==0)
	{
		P0_7=0;
	}
	delay1();
	}
}
