#
library(MASS)
help(Cars93)
with(Cars93,plot(Horsepower,MPG.highway))
fit<-lm(MPG.highway~Horsepower,data=Cars93)X
abline(fit)
boxplot(Horsepower ~Type,data=Cars93)
boxplot(Price~AirBags,data=Cars93)

UScrime
names(UScrime)
with(UScrime,plot(Ed,y))

chickwts
boxplot(weight ~feed,data=chickwts)

library("MASS")

View(Cars93)
View(UScrime)
View(chickwts)
#chickwts예상
c<-chickwts[chickwts$feed=="soybean","weight"]
c
t.test(c,mu=230) 
qt(0.975,13)
shapiro.test(c)

#4-6
z<-Cars93[Cars93$Type=="Small","Horsepower"] #21개
z
mean(z)
sd(z)
t.test(z,mu=100)
shapiro.test(x)

#8-10
a<-Cars93[Cars93$Type=="Midsize","MPG.city"]
b<-Cars93[Cars93$Type=="Compact","MPG.city"]
var.test(a,b)
t.test(a,b,var.equal=TRUE)

#11-14
fit<-lm(y~GDP,data=UScrime)
fit
anova(fit)
summary(fit)
y<-Cars93[Cars93$Cylinders==6,"Horsepower"]
var.test(x,y)
t.test(x,y,var.equal=TRUE)


#15-17
aov.out<-aov(weight~feed,data=chickwts)
anova(aov.out)
duncan.test(aov.out,"feed",alpha=0.05,console=TRUE)


#19
mytable<-HairEyeColor[1:2,1:3,Sex="Male"]
mytable
chisq.test(mytable)
mytable$expected
x2<-chisq.test(mytable)
x2
x2$expected

#UScrime예상
a<-UScrime[UScrime$So==1,"GDP"]
b<-UScrime[UScrime$So==1,"Ineq"]
fit<-lm(b~a)
plot(a,b)
abline(fit)