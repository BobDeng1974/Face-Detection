function [sum]=CalRectNum(s,t,PicHeight,PicWidth)
%����������(s,t����)�ľ��θ���
%ͼƬ���ȷ���������PicHeight,ͼƬ���ȷ���������PicWidth һ��������������
sum=0; %���θ���
for x1=1:PicHeight-s+1
    for y1=1:PicWidth-t+1
        sum=sum+floor((PicHeight-x1+1)/s)*floor((PicWidth-y1+1)/t);
    end
end