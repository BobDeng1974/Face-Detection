function [InteValue]=CalInteValue(Integral,x1,y1,x2,y2)
%����һ�����ڵĻ���ֵ
%IntegralΪ����������ͼ����
%(x1,y1)Ϊ������ʼ���꣬(x2,y2)Ϊ�����յ�����
if x1~=1 & y1~=1
    InteValue=Integral(x2,y2)+Integral(x1-1,y1-1)-Integral(x1-1,y2)-Integral(x2,y1-1);
elseif y1~=1
    InteValue=Integral(x2,y2)-Integral(x2,y1-1);
elseif x1~=1
    InteValue=Integral(x2,y2)-Integral(x1-1,y2);
else
    InteValue=Integral(x2,y2);
end