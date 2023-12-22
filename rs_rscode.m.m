%%%%%%2ASK 调制 解调 误码率%%%%%


clc; 
%产生二进制随机序列
x=ceil(rand(1,10000)-0.5);	%产生二进制随机序列并取大于x 的最小整数
figure(1)				%窗口1，包含时域谱和频域谱
subplot(2,1,1)			%分块图函数subplot，图形窗口分成2块子窗口的第1个图像
stairs(x);				%第1个图像
xlabel('时间 t');			%x轴标注
ylabel('序列值');			%y轴标注
title('二进制随机序列');	%添加图像标题
axis([1 21 -1 2])			%控制坐标轴的范围
grid on					%图像中添加栅格
%对随机序列进行频谱分析
FFT1=fft(x,128); 		%对随机序列进行傅里叶变换
FFT1=abs(FFT1);		%对傅里叶变换取绝对值
figure(1)
subplot(2,1,2)			%第2个图像
plot(FFT1);
xlabel('频率 f');
ylabel('幅度 FFT1');
title('随机序列频谱');
axis([0 128 0 50])
grid on

% ------------------------------载波信号---------------------

%载波信号
t=1/360:1/360:20; 		%载波时间范围
Fc=36;					%载波频率
carry=cos(2*pi*Fc*t); 	%正弦载波信号
figure(2)				%窗口2，包含时域谱和频域谱
subplot(2,1,1)
plot(carry);
xlabel('时间 t');
ylabel('幅度 carry');
title('载波信号'); 
axis([1 600 -2 2])
grid on

%对载波信号进行频谱分析
FFT2=fft(carry,256); 	%对载波信号进行傅里叶变换
FFT2=abs(FFT2);		%对傅里叶变换取绝对值
figure(2)
subplot(2,1,2)
plot(FFT2);
xlabel('频率 f');
ylabel('幅度 FFT2');
title('载波信号频谱'); 
axis([0 300 0 100])
grid on

% ------------------------------ASK的调制----------------------

%ASK的调制
 Fd=20;					%Fd为码速率，Fs为采样频率
 Fs=1000;
%y=real(pammod(x,2))'*carry;
y=dmod(x,Fc,Fd,Fs,'ask',2);%调用数字带通调制函数dmod进行2ASK调制
for i=1:20
    if x(i)==0
        yy(30*(i-1)+1:30*i)=0;
    else
        yy(30*(i-1)+1:30*i)=y(30*(i-1)+1:30*i);
    end 
end						
%对20个随机码元进行判别，若码元为0则该码元周期内调制信号为零
figure(3)
subplot(2,1,1)
plot(yy);
xlabel('时间 t');
ylabel('幅度 y');
title('已调信号');
axis([1 600 -2 2])
grid on


%对已调信号进行频谱分析
FFT3=fft(y,256); 		%对已调信号进行傅里叶变换
FFT3=abs(FFT3);		%对傅里叶变换取绝对值
figure(3)
subplot(2,1,2)
plot(FFT3);
xlabel('频率 f');
ylabel('幅度 FFT3');
title('已调信号频谱'); 
axis([0 256 0 50])
grid on

% --------------------------ASK的解调--------------------------
%ASK的解调
z=ddemod(y,Fc,Fd,Fs,'ask',2); %调用数字带通调制函数dmod进行2ASK解调
figure(4)					%对傅里叶变换取绝对值
subplot(2,1,1)
stairs(z);
xlabel('时间 t');
ylabel('幅度 z');
title('解调信号');
axis([1 21 -1 2])
grid on

%对解调信号进行频谱分析
FFT4=fft(z,64); 				%对解调信号进行傅里叶变换
FFT4=abs(FFT4);			%对傅里叶变换取绝对值
figure(4)
subplot(2,1,2)
plot(FFT4);
xlabel('频率 f');
ylabel('幅度 FFT4');
title('解调信号频谱'); 
axis([0 64 0 50])
grid on

% % % % % % % % % % % % % % % % % % % % % % % % 
%加入高斯小噪声,SNR为6
Ynt1=awgn(y,6);			%加入高斯小噪声，信噪比为6
figure(5)
subplot(2,1,1) 
plot(Ynt1);
xlabel('时间 t');
ylabel('幅度 Ynt1');
title('加小噪声信号');
axis([1 600 -2 2])
grid on

%对加小噪声信号进行频谱分析
FFT5=fft(Ynt1,256); 		%对加入小噪声的调制信号进行傅里叶变换
FFT5=abs(FFT5);			%对傅里叶变换取绝对值
figure(5)
subplot(2,1,2) 
plot(FFT5);
xlabel('频率 f');
ylabel('幅度 FFT5');
title('加小噪声信号频谱') 
axis([0 256 0 50])
grid on

%ASK加小噪声信号的解调及误码率
z1=ddemod(Ynt1,Fc,Fd,Fs,'ask',2); 
%调用数字带通调制函数dmod对加小噪声信号进行解调
[br,Pe1]=symerr(x,z1)		
%对解调后加小噪声信号误码分析，br为符号误差数，Pe1为符号误差率
figure(6)
subplot(2,1,1)
stairs(z1);
xlabel('时间 t');
ylabel('幅度 z1');
title('加小噪声解调信号');
axis([1 21 -1 2])
grid on

%对加小噪声解调信号进行频谱分析
FFT6=fft(z1,64); 		%对加入小噪声的解调信号进行傅里叶变换
FFT6=abs(FFT6);		%对傅里叶变换取绝对值
figure(6)
subplot(2,1,2)
plot(FFT6);
xlabel('频率 f');
ylabel('幅度 FFT6');
title('加小噪声解调信号频谱'); 
axis([0 64 0 50])
grid on

%加入高斯大噪声,SNR为-2
Ynt2=awgn(y,3);			%加入高斯大噪声，信噪比为-2
figure(7)
subplot(2,1,1) 
plot(Ynt2);
xlabel('时间 t');
ylabel('幅度 Ynt2');
title('加大噪声信号');
axis([1 600 -2 2])
grid on

%对加大噪声信号进行频谱分析
FFT7=fft(Ynt2,256); 	%对加入大噪声的调制信号进行傅里叶变换
FFT7=abs(FFT7);		%对傅里叶变换取绝对值
figure(7)
subplot(2,1,2) 
plot(FFT7);
xlabel('频率 f');
ylabel('幅度 FFT5');
title('加大噪声信号频谱') 
axis([0 256 0 50])
grid on

%ASK加大噪声信号的解调及误码率
z2=ddemod(Ynt2,Fc,Fd,Fs,'ask',2); 
%调用数字带通调制函数dmod对加大噪声信号进行解调
[br,Pe2]=symerr(x,z2)
%对解调后加大噪声信号误码分析，br为符号误差数，Pe1为符号误差率
figure(8)
subplot(2,1,1)
stairs(z2);
xlabel('时间 t');
ylabel('幅度 z2');
title('加大噪声解调信号');
axis([1 21 -1 2])
grid on

%对加大噪声解调信号进行频谱分析
FFT8=fft(z2,64); 		%对加入大噪声的解调信号进行傅里叶变换
FFT8=abs(FFT8);		%对傅里叶变换取绝对值
figure(8)
subplot(2,1,2)
plot(FFT8);
xlabel('频率 f');
ylabel('幅度 FFT6');
title('加大噪声解调信号频谱'); 
axis([0 64 0 50])
grid on

%误码分析
SNR=-10:2
for i=1:length(SNR); 
    Ynt3=awgn(y,SNR(i));	%加入高斯小噪声，信噪比从-10dB到10dB
Z=ddemod(Ynt3,Fc,Fd,Fs,'ask',2);
%调用数字带通解调函数ddemod对加噪声信号进行解调
 [br, Pe(i)]=symerr(x,Z);
%对解调后加大噪声信号误码分析，br为符号误差数，Pe(i)为符号误差率
end
figure(9)
semilogy(SNR,Pe);			% 调用semilogy函数绘制信噪比与误码率的关系曲线
xlabel('信噪比 SNR(r/dB)');
ylabel('误码率 Pe');
title('信噪比与误码率的关系');
axis([-10 10 0 1])
grid on

