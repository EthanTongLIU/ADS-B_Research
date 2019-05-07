close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%随机生成0 1矩阵%%%%%%%%%%%%%%%%%%%%%%%%%%
A=rand(1,24);
for i=1:1
for j=1:24
if A(i,j)<=0.5
A(i,j)=0;
else
A(i,j)=1;
end
end
end

B=rand(1,83);
for i=1:1
for j=1:83
if B(i,j)<=0.5
B(i,j)=0;
else
B(i,j)=1;
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%前导脉冲信号%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0:0.05:7.9999;Y=[];
width=0.5;       
ft0=rectpuls(t-0.25,width);%产生矩形波
ft1=rectpuls(t-1.25,width);
ft2=rectpuls(t-3.75,width);
ft3=rectpuls(t-4.75,width);
ft=ft0+ft1+ft2+ft3;%前导脉冲信号

%%%%%%%%%%%%%%%%%%%%%%%%%%%数据域信号%%%%%%%%%%%%%%%%%%%%%%%%%%
fc=1;
fs=10;
opt=0.5;
shengcheng= [1 A];
scr=[1,0,0,0,1,B];
[M N]=size(shengcheng);
scrg=[scr zeros(1,N-1)];
[q r]=deconv(scrg,shengcheng);                %多项式相除,r为余数
r=abs(r);
for i=1:length(r)               
    a=r(i);
    if ( mod(a,2)== 0 )
        r(i)=0;
    else
        r(i)=1;
    end
end
crcbm=r(length(scr)+1:end);              %获取余项
crc_encode_scr=bitor(scrg,r);            %或；余项加在原信号后面，组成新信号
disp('CRC编码信号')
disp(num2str(crc_encode_scr(1:25)))    %num2str意思是num变为str
        disp(num2str(crc_encode_scr(26:50)))
         disp(num2str(crc_encode_scr(51:75)))
          disp(num2str(crc_encode_scr(76:100)))
           disp(num2str(crc_encode_scr(101:112)))
x=0.5-0.5*crc_encode_scr;                %ppm编码
y=modulate(x,fc,fs,'ppm',opt);               %x被调信号，fc载波频率，fs采样频率
k=ones(2);           %1000*1000的方阵
y1=kron(y,k(1,:));       %矩阵乘法
t2=0:0.05:119.9999;
%数据信号
Y1=[ft,y1];     
figure
subplot(2,1,1)
plot(t2,Y1)
title('1090ES数据链ADS-B信号')
xlabel('时间/us')
ylabel('幅度值')
axis([0 120 -1.1 1.1]);