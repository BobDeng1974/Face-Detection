function [Integral]=CalIntegral(FacePicture,num,PicHeight,PicWidth)
%�������ͼ
Integral=[];
%IntegralΪ����ͼ����
%Integral(:,:,i)Ϊ��i��ͼƬ�Ļ���ͼ
%����FacePicture��uint8������ʱҪ��ת����double���� 
for i=1:num
    Integral(1,1,i)=double(FacePicture(1,1,i)); %��һ��Ԫ��
    for j=2:PicHeight %������һ��Ԫ��
        Integral(j,1,i)=Integral(j-1,1,i)+double(FacePicture(j,1,i));
    end
    for z=2:PicWidth %�����һ��Ԫ��
        Integral(1,z,i)=Integral(1,z-1,i)+double(FacePicture(1,z,i));
    end
    for j=2:PicHeight %ʣ�µ�Ԫ��
        for z=2:PicWidth
            Integral(j,z,i)=Integral(j-1,z,i)+Integral(j,z-1,i)+double(FacePicture(j,z,i))-Integral(j-1,z-1,i);
        end
    end
end