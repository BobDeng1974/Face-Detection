function [RectNum,sum12,sum13,sum22]=SumCalRect(PicHeight,PicWidth)
%����������(s,t����)�ľ��θ���,CalRectNumΪ�����������㺯��
s=1;t=2; %��������������
sum12=CalRectNum(s,t,PicHeight,PicWidth);
s=1;t=3;%��������������
sum13=CalRectNum(s,t,PicHeight,PicWidth);
s=2;t=2;%�����ľ�������
sum22=CalRectNum(s,t,PicHeight,PicWidth);
%�ܾ��θ���
RectNum=sum12*2+sum13*2+sum22;