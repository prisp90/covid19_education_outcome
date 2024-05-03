 dataset <- read.csv('../Data/neas/math_4_2019.csv')
 
 #Model
 model <- lm(.. ~ ., data=dataset)
 summary(model)
 
 #Boxplot
 library(ggplot2)
 ggplot(dataset, aes(var1, var2)) + geom_boxplot()
         
 #Template code to calculate cooks distances
 cook = cooks.distance(model)
 sample_size <- nrow(dataset)
 plot(cook, cex=2, main="Cook's distance")
 abline(h = 1, col="darkred")
 text(x=1:length(cook)+1, y=cook, labels=ifelse(cook>1, names(cook),""), col="darkred", offset = 0.5, pos=4)
 
 #VIF threshold
 R2_model <- 1 #R2 of model here
 threshold <- max(10, 1/(1-R2_model))
 vif(model2)
 
 #Checking model residuals
 library(MASS)
 resids = stdres(model)
 plot(dataset[,1],resids,xlab="Variable",ylab="Residuals") 
 abline(0,0,col="red") 
 
 #Model standardized residuals vs fitted values
 fits <- model$fitted.values
 plot(fits, resids, xlab="Fitted Values",ylab="Residuals") 
 abline(0,0,col="red")
 
 #Histogram and qqplot to check normality
 qqPlot(resids, ylab="Residuals", main = "")
 hist(resids, xlab="Residuals", main = "",nclass=10,col="orange")
 
 