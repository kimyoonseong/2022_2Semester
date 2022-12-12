#9장 둘사이 어떤 영향을 미치는지 물어볼때. 회귀분석문제
x<-mtcars[mtcars$am==0,"hp"]
y<-mtcars[mtcars$am==0,"mpg"]
fit<-lm(y~x)
fit
anova(fit)


state.x77<-data.frame(state.x77)
fit <-lm(Life.Exp~Illiteracy,data=state.x77)
fit
anova(fit)#분산분석표 0.05>유의확률 회귀모형이 유의하다
summary(fit)#계수유의성검정
#위에서 0.05>유의확률 절편이 유의하다 
#밑에거 0.05>유의확률 기울기가 유의하다
#그림
plot(state.x77$Illiteracy,state.x77$Life.Exp ,xlab="문맹률 %",ylab="기대수명")
abline(fit)

plot(state.x77$Illiteracy,state.x77$Life.Exp,main="문맹률과 수명",xlab="문맹률",ylab="수명")
abline(fit)

#잔차도를 이용한 모형진단
par(mfrow=c(2,2))
plot(fit)
shapiro.test(fit$residuals)