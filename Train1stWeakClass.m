function [HaarWeakClass,i]=Train1stWeakClass(num,num1,Integral,PicHeight,PicWidth)
%Train1stWeakClassΪ �������� ��һ�� ѵ������
%HaarWeakClass Haar���������ṹ��
%numΪ������ͼƬ������ num1Ϊ����������������
%IntegralΪ����ͼ����
%ͼƬ���ȷ���������PicHeight,ͼƬ���ȷ���������PicWidth һ��������������;
%iΪ������������ֵ
%����HaarWeakClass�ṹ�� ����ĸ�ֵֻΪ������û��ʵ�ʺ���
HaarWeakClass.theta=0;
HaarWeakClass.begin=[1,1];
HaarWeakClass.end=[1,1];
HaarWeakClass.st=[1,1];
HaarWeakClass.p=1;
HaarWeakClass.err=0;
i=1; %iΪ������������ֵ
s=1;t=2; %�������������� s,t=1,2
[HaarWeakClass,i]=Train1stWeakClassST(HaarWeakClass,num,num1,Integral,PicHeight,PicWidth,s,t,i);
s=2;t=1; %�������������� s,t=2,1
[HaarWeakClass,i]=Train1stWeakClassST(HaarWeakClass,num,num1,Integral,PicHeight,PicWidth,s,t,i);
s=1;t=3; %�������������� s,t=1,3
[HaarWeakClass,i]=Train1stWeakClassST(HaarWeakClass,num,num1,Integral,PicHeight,PicWidth,s,t,i);
s=3;t=1; %�������������� s,t=3,1
[HaarWeakClass,i]=Train1stWeakClassST(HaarWeakClass,num,num1,Integral,PicHeight,PicWidth,s,t,i);
s=2;t=2; %�����ľ������� s,t=3,1
[HaarWeakClass,i]=Train1stWeakClassST(HaarWeakClass,num,num1,Integral,PicHeight,PicWidth,s,t,i);
i=i-1;