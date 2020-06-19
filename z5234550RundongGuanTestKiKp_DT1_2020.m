clc
close all
clear all

FreqS=52;
Tcs=1e-4
K=1.1
ki=[10:39:400];

kp=[0.1:2:20];
L1=length(ki);
L2=length(kp);


dmem=zeros(L1,L2);
ferr=zeros(L1,L2);

for n=1:L1
    for m=1:L2

    KI=ki(n);
    KP=kp(m);
    sim('run.slx');

    vd=Vd(1800:3800);
    vq=Vq(1800:3800);
    f=Freq(1800:3800);


    %计算频率的超调量
    max_f=max(f);
    min_f=min(f);
    f_final=mean(Freq(end-3000:end));%取最后100个作为稳态值

    %同时计算上下超调 调选大的
    d1=abs(max_f-f_final);
    d2=abs(min_f-f_final);

    if(d2>=d1)
        d=d2;
    else
        d=d1;
    end

    dmem(n,m)=d/f_final;%转换百分比
    ferr(n,m)=abs(f_final/2/pi-50)/50;
    end
end

figure;
surf(dmem);
xlabel('Ki')
ylabel('Kp')
zlabel('OVERSHOOT')
figure;
surf(ferr);
xlabel('Ki')
ylabel('Kp')
zlabel('STEADY-STATE ERROR')

