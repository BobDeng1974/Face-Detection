function [InteValue]=CalHaarValue(Integral,x1,y1,x2,y2,s,t)
%���㲻ͬHaar����������ֵ
%(x1,y1)Ϊ������ʼ���꣬(x2,y2)Ϊ�����յ�����
%IntegralΪ����������ͼ����
%CalInteValueΪ���ݻ���ͼ����һ�����εĻ���ֵ
%Haar�������㲻ͬ��(s,t����)
if s==1 & t==2 %�������������� s,t=1,2
    WhiteSum=CalInteValue(Integral,x1,y1,x2,y1+floor((y2-y1)/2));
    BlackSum=CalInteValue(Integral,x1,y1+floor((y2-y1)/2)+1,x2,y2);
elseif s==2 & t==1 %�������������� s,t=2,1
    WhiteSum=CalInteValue(Integral,x1,y1,x1+floor((x2-x1)/2),y2);
    BlackSum=CalInteValue(Integral,x1+floor((x2-x1)/2)+1,y1,x2,y2);
elseif s==1 & t==3 %�������������� s,t=1,3
    WhiteSum=CalInteValue(Integral,x1,y1,x2,y1+(y2-y1+1)/3-1);
    BlackSum=CalInteValue(Integral,x1,y1+(y2-y1+1)/3,x2,y1+((y2-y1+1)/3)*2-1);
    WhiteSum=WhiteSum+CalInteValue(Integral,x1,y1+((y2-y1+1)/3)*2,x2,y2);
elseif s==3 & t==1 %�������������� s,t=3,1
    WhiteSum=CalInteValue(Integral,x1,y1,x1+(x2-x1+1)/3-1,y2);
    BlackSum=CalInteValue(Integral,x1+(x2-x1+1)/3,y1,x1+((x2-x1+1)/3)*2-1,y2);
    WhiteSum=WhiteSum+CalInteValue(Integral,x1+((x2-x1+1)/3)*2,y1,x2,y2);
else %�����ľ������� s,t=2,2
    WhiteSum=CalInteValue(Integral,x1,y1,x1+floor((x2-x1)/2),y1+floor((y2-y1)/2));
    WhiteSum=WhiteSum+CalInteValue(Integral,x1+floor((x2-x1)/2)+1,y1+floor((y2-y1)/2)+1,x2,y2);
    BlackSum=CalInteValue(Integral,x1,y1+floor((y2-y1)/2)+1,x1+floor((x2-x1)/2),y2);
    BlackSum=BlackSum+CalInteValue(Integral,x1+floor((x2-x1)/2)+1,y1,x2,y1+floor((y2-y1)/2));
end
InteValue=WhiteSum-BlackSum;
     
    