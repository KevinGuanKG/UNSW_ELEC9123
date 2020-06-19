clc
close all
clear all

FreqS=52;% source freq
Tcs=1e-4;

m=0.74;% gain of sogi
ki=100;

kp=[0.1:2:20];
L=length(kp);

vdmem=zeros(2001,L);
vqmem=zeros(2001,L);
fmem=zeros(2001,L);

dmem=zeros(1,L);
ferr=zeros(1,L);
Tset=zeros(1,L);

%���ϳ��� ���������ö�ٷ������Ҫ�Ż����͸ĳ��Ż��㷨����
for n=1:L

KP=kp(n);
KI=ki;
sim('run.slx');

vd=Vd(1800:3800);
vq=Vq(1800:3800);
f=Freq(1800:3800);

vdmem(:,n)=vd';
vqmem(:,n)=vq';
fmem(:,n)=f';

%����Ƶ�ʵĳ�����
max_f=max(f);
min_f=min(f);
f_final=mean(Freq(end-3000:end));%ȡ���100����Ϊ��ֵ̬

%ͬʱ�������³��� ��ѡ���
d1=abs(max_f-f_final);
d2=abs(min_f-f_final);

if(d2>=d1)
    d=d2;
else
    d=d1;
end
    
dmem(n)=100*d/f_final;%ת���ٷֱ�
ferr(n)=abs(f_final/2/pi-50)/50;


end



figure
plot(vdmem)

figure
plot(vqmem)

figure
plot(fmem/2/pi)

figure1=figure;
[AX,H1,H2]=plotyy(kp,dmem,kp,ferr);
title("Overshoot and S.S. Error related to Varible Kp")
set(get(AX(1),'Ylabel'),'String','Overshoot*100') 
set(get(AX(2),'Ylabel'),'String','Steady State Error') 
xlabel('kp');

