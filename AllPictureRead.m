function [PictureSam,num,num1]=AllPictureRead()
%��ȡ����������������
num1=2429;
CharP='faces\face';
begin=1;
PictureSam=ReadPicture(CharP,num1,begin);
%��ȡ�������������
num2=559;
CharP='nonfaces\B1_';
begin=1;
PictureSam=cat(3,PictureSam,ReadPicture(CharP,num2,begin));
%---
num2=341;
CharP='nonfaces\B5_';
begin=0;
PictureSam=cat(3,PictureSam,ReadPicture(CharP,num2,begin));
%---
num2=538;
CharP='nonfaces\B20_';
begin=1507; %1507-2044
PictureSam=cat(3,PictureSam,ReadPicture(CharP,num2,begin));
%---
num2=1255;
CharP='nonfaces\B20_';
begin=3051; %3051-4305
PictureSam=cat(3,PictureSam,ReadPicture(CharP,num2,begin));
%---
num2=228;
CharP='nonfaces\geyser27_';
begin=0; 
PictureSam=cat(3,PictureSam,ReadPicture2(CharP,num2,begin));
%---
num2=228;
CharP='nonfaces\goldwater67_';
begin=0; 
PictureSam=cat(3,PictureSam,ReadPicture2(CharP,num2,begin));
%---
num2=228;
CharP='nonfaces\graves111_';
begin=0; 
PictureSam=cat(3,PictureSam,ReadPicture2(CharP,num2,begin));
%---
num2=165;
CharP='nonfaces\GULF_';
begin=0; 
PictureSam=cat(3,PictureSam,ReadPicture2(CharP,num2,begin));
num2=559+341+538+1255+228+228+228+165; %��������������
num=num1+num2; %�����ܸ���