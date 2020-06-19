clear all
Tcs = 1e-4;
% H=tf([2*pi*50*0.8, 0],[1,2*pi*50*0.8,(2*pi*50)^2])
% Hd=c2d(H,Tcs,'foh')
% bode(Hd)
% grid on
k=[0.35:0.4:1.15];

L=length(k);

K=1;
w0=100*pi
for n=1:L

    numa=w0*K*Tcs*k(n)^2;
    numb=-w0*K*Tcs*k(n)^2;
    dena=1;
    denb=w0*K*Tcs*k(n)^2-2;
    denc=1+(w0*k(n)*K*Tcs)^2-w0*K*Tcs*k(n)^2;

    H=tf([numa numb], [dena denb denc], Tcs)
    %figure
    bode(H)
    grid on
    hold on
end
 