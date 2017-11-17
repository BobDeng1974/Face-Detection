clc,clear
%1.ͼƬ��ȡ
%AllPictureRead ��ȡ����������������
%num1Ϊ������������������num2Ϊ������������������
%PictureSam ����ͼƬ����
%PictureSam(:,:,i)Ϊ��i��ͼƬ
tic %Elapsed time is 6.823812 seconds.
[PictureSam,num,num1]=AllPictureRead();
toc
%ͼƬ���ȷ���������PicHeight,ͼƬ���ȷ���������PicWidth һ��������������;
%numΪ��������
[PicHeight PicWidth num]=size(PictureSam);
%2.CalIntegral���� �������ͼ
tic %Elapsed time is 35.040152 seconds.
Integral=CalIntegral(PictureSam,num,PicHeight,PicWidth);
toc
%IntegralΪ����ͼ����
%Integral(:,:,i)Ϊ��i��ͼƬ�Ļ���ͼ
%���û�õı��� ��ʡ�ռ�
clear PictureSam

%----һ�㲻������-----
%3.SumCalRect���� ����������(s,t����)�ľ����ܸ���
%sum12 ����(s,t����)Ϊ1,2�ľ��θ���
[RectNum,sum12,sum13,sum22]=SumCalRect(PicHeight,PicWidth);

%4.CalHaarValue���� ���㲻ͬHaar����������ֵ
%(x1,y1)Ϊ������ʼ���꣬(x2,y2)Ϊ�����յ�����
%CalInteValue���� ���ݻ���ͼ����һ�����εĻ���ֵ

%HaarWeakClass Haar���������ṹ��
%HaarWeakClass.theta ��ֵ
%HaarWeakClass.begin ����������ʼ���� [x1,y1]
%HaarWeakClass.end ���������յ����� [x2,y2]
%HaarWeakClass.st ������������ [s,t](��Ӧs,t����)
%HaarWeakClass.p ����ʽ�ķ��� 1��-1
%HaarWeakClass.err �������
%iΪ������������ֵ
%Train1stOneWeakClassΪ ��һ���������� ��һ�� ѵ������
%��һ��ѵ��ȷ��HaarWeakClass�ṹ��de theta��p
tic %Elapsed time is 8566.878533 seconds.
[HaarWeakClass,WeakNum]=Train1stWeakClass(num,num1,Integral,PicHeight,PicWidth)
toc
%�����һ��ѵ�������������� 1stOneWeakClass.mat
save 1stOneWeakClass HaarWeakClass WeakNum PicHeight PicWidth Integral num num1
%��һ��ѵ����� ������б��������õ��Ѿ����棩
clear all

%--------ѵ��300��������������-------------
clc,clear
load 1stOneWeakClass Integral num num1 HaarWeakClass WeakNum
%����Ȩ��SamWeight ��ֵΪ1/num
SamWeight=(1/num)*ones(1,num);
T=300; %TΪѭ��������Ҳ��ѵ������������������
tic %Elapsed time is 586460.479390 seconds.
for x=1:T
    MinErrVal=Inf; %MinErrVal ��С�������
    MinErrNum=0;  %MinErrNum ��С��������Ӧ�������������
    for y=1:WeakNum
        HaarWeakClass(y)=TrainOneWeakClass(HaarWeakClass(y),num,num1,Integral,SamWeight);
        if MinErrVal>=HaarWeakClass(y).err
            MinErrVal=HaarWeakClass(y).err;
            MinErrNum=y;
        end
    end
    %OptWeak(x) Ϊ��x�α���Ѱ�ҳ���������������
    OptWeak(x)=HaarWeakClass(MinErrNum);
    %���������������������
    HaarWeakClass(MinErrNum)=[];
    %�����������鳤�ȼ�һ
    WeakNum=WeakNum-1;
    Beta=OptWeak(x).err/(1-OptWeak(x).err);
    %����������Ȩֵ
    WaekWeight(x)=log(1/Beta);
    %��������Ȩֵ
    for i=1:num
        %��������ֵ
        TempHaarF=CalHaarValue(Integral(:,:,i),OptWeak(x).begin(1),OptWeak(x).begin(2),OptWeak(x).end(1),OptWeak(x).end(2),OptWeak(x).st(1),OptWeak(x).st(2));
        if i<=num1 %�����������Ϊ1
            TempY=1;
        else
            TempY=0; %�������������Ϊ0 �Լ�����ã����Ϊ-1�Ļ��ж���ȷҲ�������
        end
        if OptWeak(x).p*TempHaarF < OptWeak(x).p*OptWeak(x).theta %�ж�Ϊ����
            TempHaarH=1;
        else
            TempHaarH=0;
        end
        if TempY==TempHaarH %���ж���ȷ
            SamWeight(i)=SamWeight(i)*Beta; %�ͽ���Ȩֵ
        end
    end
    %����Ȩֵ��һ��
    SamWeight=SamWeight./sum(SamWeight);
end
toc

tic %Elapsed time is 15.184293 seconds.
%��ÿ���������������������������ж����
%JudgOut(x,i) ��x���������������Ե�i�����������
for x=1:T %T��������������
    for i=1:num
        %��������ֵ
        TempHaarF=CalHaarValue(Integral(:,:,i),OptWeak(x).begin(1),OptWeak(x).begin(2),OptWeak(x).end(1),OptWeak(x).end(2),OptWeak(x).st(1),OptWeak(x).st(2));
        if OptWeak(x).p*TempHaarF < OptWeak(x).p*OptWeak(x).theta %�ж�Ϊ����
             JudgOut(x,i)=1;
        else
            JudgOut(x,i)=0;
        end
    end
end
toc

%�������õı�����FinishWeak.mat��
%OptWeak(x) Ϊ��x�α���Ѱ�ҳ���������������
%WaekWeight(x) ��x������������Ȩֵ
%JudgOut(x,i) ��x���������������Ե�i�����������
%TΪѵ������������������
save FinishWeak OptWeak WaekWeight JudgOut T
save FinishWeakTemp SamWeight
%������б���
clear all
%-----------

clc,clear
%����������ѵ������ 
load FinishWeak OptWeak WaekWeight JudgOut T
load 1stOneWeakClass Integral num num1
tic %Elapsed time is 1.033488 seconds.
%DivPRMin ÿ��ǿ����������С����� 
DivPRMin=0.925;
%DivFPRMax ÿ��ǿ���������������� 
DivFPRMax=0.5;
%WholeFPR Ҫ������������������� 
WholeFPR=0.001;
%StrongClass ǿ�������ṹ
%StrongClass.weak(i) ǿ�������еĵ�i����������
%StrongClass.weakweight(i) ǿ�������еĵ�i������������Ȩֵ
%StrongClass.weaknum ǿ�������е�������������(û�����)
%StrongClass.pass �������������ֵ�����ڴ�ֵ�����ж�Ϊ��������
%StrongClass.PR ǿ����������ѵ�����������ռ����
%StrongClass.FPR ǿ����������ѵ�����������������
%StrongClass.num(i) ǿ����������������������ţ���OptWeak�еı�ţ�
MinWeakNum=3; %ÿһ��ǿ�����������е���С������������
CurFPR=1; %��ǰ�����������������
CurPR=1; %��ǰ�����������ļ����
i=1; %iΪ��ǰǿ�������ı��
WeakI=0;  %iΪ��ǰ���������ı��
LackFlag=0; %ȱ������������־ ��û���㹻�������������� LackFlag=1
while CurFPR>WholeFPR | i<=13 %����ǰ����������������ʴﲻ��Ҫ�� ��ǿ����������С�ڵ���5��
    weaknum=0; %weaknumΪ��ǰǿ���������е�������������
    CurDivPRMin=0; %��ǰǿ�������ļ����
    CurDivFPRMax=1; %��ǰǿ�������������
    while CurDivPRMin<DivPRMin | CurDivFPRMax>DivFPRMax
        %��ǿ����������������������
        if weaknum==0 %��ʼ�ķ���������
            if WeakI+MinWeakNum>T
                LackFlag=1; %��û���㹻��������������
                break; 
            end
            StrongClass(i).weak=OptWeak(WeakI+1:WeakI+MinWeakNum);
            StrongClass(i).weakweight=WaekWeight(WeakI+1:WeakI+MinWeakNum);
            StrongClass(i).num=WeakI+1:WeakI+MinWeakNum;
            WeakI=WeakI+MinWeakNum;
            weaknum=MinWeakNum;
        else
            if WeakI+1>T %��û���㹻��������������
                LackFlag=1;
                break;
            end
            %�ڴ�ǿ������������һ����������
            StrongClass(i).weak=[StrongClass(i).weak OptWeak(WeakI+1)];
            StrongClass(i).weakweight=[StrongClass(i).weakweight WaekWeight(WeakI+1)];
            WeakI=WeakI+1;
            weaknum=weaknum+1;
            StrongClass(i).num=[StrongClass(i).num WeakI];
        end
        %����ǿ�������ĸ������ܲ�������
        StrongClass(i).pass=0.5*sum(StrongClass(i).weakweight);
        %StrongWeakJudg ǿ�����������ж��������
        [CurDivPRMin,CurDivFPRMax]=StrongWeakJudg(StrongClass(i),JudgOut,num,num1);
    end
    if LackFlag==1 %��û���㹻��������������,���������
        WARNING='û���㹻��������������,��������'
            break;
    end
    StrongClass(i).PR=CurDivPRMin;
    StrongClass(i).FPR=CurDivFPRMax;
    CurFPR=CurFPR*StrongClass(i).FPR;
    CurPR=CurPR*StrongClass(i).PR;
    i=i+1;
end
toc
%���漶��������
%StrongClass ǿ�������ṹ
%CurPR �������������ڲ��������ļ����
%CurFPR �������������ڲ��������������
save FinishStrong StrongClass CurPR CurFPR
%������б���
clear all

%-----300�����������һ��ǿ������
NNN=300; %Ψһһ��ǿ��������������������
load FinishWeak OptWeak WaekWeight JudgOut
load 1stOneWeakClass num num1
StrongClass(1).weak=OptWeak(1:NNN);
StrongClass(1).weakweight=WaekWeight(1:NNN);
StrongClass(1).num=1:NNN;
%����ǿ�������ĸ������ܲ�������
StrongClass(i).pass=0.5*sum(StrongClass(i).weakweight);
%StrongWeakJudg ǿ�����������ж��������
[CurDivPRMin,CurDivFPRMax]=StrongWeakJudg(StrongClass(i),JudgOut,num,num1);
StrongClass(i).PR=CurDivPRMin;
StrongClass(i).FPR=CurDivFPRMax;

%-----���������� ������
clc,clear
tic
TrainPicSize=20; %ѵ��ʱͼƬ�ߴ�
for i=301:450
    if i<10
        PictureName=['faces_test\image_000' num2str(i) '.jpg']; 
    elseif i<100
        PictureName=['faces_test\image_00' num2str(i) '.jpg'];
    else
        PictureName=['faces_test\image_0' num2str(i) '.jpg'];
    end
    %Test���� �����������
    [SimpleOut,OutPut]=Test(PictureName,TrainPicSize);
    %-----��ʾ����������ͼƬ
    %ͼ�񴰿����1
    figure(1);  
    %��ԭͼ
    PictureTemp=imread(PictureName);
    %��ʾͼƬ
    imshow(PictureTemp);
    %���û���κ��������� �ͼ����һ��ͼ��
    if isempty(SimpleOut)
        continue;
    end
    
    hold on
    %��ʾƴ�Ϻ�ļ�ⴰ��
    for x=1:length(OutPut)  
        %�ڱ�Ǵ��ڴ���һ������ ����ɫ��
        rectangle('position',[OutPut(x).begin(2),OutPut(x).begin(1),OutPut(x).end(2)-OutPut(x).begin(2)+1,OutPut(x).end(1)-OutPut(x).begin(1)+1],'Edgecolor','r');
    end
    hold off
    %ƴ�Ϻ�ļ�ⴰ�ڱ�����OutPut�ļ�����
    print(1,'-djpeg',['OutPut/' num2str(i) '.jpeg']);
    %�ر�ͼ�񴰿�
    close
    
    %ͼ�񴰿����1
    figure(1);
    imshow(PictureTemp);
    hold on
    %��ʾƴ��ǰ�ļ�ⴰ��
    for x=1:length(SimpleOut) 
        rectangle('position',[SimpleOut(x).begin(2),SimpleOut(x).begin(1),SimpleOut(x).end(2)-SimpleOut(x).begin(2)+1,SimpleOut(x).end(1)-SimpleOut(x).begin(1)+1],'Edgecolor','r');
    end
    hold off
    %ƴ�Ϻ�ļ�ⴰ�ڱ�����OutPut�ļ�����
    print(1,'-djpeg',['SimpleOut/' num2str(i) '.jpeg']);
    %�ر�ͼ�񴰿�
    close
end
toc