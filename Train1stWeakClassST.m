function [HaarWeakClass,i]=Train1stWeakClassST(HaarWeakClass,num,num1,Integral,PicHeight,PicWidth,s,t,i)
%Train1stWeakClassSTΪ ���ڲ�ͬ��s.t������ �������� ��һ�� ѵ������
%HaarWeakClass Haar���������ṹ��
%������HaarWeakClass�������
%numΪ������ͼƬ������ num1Ϊ����������������
%IntegralΪ����ͼ����
%Real(i) ����i�Ƿ�Ϊ�������������ı�־ 1Ϊ������-1Ϊ������
%ͼƬ���ȷ���������PicHeight,ͼƬ���ȷ���������PicWidth һ��������������;
%iΪ������������ֵ
for x1=1:PicHeight-s+1
    for y1=1:PicWidth-t+1
        for x2=x1+s-1:s:PicHeight
            for y2=y1+t-1:t:PicWidth
                HaarWeakClass(i).begin=[x1 y1];
                HaarWeakClass(i).end=[x2,y2];
                HaarWeakClass(i).st=[s,t];
                HaarWeakClass(i)=Train1stOneWeakClass(HaarWeakClass(i),num,num1,Integral);
                i=i+1;
            end
        end
    end
end