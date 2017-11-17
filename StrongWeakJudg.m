function [CurDivPRMin,CurDivFPRMax]=StrongWeakJudg(StrongClass,JudgOut,num,num1)
%ǿ�����������ж��������
%StrongClass ǿ�������ṹ ����ʱ��StrongClass(x)
%JudgOut(x,i) ��x���������������Ե�i���������ж�
%numΪ�������� num1Ϊ����������������
%CurDivPRMin ��ǰǿ�������ļ����
%CurDivFPRMax ��ǰǿ�������������
TempJudgArr=zeros(1,num);
%����ǿ����������ÿ�������ġ�����ֵ�� TempJudgArr(x)
for i=1:length(StrongClass.weak)
   for x=1:num
       TempJudgArr(x)=TempJudgArr(x)+StrongClass.weakweight(i).*JudgOut(StrongClass.num(i),x);
   end
end
TempP=0; %��ȷ��⵽��������
TempFP=0; %�����Ϊ�����ķ�������
for i=1:num
    if i<=num1 & TempJudgArr(i)>=StrongClass.pass
        TempP=TempP+1;
    elseif i>num1 & TempJudgArr(i)>=StrongClass.pass
        TempFP=TempFP+1;
    end
end
CurDivPRMin=TempP/num1;
CurDivFPRMax=TempFP/(num-num1);