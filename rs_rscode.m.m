%%%%%%2ASK ���� ��� ������%%%%%


clc; 
%�����������������
x=ceil(rand(1,10000)-0.5);	%����������������в�ȡ����x ����С����
figure(1)				%����1������ʱ���׺�Ƶ����
subplot(2,1,1)			%�ֿ�ͼ����subplot��ͼ�δ��ڷֳ�2���Ӵ��ڵĵ�1��ͼ��
stairs(x);				%��1��ͼ��
xlabel('ʱ�� t');			%x���ע
ylabel('����ֵ');			%y���ע
title('�������������');	%���ͼ�����
axis([1 21 -1 2])			%����������ķ�Χ
grid on					%ͼ�������դ��
%��������н���Ƶ�׷���
FFT1=fft(x,128); 		%��������н��и���Ҷ�任
FFT1=abs(FFT1);		%�Ը���Ҷ�任ȡ����ֵ
figure(1)
subplot(2,1,2)			%��2��ͼ��
plot(FFT1);
xlabel('Ƶ�� f');
ylabel('���� FFT1');
title('�������Ƶ��');
axis([0 128 0 50])
grid on

% ------------------------------�ز��ź�---------------------

%�ز��ź�
t=1/360:1/360:20; 		%�ز�ʱ�䷶Χ
Fc=36;					%�ز�Ƶ��
carry=cos(2*pi*Fc*t); 	%�����ز��ź�
figure(2)				%����2������ʱ���׺�Ƶ����
subplot(2,1,1)
plot(carry);
xlabel('ʱ�� t');
ylabel('���� carry');
title('�ز��ź�'); 
axis([1 600 -2 2])
grid on

%���ز��źŽ���Ƶ�׷���
FFT2=fft(carry,256); 	%���ز��źŽ��и���Ҷ�任
FFT2=abs(FFT2);		%�Ը���Ҷ�任ȡ����ֵ
figure(2)
subplot(2,1,2)
plot(FFT2);
xlabel('Ƶ�� f');
ylabel('���� FFT2');
title('�ز��ź�Ƶ��'); 
axis([0 300 0 100])
grid on

% ------------------------------ASK�ĵ���----------------------

%ASK�ĵ���
 Fd=20;					%FdΪ�����ʣ�FsΪ����Ƶ��
 Fs=1000;
%y=real(pammod(x,2))'*carry;
y=dmod(x,Fc,Fd,Fs,'ask',2);%�������ִ�ͨ���ƺ���dmod����2ASK����
for i=1:20
    if x(i)==0
        yy(30*(i-1)+1:30*i)=0;
    else
        yy(30*(i-1)+1:30*i)=y(30*(i-1)+1:30*i);
    end 
end						
%��20�������Ԫ�����б�����ԪΪ0�����Ԫ�����ڵ����ź�Ϊ��
figure(3)
subplot(2,1,1)
plot(yy);
xlabel('ʱ�� t');
ylabel('���� y');
title('�ѵ��ź�');
axis([1 600 -2 2])
grid on


%���ѵ��źŽ���Ƶ�׷���
FFT3=fft(y,256); 		%���ѵ��źŽ��и���Ҷ�任
FFT3=abs(FFT3);		%�Ը���Ҷ�任ȡ����ֵ
figure(3)
subplot(2,1,2)
plot(FFT3);
xlabel('Ƶ�� f');
ylabel('���� FFT3');
title('�ѵ��ź�Ƶ��'); 
axis([0 256 0 50])
grid on

% --------------------------ASK�Ľ��--------------------------
%ASK�Ľ��
z=ddemod(y,Fc,Fd,Fs,'ask',2); %�������ִ�ͨ���ƺ���dmod����2ASK���
figure(4)					%�Ը���Ҷ�任ȡ����ֵ
subplot(2,1,1)
stairs(z);
xlabel('ʱ�� t');
ylabel('���� z');
title('����ź�');
axis([1 21 -1 2])
grid on

%�Խ���źŽ���Ƶ�׷���
FFT4=fft(z,64); 				%�Խ���źŽ��и���Ҷ�任
FFT4=abs(FFT4);			%�Ը���Ҷ�任ȡ����ֵ
figure(4)
subplot(2,1,2)
plot(FFT4);
xlabel('Ƶ�� f');
ylabel('���� FFT4');
title('����ź�Ƶ��'); 
axis([0 64 0 50])
grid on

% % % % % % % % % % % % % % % % % % % % % % % % 
%�����˹С����,SNRΪ6
Ynt1=awgn(y,6);			%�����˹С�����������Ϊ6
figure(5)
subplot(2,1,1) 
plot(Ynt1);
xlabel('ʱ�� t');
ylabel('���� Ynt1');
title('��С�����ź�');
axis([1 600 -2 2])
grid on

%�Լ�С�����źŽ���Ƶ�׷���
FFT5=fft(Ynt1,256); 		%�Լ���С�����ĵ����źŽ��и���Ҷ�任
FFT5=abs(FFT5);			%�Ը���Ҷ�任ȡ����ֵ
figure(5)
subplot(2,1,2) 
plot(FFT5);
xlabel('Ƶ�� f');
ylabel('���� FFT5');
title('��С�����ź�Ƶ��') 
axis([0 256 0 50])
grid on

%ASK��С�����źŵĽ����������
z1=ddemod(Ynt1,Fc,Fd,Fs,'ask',2); 
%�������ִ�ͨ���ƺ���dmod�Լ�С�����źŽ��н��
[br,Pe1]=symerr(x,z1)		
%�Խ�����С�����ź����������brΪ�����������Pe1Ϊ���������
figure(6)
subplot(2,1,1)
stairs(z1);
xlabel('ʱ�� t');
ylabel('���� z1');
title('��С��������ź�');
axis([1 21 -1 2])
grid on

%�Լ�С��������źŽ���Ƶ�׷���
FFT6=fft(z1,64); 		%�Լ���С�����Ľ���źŽ��и���Ҷ�任
FFT6=abs(FFT6);		%�Ը���Ҷ�任ȡ����ֵ
figure(6)
subplot(2,1,2)
plot(FFT6);
xlabel('Ƶ�� f');
ylabel('���� FFT6');
title('��С��������ź�Ƶ��'); 
axis([0 64 0 50])
grid on

%�����˹������,SNRΪ-2
Ynt2=awgn(y,3);			%�����˹�������������Ϊ-2
figure(7)
subplot(2,1,1) 
plot(Ynt2);
xlabel('ʱ�� t');
ylabel('���� Ynt2');
title('�Ӵ������ź�');
axis([1 600 -2 2])
grid on

%�ԼӴ������źŽ���Ƶ�׷���
FFT7=fft(Ynt2,256); 	%�Լ���������ĵ����źŽ��и���Ҷ�任
FFT7=abs(FFT7);		%�Ը���Ҷ�任ȡ����ֵ
figure(7)
subplot(2,1,2) 
plot(FFT7);
xlabel('Ƶ�� f');
ylabel('���� FFT5');
title('�Ӵ������ź�Ƶ��') 
axis([0 256 0 50])
grid on

%ASK�Ӵ������źŵĽ����������
z2=ddemod(Ynt2,Fc,Fd,Fs,'ask',2); 
%�������ִ�ͨ���ƺ���dmod�ԼӴ������źŽ��н��
[br,Pe2]=symerr(x,z2)
%�Խ����Ӵ������ź����������brΪ�����������Pe1Ϊ���������
figure(8)
subplot(2,1,1)
stairs(z2);
xlabel('ʱ�� t');
ylabel('���� z2');
title('�Ӵ���������ź�');
axis([1 21 -1 2])
grid on

%�ԼӴ���������źŽ���Ƶ�׷���
FFT8=fft(z2,64); 		%�Լ���������Ľ���źŽ��и���Ҷ�任
FFT8=abs(FFT8);		%�Ը���Ҷ�任ȡ����ֵ
figure(8)
subplot(2,1,2)
plot(FFT8);
xlabel('Ƶ�� f');
ylabel('���� FFT6');
title('�Ӵ���������ź�Ƶ��'); 
axis([0 64 0 50])
grid on

%�������
SNR=-10:2
for i=1:length(SNR); 
    Ynt3=awgn(y,SNR(i));	%�����˹С����������ȴ�-10dB��10dB
Z=ddemod(Ynt3,Fc,Fd,Fs,'ask',2);
%�������ִ�ͨ�������ddemod�Լ������źŽ��н��
 [br, Pe(i)]=symerr(x,Z);
%�Խ����Ӵ������ź����������brΪ�����������Pe(i)Ϊ���������
end
figure(9)
semilogy(SNR,Pe);			% ����semilogy��������������������ʵĹ�ϵ����
xlabel('����� SNR(r/dB)');
ylabel('������ Pe');
title('������������ʵĹ�ϵ');
axis([-10 10 0 1])
grid on

