#7장 분산을 모를때 일표본 T검정!! 0.05보다 유의확률크면 채택
st<-data.frame(state.x77)  #state.x77은 매트릭스임으로 dataframe으로 변환
st$Life.Exp
x<-c(st$Life.Exp)
x
t.test(x,mu=71)#검정통계량,자유도,유의확률, 신뢰구간,표본평균
qt(0.975,49) #기각역qt(구간,n-1)
sd(x)		 #표본표준편차
qqnorm(x)
qqline(x)
shapiro.test(x)#0.05보다 크므로 정규분포이다.
wilcox.test(x,mu=71)

