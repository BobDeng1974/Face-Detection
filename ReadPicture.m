function [FacePicture]=ReadPicture(CharP,num,begin)
%ͼƬ��ȡ
%numΪͼƬ����
%CharPΪͼƬǰ׺
%beginΪͼƬ�ļ���������ʼֵ
FacePicture=[];
for i=begin:begin+num-1
    if i<10
        %PictureNameΪҪ��ȡ���ļ���
        PictureName=[CharP '0000' num2str(i) '.bmp'];
    elseif i<100
            PictureName=[CharP '000' num2str(i) '.bmp'];
    elseif i<1000
        PictureName=[CharP '00' num2str(i) '.bmp'];
    else
        PictureName=[CharP '0' num2str(i) '.bmp'];
    end
    PictureTemp=imread(PictureName);
    %bmp��ʽ��ȡ����RGBֵ����ͼƬΪ�Ҷȣ�RGBֵ��ͬ����ֻȡRֵ
    PictureTemp=PictureTemp(:,:,1);
    %FacePictureΪԭʼ����ͼƬ����
    %FacePicture(:,:,i)Ϊ��i��ͼƬ
    FacePicture=cat(3,FacePicture,PictureTemp);
end