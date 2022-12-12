#20221115 이표본 둘이 같은지 물어볼때 8장
x<-mtcars[mtcars$cyl==4,"mpg"]
y<-mtcars[mtcars$cyl==6,"mpg"]
x
var.test(x,y)						#not equal to 1 이분산
t.test(x,y)						#not equal to -평균다름
t.test(x,y,var.equal=TRUE)			#NOT OK 그냥해봄

#표 그래프 그리기
mpg<-c(x,y)
cyl<-c(rep(4,length(x)),rep(6,length(y)))
xy<-data.frame(cyl,mpg)

aggregate(mpg~cyl,data=xy,mean)
aggregate(mpg~cyl,data=xy,sd)
boxplot(mpg~cyl,data=xy)



#혼자풀기
x<-InsectSprays[InsectSprays$spray=="B", "count"]
y<-InsectSprays[InsectSprays$spray=="F", "count"]

var.test(x,y)						#p-value 0.2294>0.05 등분산채택
t.test(x,y,var.equal=TRUE)			#등분산
sd(x)
sd(y)
count<-c(x,y)
spray<-c(rep("B",length(x)),rep("F",length(y)))
xyz<-data.frame(count,spray)

aggregate(count~spray,data=xyz,mean)
aggregate(count~spray,data=xyz,sd)
boxplot(count~spray,data=xyz)




