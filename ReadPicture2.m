function [FacePicture]=ReadPicture2(CharP,num,begin)
%ͼƬ��ȡ�ĵڶ��ֺ���
%numΪͼƬ����
%CharPΪͼƬǰ׺
%beginΪͼƬ�ļ���������ʼֵ
FacePicture=[];
for i=begin:begin+num-1
    %PictureNameΪҪ��ȡ���ļ���
    PictureName=[CharP num2str(i) '.bmp'];
    PictureTemp=imread(PictureName);
    %bmp��ʽ��ȡ����RGBֵ����ͼƬΪ�Ҷȣ�RGBֵ��ͬ����ֻȡRֵ
    PictureTemp=PictureTemp(:,:,1);
    %FacePictureΪԭʼ����ͼƬ����
    %FacePicture(:,:,i)Ϊ��i��ͼƬ
    FacePicture=cat(3,FacePicture,PictureTemp);
end