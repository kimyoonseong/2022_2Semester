#10장 분산분석법
aov.out<-aov(decrease~treatment,data=OrchardSprays)
anova(aov.out)# 대체로 동일하지않다 분산분석
summary(aov.out)
install.packages("agricolae")
library(agricolae)
duncan.test(aov.out,"treatment",alpha=0.05,console=TRUE)
 #다중비교

aggregate(count~spray,data=InsectSprays,mean)
TukeyHSD(aov.out) #0.05보다 크면 같다
boxplot(decrease~treatment,data=OrchardSprays)

#10장 시험
A<-c(6.9,6.9,8.8,7.8)
B<-c(10.1,11.0,8.2,6.8)
C<-c(15.0,14.9,15.5,14.3)
glucose<-c(A,B,C)
diet<-c(rep("A",4),rep("B",4),rep("C",4))
aov.out<-aov(glucose~diet)
summary(aov.out)
anova(aov.out)
