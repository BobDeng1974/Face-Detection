function [HaarWeakClass]=TrainOneWeakClass(HaarWeakClass,num,num1,Integral,SamWeight)
%һ���������� ѵ������
%HaarWeakClass Haar���������ṹ��
%��Ҫ������HaarWeakClass������ã����÷�ʽΪHaarWeakClass(i)������ֵҲ��������
%numΪ������ͼƬ������ num1Ϊ����������������
%IntegralΪ����ͼ����
%����Ȩ��SamWeight

%��������ֵ
%TempHaarF Ϊ��һ���������Ե�i��ͼƬ������ֵf
%TempErr ���������������
TempErr=0;
for i=1:num
    %��������ֵ
    TempHaarF=CalHaarValue(Integral(:,:,i),HaarWeakClass.begin(1),HaarWeakClass.begin(2),HaarWeakClass.end(1),HaarWeakClass.end(2),HaarWeakClass.st(1),HaarWeakClass.st(2));
    if i<=num1 %�����������Ϊ1
        TempY=1;
    else
        TempY=0; %�������������Ϊ0 �Լ�����ã����Ϊ-1�Ļ��ж���ȷҲ�������
    end
    if HaarWeakClass.p*TempHaarF < HaarWeakClass.p*HaarWeakClass.theta %�ж�Ϊ����
        TempHaarH=1;
    else
        TempHaarH=0;
    end
    %����������
    TempErr=TempErr+SamWeight(i)*abs(TempHaarH-TempY);
end
HaarWeakClass.err=TempErr;