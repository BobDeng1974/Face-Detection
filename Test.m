function [SimpleOut,OutPut]=Test(PictureName,TrainPicSize)
%Test Ϊ������⺯��
%PictureNameΪ������ͼƬ���ƣ���ַ��
%TrainPicSize ѵ��ʱͼƬ�ߴ�
%��ȡͼƬ
PictureTemp=imread(PictureName);
%ת��Ϊ�Ҷ�
PictureTemp=rgb2gray(PictureTemp);
%�ԻҶ�ͼ����ֱ��ͼ����
PictureTemp=histeq(PictureTemp);
%ͼƬ���ȷ���������PicHeight,ͼƬ���ȷ���������PicWidth
[PicHeight PicWidth]=size(PictureTemp);
%CalIntegral ����ͼƬ����ͼ����(����ѵ��ʱ�õĺ���)
%TestIntegralΪ����ͼ����
TestIntegral=CalIntegral(PictureTemp,1,PicHeight,PicWidth);
load FinishStrong StrongClass
%TestWindow ��ⴰ�ڽṹ
%TestWindow.begin ��ⴰ����ʼ���� [x1,y1]
%TestWindow.end ��ⴰ���յ����� [x2,y2]
%TestWindow.times �Ŵ���������ѵ��������С�ı�����
SimpleOut=[]; %SimpleOut �����ж�Ϊ�����ļ�ⴰ��
HorOffset=5; %��ⴰ��ˮƽƫ��������
VorOffset=5; %��ⴰ����ֱƫ��������
%TimesΪ���ķŴ���
Times=min([PicHeight/TrainPicSize PicWidth/TrainPicSize]);
for t=1:Times
    for x1=1:HorOffset:PicHeight-t*TrainPicSize+1 %ˮƽ���򻬶�����
        for y1=1:VorOffset:PicWidth-t*TrainPicSize+1 %��ֱ���򻬶�����
            TempFlag=1; %����ǳ�ֵ ǿ�����������Ϊ��������TempFlag=1
            for i=1:length(StrongClass) %��i��ǿ������
                TempOut=0; %ǿ����������������ֵ ��ֵ0
                for wi=1:length(StrongClass(i).weak) %��wi����������
                    %�����������ݵ�ǰ�ķŴ������Ŵ󴰿�
                    %[xx1 yy1],[xx2 yy2]Ϊ�Ŵ�������������������
                    xx1=x1-1+(StrongClass(i).weak(wi).begin(1)-1)*t+1; 
                    yy1=y1-1+(StrongClass(i).weak(wi).begin(2)-1)*t+1;
                    xx2=xx1-1+(StrongClass(i).weak(wi).end(1)-StrongClass(i).weak(wi).begin(1)+1)*t; %��
                    yy2=yy1-1+(StrongClass(i).weak(wi).end(2)-StrongClass(i).weak(wi).begin(2)+1)*t; %��
                    %��������������ֵ
                    TempHaarF=CalHaarValue(TestIntegral,xx1,yy1,xx2,yy2,StrongClass(i).weak(wi).st(1),StrongClass(i).weak(wi).st(2));
                    if StrongClass(i).weak(wi).p*TempHaarF < StrongClass(i).weak(wi).p*StrongClass(i).weak(wi).theta*t*t %�ж�Ϊ����
                        TempOut=TempOut+StrongClass(i).weakweight(wi);
                    end
                end
                if TempOut < StrongClass(i).pass 
                    break; %��ǿ�������ж�Ϊ��������������ѭ��
                elseif i==length(StrongClass) %���һ��ǿ���������ж�Ϊ����
                    TestWindow.begin=[x1,y1];
                    TestWindow.end=[x1-1+t*TrainPicSize,y1-1+t*TrainPicSize];
                    TestWindow.times=t;
                    SimpleOut=[SimpleOut TestWindow]; %�����ж�Ϊ�����Ĵ���
                end
            end
        end
    end
end

%-----�ѵõ����������ڷ���
%�����������ص������������ڵ�������һ�����������MerRatio(1/2),���ж�����������ͬһ������
MerRatio=1/2;
NoMerFlag=1; %1��ʾ����δ��������Ĵ��� 0��ʾ���д��ڶ��Ѿ������������
AreaTagNum=0; %�����Ǽ��� ���������ܹ��м�������
%AreaTag(i)��ʾ��i������������������
AreaTag=zeros(1,length(SimpleOut)); 
for i=1:length(SimpleOut)
    if AreaTag~=0 %���˴����Ѿ�����������
        continue; %������һ�����ڵ��ж�
    end
    %�жϴ˴����Ƿ������е�������
    for i2=1:length(SimpleOut)
        if AreaTag==0 %���˴���û��������
            continue; %������һ�����ڵ��ж�
        end
        %�ж�i��i2���ص�����
        xx1=max(SimpleOut(i).begin(1),SimpleOut(i2).begin(1));
        yy1=max(SimpleOut(i).begin(2),SimpleOut(i2).begin(2));
        xx2=min(SimpleOut(i).end(1),SimpleOut(i2).end(1));
        yy2=min(SimpleOut(i).end(2),SimpleOut(i2).end(2));
        if xx2<=xx1 | yy2<=yy1 %�������ڲ��ཻ
            continue; %������һ�����ڵ��ж�
        end
        CoinArea=(xx2-xx1+1)*(yy2-yy1+1); %�غ����
        if CoinArea>=SimpleOut(i).times*TrainPicSize*TrainPicSize | CoinArea>=SimpleOut(i2).times*TrainPicSize*TrainPicSize
            AreaTag(i)=AreaTag(i2); %�غ��������1/2 �򻮷ֵ�i2����������
            break;
        end
    end
    if AreaTag(i)~=0 %���˴����Ѿ�����������
        continue; %������һ�����ڵ��ж�
    end
    %�����е����SimpleOut(i)��Ȼû��������
    AreaTagNum=AreaTagNum+1;
    AreaTag(i)=AreaTagNum; %SimpleOut(i)����һ���µ�������   
end

%���û���κ��������� ���˳�����
if length(SimpleOut)==0
    OutPut=[];
    SimpleOut=[];
    return
end

%------ͬһ����Ĵ��ڽ��кϲ�
AreaNum=zeros(1,AreaTagNum); %AreaNum(i)��i����Ĵ��ڵļ���ֵ
TempWindow.begin=[0,0];
TempWindow.end=[0,0];
%OutPut����ֵ��
for i=1:AreaTagNum
    OutPut(i)=TempWindow;
end
%�ϲ�����
%Area(i) ��ʾ��i������
for i=1:length(SimpleOut)
    AreaNum(AreaTag(i))=AreaNum(AreaTag(i))+1;
    OutPut(AreaTag(i)).begin=OutPut(AreaTag(i)).begin+SimpleOut(i).begin;
    OutPut(AreaTag(i)).end=OutPut(AreaTag(i)).end+SimpleOut(i).end;
end
%�������Ĵ���ֵ
for i=1:AreaTagNum
    OutPut(i).begin=OutPut(i).begin./AreaNum(i);
    OutPut(i).end=OutPut(i).end./AreaNum(i);
end