function [HaarWeakClass]=Train1stOneWeakClass(HaarWeakClass,num,num1,Integral)
%һ���������� ��һ�� ѵ������
%HaarWeakClass Haar���������ṹ��
%��Ҫ������HaarWeakClass������ã����÷�ʽΪHaarWeakClass(i)������ֵҲ��������
%numΪ������ͼƬ������ num1Ϊ����������������
%IntegralΪ����ͼ����

%��������ֵ
%TempHaarF(i) Ϊ��һ���������Ե�i��ͼƬ������ֵf
for i=1:num
    TempHaarF(i)=CalHaarValue(Integral(:,:,i),HaarWeakClass.begin(1),HaarWeakClass.begin(2),HaarWeakClass.end(1),HaarWeakClass.end(2),HaarWeakClass.st(1),HaarWeakClass.st(2));
end

%���������������������һ������������ֵ����
%������TempSort������֮���ԭ���TempSortOrd 
%sort�����ý�������
[TempSort,TempSortOrd]=sort(TempHaarF);

%ȫ������������Ȩ�صĺ�TempT1
TempT1=num1/num;
%ȫ��������������Ȩ�صĺ�TempT1
TempT0=(num-num1)/num;
%�ڴ�Ԫ��֮ǰ�ķ�����������Ȩ�صĺ�TempS0
TempS0=0;
%�ڴ�Ԫ��֮ǰ������������Ȩ�صĺ�TempS1
TempS1=0;
%TempHaarErr(i) Ϊ��һ���������ԡ�����á��ĵ�i��ͼƬ��err
for i=1:num
    TempErr(i)=min([TempS1+TempT0-TempS0 TempS0+TempT1-TempS1]);
    if TempErr(i)==(TempS1+TempT0-TempS0)
        %���˽��ͣ�(S1+T0-S0)-(S0+T1-S1)=2(S1-S0)+(T0-T1)��
        %��T0=T1(��������=����������)��
        %��S1-S0<0,������ֵ��ʱ������������) TempErr(i)ȡ(S1+T0-S0)��ʾ����ʽ�����p=-1
        TempFlagP(i)=-1;
    else %Err(i)==(TempS0+TempT1-TempS1)
        %��S1-S0>0,������ֵ��ʱ����������)��TempErr(i)ȡ(S0+T1-S1)����ʾ����ʽ�����p=1
        TempFlagP(i)=1;
    end
    if TempSortOrd(i)<=num1 %����TempSortOrd(i)Ϊ����
        TempS1=TempS1+1/num;
    else %����TempSortOrd(i)Ϊ������
        TempS0=TempS0+1/num;
    end
end
%�����С�ķ������MinVal,�Ͷ�Ӧ��������TempSort�ı��MinI
[MinVal,MinI]=min(TempErr);
HaarWeakClass.theta=TempSort(MinI); 
HaarWeakClass.p=TempFlagP(MinI);