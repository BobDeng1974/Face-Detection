%Temp.m
%3.1.2�ڻ��õ�
%�������������� ��ʾ���ĸ������ݺ�˵��

load FinishWeak OptWeak JudgOut
load 1stOneWeakClass num num1
%��ʾ��������
TempWaek=OptWeak(3)
TempPicture=imread('faces\face00005.bmp');
imshow(TempPicture);
hold on
%����st=12��Haar�����ľ���
rectangle('position',[TempWaek.begin(2),TempWaek.begin(1),floor((TempWaek.end(2)-TempWaek.begin(2))/2)+1,TempWaek.end(1)-TempWaek.begin(1)+1],'Edgecolor','r');
rectangle('position',[TempWaek.begin(2)+floor((TempWaek.end(2)-TempWaek.begin(2))/2)+1,TempWaek.begin(1),floor((TempWaek.end(2)-TempWaek.begin(2))/2)+1,TempWaek.end(1)-TempWaek.begin(1)+1],'Edgecolor','g');

load 1stOneWeakClass Integral
%Y_N��ʾ�ж�Ϊ����,ʵ��ҲΪ����������
Y_Y=0;
%Y_N��ʾ�ж�Ϊ����,ʵ��Ϊ������������
Y_N=0;
%N_Y��ʾ�ж�Ϊ������,ʵ��Ϊ����������
N_Y=0;
%N_N��ʾ�ж�Ϊ������,ʵ��Ϊ������������
N_N=0;
for i=1:num
    TempHaarF=CalHaarValue(Integral(:,:,i),TempWaek.begin(1),TempWaek.begin(2),TempWaek.end(1),TempWaek.end(2),TempWaek.st(1),TempWaek.st(2));
    if TempHaarF <  TempWaek.theta
        if i<=num1
            Y_Y=Y_Y+1;
        else
            Y_N=Y_N+1;
        end
    else
        if i<=num1
            N_Y=N_Y+1;
        else
            N_N=N_N+1;
        end
    end
end
Y_Y,Y_N,N_Y,N_N,num1,num-num1

%3.3�ڻ��õ�
%ѵ���������������� ��Ȩ���������ж���ȷ����������
load FinishWeak OptWeak JudgOut
load 1stOneWeakClass num num1
load 1stOneWeakClass Integral
for x1=1:10
    OptWeak(x1).err
    %Y_N��ʾ�ж���ȷ����������
    Y_Y=0;
    %Y_N��ʾ�жϴ������������
    Y_N=0;
    for i=1:num
        TempHaarF=CalHaarValue(Integral(:,:,i),OptWeak(x1).begin(1),OptWeak(x1).begin(2),OptWeak(x1).end(1),OptWeak(x1).end(2),OptWeak(x1).st(1),OptWeak(x1).st(2));
        if OptWeak(x1).p*TempHaarF <  OptWeak(x1).p*OptWeak(x1).theta
            if i<=num1
                Y_Y=Y_Y+1;
            else
                Y_N=Y_N+1;
            end
        else
            if i<=num1
                N_Y=N_Y+1;
            else
                N_N=N_N+1;
            end
        end
    end
Y_Y=Y_Y+N_N
Y_N=Y_N+N_Y
end

%3.4.1�� ǿ����������
%��ǿ������ӵ�е�����������Խ��ʱ����ѵ�������ı������
load FinishWeak OptWeak WaekWeight JudgOut T
load 1stOneWeakClass num num1
for i=1:T
     StrongClass.weak=OptWeak(1:i);
     StrongClass.weakweight=WaekWeight(1:i);
     StrongClass.pass=0.5*sum(StrongClass.weakweight);
     TempJudgArr=zeros(1,num);
    %����ǿ����������ÿ�������ġ�����ֵ�� TempJudgArr(x)
    for x1=1:length(StrongClass.weak)
        for x2=1:num
            TempJudgArr(x2)=TempJudgArr(x2)+StrongClass.weakweight(x1).*JudgOut(x1,x2);
        end
    end
    TempP(i)=0; %��ȷ����������
    TempFP(i)=0; %����������
    for x=1:num
        if x<=num1
            if TempJudgArr(x)>=StrongClass.pass
                TempP(i)=TempP(i)+1;
            else
                TempFP(i)=TempFP(i)+1;
            end
        else
            if TempJudgArr(x)>=StrongClass.pass
                TempFP(i)=TempFP(i)+1;
            else
                TempP(i)=TempP(i)+1;
            end
        end
    end
    TempP(i)=TempP(i)/num;
    TempFP(i)=TempFP(i)/num;
end
plot(TempP)
xlabel('������������');
ylabel('�����');

%4.1�� ͼ���Ԥ����
%ֱ��ͼ����ʾ��
PictureName='1.jpg';
%��ȡͼƬ
PictureTemp=imread(PictureName);
%ת��Ϊ�Ҷ�
PictureTemp=rgb2gray(PictureTemp);
imshow(PictureTemp)
%�ԻҶ�ͼ����ֱ��ͼ����
PictureTemp=histeq(PictureTemp);
imshow(PictureTemp)

%��������� ����� �� ʵ�ʼ����
x=[6 8 9 12 15];
y1=[0.8131 0.686 0.6213 0.4465 0.31]; %���������
y2=[0.8909 0.8795 0.8818 0.8477 0.7818]; %ʵ�ʼ����
y3=[445 297 196 71 23];
%��������� ��ʵ�ʼ����
plot(x,y1,'k-*')
axis([6 15 0 1])
xlabel('ǿ����������')
ylabel('�����')
hold on
plot(x,y2,'k--^')

%������
plot(x,y3,'k-^')
xlabel('ǿ����������')
ylabel('������')

%���Լ��ʱ��
tic
TrainPicSize=20; %ѵ��ʱͼƬ�ߴ�
PictureName='testpx\1.jpg';
[SimpleOut,OutPut]=Test(PictureName,TrainPicSize);
toc