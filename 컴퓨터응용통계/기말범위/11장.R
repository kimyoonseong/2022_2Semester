x<-c(A=20,B=55,C=25)
x<-as.table(x)
p<-c(1/4,1/2,1/4)
X2<-chisq.test(x,p=p)
X2    #유의확률 0.4724>0.05
X2$observed
X2$expected


r1<-c(6,34)
r2<-c(3,97)
M<-as.table(rbind(r1,r2))
dimnames(M)<-list(smoking=c("y","n"),LungCancer=c("y","n"))
M
X2<-chisq.test(M)
X2
X2$observed
X2$expected

#��������
mytable<-Titanic[1:3,"Male","Adult",]
mytable
chisq.test(mytable)

#과제1
r1<-c(66,34)
r2<-c(4,64)
M<-as.table(rbind(r1,r2))
X2<-chisq.test(M)
X2
X2$expected

# a. (참)
# b. 자유도는 1이다
# c. 0.05>유의확률이므로 독립이 아니다. (거짓)
# d. 기대빈도는 28.333 (참)
# 답:a,d

#과제2
t1<-c(120,205)
t2<-c(202,391)
N<-as.table(rbind(t1,t2))
X3<-chisq.test(N)
X3
X3$expected
#a. (참)
#b. 자유도=1 (참)
#c. 기대빈도는 113이다 (거짓)
#d. 0.05<유의확률 이므로 독립이다.(거짓)
#답(a,b)