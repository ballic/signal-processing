clc
clear 
close all
%% parameter
fs=64e3*40;
Ts=1/fs;
fb=10e3;
Tb=1/fb;
alpha=0.5;
L=256*6;
t=(-L/2:L/2-1)/fs;
t(L/2+1)=1e-9;
pi=3.1415926;
%% root raised cosine
h1=(sin((1-alpha)*pi*t/Tb)+4*alpha*t/Tb.*cos((1+alpha)*pi*t/Tb))./(pi*t/Tb.*(1-(4*alpha*t/Tb).^2));
h1=h1/(2*pi);% 2pi�������ȡ�ģ�ò�ƿ����������ҷ�ֵΪ1

xxx=ones(1,100)+2*ones(1,100)*j;
xxxx=zeros(1,4000);
xxxx(1:40:end)=xxx;
aaa=conv(h1,(xxxx)).';
aaa=aaa(1:64:end);
IQ_out=sym_synch_Gardner(aaa);
aaaaaaaa
h_rcos=conv(h1,h1);
H1=fftshift(fft(h1));
H_rcos=fftshift(fft(h_rcos));
figure
subplot(2,2,1)
plot(h1);title('h')
subplot(2,2,2)
plot(h_rcos);title('conv(h,h)')
subplot(2,2,3)
plot(abs(H1));title('H')
subplot(2,2,4)
plot(abs(H_rcos));title('H rcos')

%% raised cosine
h=sin(pi*t/Tb).*cos(pi*alpha*t/Tb)./(pi*t/Tb.*(1-(2*alpha*t/Tb).^2));
figure
subplot(2,1,1)
plot(h)
subplot(2,1,2)
plot(abs(fftshift(fft(h))))

% compare
figure
for  alpha=0.2:0.2:0.8
    h=sin(pi*t/Tb).*cos(pi*alpha*t/Tb)./(pi*t/Tb.*(1-(2*alpha*t/Tb).^2));
    plot(h)
    hold on
end
hold off
legend('alpha=0.2','alpha=0.4','alpha=0.6','alpha=0.8')
figure
for  alpha=0.2:0.2:0.8
    h=sin(pi*t/Tb).*cos(pi*alpha*t/Tb)./(pi*t/Tb.*(1-(2*alpha*t/Tb).^2));
    H=abs(fftshift(fft(h)));
    plot(H)
    hold on
end
hold off
legend('alpha=0.2','alpha=0.4','alpha=0.6','alpha=0.8')

%% matlab func
rf = 0.6;
span = 60;
sps = 64 ;
h1 = rcosdesign(rf,span,sps,'sqrt');
h_rcos=conv(h1,h1);
figure
subplot(2,2,1)
plot(h1);title('h')
subplot(2,2,2)
plot(h_rcos);title('conv(h,h)')
subplot(2,2,3)
plot(abs(H1));title('H')
subplot(2,2,4)
plot(abs(H_rcos));title('H rcos')

figure
for  rf=0.2:0.2:0.8
    h1 = rcosdesign(rf,span,sps,'normal');
    H=abs(fftshift(fft(h1)));
    plot(H)
    hold on
end
legend('alpha=0.2','alpha=0.4','alpha=0.6','alpha=0.8')
