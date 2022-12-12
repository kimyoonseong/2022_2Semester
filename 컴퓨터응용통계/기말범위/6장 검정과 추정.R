#7장
x<-c(state.x77$Life.Exp)
x<-state.x77$Life.Exp
data.frame(state.x77)
state.x77$Life.Exp

x<-c(state.x77$LifeExp)
t.test(x,mu=71)#(검정통계량,자유도,유의확률, 신뢰구간)
shapiro.test(x) # 샤피로-> 유의확률>0.05 정규분포이다
qqnorm(x)
qqline(x)
wilcox.test(x,mu=71)
qt(0.975,49) # 기각역,표본표준편차 
#2.0 (�Ⱒ��) > -0.63948 (������跮) �Ⱒ�����ʴ´�
#0.05 (���Ǽ���)<0.5255(����Ȯ��)     �Ⱒ�����ʴ´�