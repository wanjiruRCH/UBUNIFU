#########################################################
#1. Understanding Variables in R

## Statistics generally classifies variables into quantitative and qualitative
## R Goes further for analysis purposes.
## The type determines the type of analysis to be done
## There are five classess.
## use the 'class' funtion to find variable type

## 1.1 Numeric: Can perform mathematics operations, have decimals
## Numerical analysis: sum, mean, mode, percentiles, 
## Graphical analysis; scatter plots, histograms, stem and leaf
numerals<-seq(1,10,.5)
class(numerals)

## 1.2 Integer: Can perform mathematics operations, whole numbers
## Numerical analysis: sum, mean, mode, percentiles
## Proportions
## Graphical analysis; scatter plots, stem and leaf, bar plots
integrals<-1:50
class(integrals)

## 1.3 Character: CanNOT perform mathematics operations
## Proportions
## Graphical analysis; Word clouds
characters<-letters
class(characters)

## 1.3 Character: CanNOT perform mathematics operations
## Proportions
## Graphical analysis; Word clouds
characters<-letters
class(characters)


## 1.4 Logical/Boolean: Mainly used for Subsetting
# Distinguish it from character. It has no quotes
## Proportions
## Graphical analysis; Bar plots
Booleans<-c(TRUE,FALSE)
class(Booleans)

## 1.5 Factors: Are CATEGORICAL variables
## R always automatically organizes the levels alphabetically
## Proportions
## Graphical analysis; Word clouds
factors<-factor(rep(1:3,4))
class(factors)
## Labels for each is the 'level' in R
## When unassigned, the values are default levels
levels(factors)
levels(factors)<-c("Form 1","Form 2","Form 3")
levels(factors)


#########################################################
#2. Understanding Data Structures in R
## R can read data in different types of 'ojects'
## Consider an object as a repository for holding data
## All objects created are seen at the 'environment' window

# We know about the scalar. But its not considered as a data structure in R
a<-1

# 2.1 Vectors
# Contains multiple values of the same variable type
# Their dinemsions are always n*1 or 1*n 
# All we created above are vestors
vector1<-1:10
vector1<-c(1,2,3,4,5,6,7,8,9,10)

# 'c' means to 'concatenate' or join.

# You can always add at the end
vector2<-c(vector1,21:25)
vector2

# Notice that 'hcaracter' variables are superior to numeric
# If concatenated, they all are coerced to character
vector3<-c(vector1,letters)
vector3
class(vector3)
# To select a value you give the name and he index of the position of the value
vector3[15]

# 2.2 Matrices
# Contains multiple values of the same variable type
# Their dinemsions are n*m
matrix1<-matrix(vector1,nrow=2,ncol =5)
# Toenter data along the row set the byrow argument as TRUE
matrix1<-matrix(vector1,nrow=2,ncol =5,byrow=TRUE)
# To select a value you give the name and he indeces 
#  of the position of the values or row and column
matrix1[2,2]

# The columns can be named
colnames(matrix1)<-c("First","Second","Third","Fourth","Fifth")
matrix1[2,"Third"]

# 2.3 Data frames
# COntains multiple columns of different variable types
# Their dinemsions are n*m
# To select a value you give the name and he indeces 
#  of the position of the values or row and column
vect1<-1:26
vect2<-letters
vect3<-rep(c(TRUE,FALSE),13)
data1<-data.frame(vect1,vect2,vect3)
class(data1)

# We can now look at the structure of the data frame
str(data1)

# We can View it WITHOUT editing
View(data1) #Capital 'V'

# We can View to EDIT
edit(data1) #The next chunk of code won't run till this pop up window is closed

# 2.4 list
# Can contain all the above mentioned three data structures
list1<-list(data1,vect2)
# Use the [[]] to access the data in the list
list1[[2]] # Gives the vect2
list1[[2]][7] # Gives the seventh entry in  vect2


#########################################################
#3. Randomizing data
# Use the rand functions. They can be uniform, normal, exponential
rnorm(n=20,mean = 50,sd=15) # randomizes normal
runif(n=20,min=10,max=100) #randomizes uniform
rexp(n=20) # randomizes exponential

## Set seed helps us randomize the same values
set.seed(100)
rnorm(n=2,mean = 50,sd=15) # All of us will get the same value
                            # 42.46711 51.97297

# You can view the distribution by plotting the histogram for the above data
hist(rnorm(n=2000,mean = 50,sd=15))
hist(runif(n=2000,min=10,max=100)) 
hist(rexp(n=2000))

#########################################################
#4. Reading in data
# First set the working directory (folder)
# Makes it easy to read data directly without including the file location
getwd() # Shows the current working folder
setwd("C:/Users/TJIJD/Dropbox/STUDENTS/Maseno/MAS/MIT 201 Statistical Computing 1/Data")
#Lets view the files that are in the folder
# List files gives the name of files and their extensions
list.files()

# We shall focus on CSV files for today
# Read and store it in an object

popdata<-read.csv2("populationEstimates.csv")
View(popdata)

## Notice that we need to skip some values rows. 
## We have the complete dataset, BUT
## Character values have been read as factors. 
popdata<-read.csv2("populationEstimates.csv",
                   header=TRUE,sep=",",skip=2)
str(popdata)

## Lets ensure that Character are imported as charcters
popdata<-read.csv2("populationEstimates.csv",
                   header=TRUE,sep=",",skip=2,stringsAsFactors=FALSE)


#########################################################
#5. Data Management in R 
# Data management includes
      # Checking for oddities
      # Editing where necessary
      # Subsetting, and in some cases
      # Sampling

## 5.1 Subsetting
# To subset use "[ rows, cols]" after the name of the data frame
# 'rows' gives indices of the rows you want, or condition to be met
# 'cols' gives indices of the columns you want, or condition to be met
# Syntax below subsets all rows, but the five indexd columns
# The new data frame is called 'populationSub'
popdata<-popdata[,c(2,9,17,25,32)]

# We can further rename the variables
names(popdata)<-c("State","Census","PopEstimate","Births","Deaths")

# 5.2 Structure set up can be sen by the str function
# We can convert the Census, PopEstimate to character
str(popdata)
popdata$Census<-as.numeric(popdata$Census)
popdata$PopEstimate<-as.numeric(popdata$PopEstimate)


## 5.3 Checking for oddities
# Can be done using simple summary functions or by ploting
# use mean to see if there are some NA values

mean(popdata$Births)
# There are NA values, We can calculate mean without them
mean(popdata$Births,na.rm=TRUE)

# Or subset them altogether.
# Summary gives the number of NAs that exist in all variables
summary(popdata)

# Check number of rows
nrow(popdata)

# subset the values that are actual values
DataNeeded<-!is.na(popdata$Births) & !is.na(popdata$Deaths)
popdata<-popdata[DataNeeded,]

summary(popdata)

# The NAs are no longer present for the Births and Deaths
# But there are strange figures that we may want to have a look at
# Lets sort births first
sort(popdata$Births,decreasing = TRUE)
sort(popdata$Births,decreasing = FALSE)
# There are no visible outlier values in the number of births

sort(popdata$Deaths,decreasing = TRUE)
sort(popdata$Deaths,decreasing = FALSE)

# In case we knew the correct values, then we could easily edi the values

# Now we have data we can start some analysis
#########################################################
#6. Analysis using the main R 

#6.1  Descriptive analysis
# Common ones are mean, percentiles and 
# You can already summarize entire data frame. 
# Same can be done for individual variables
summary(popdata$Births)
max(popdata$Births)

# You can get the position of the value of interest
which.max(popdata$Births)
which.min(popdata$Births)

# How many values are above the mean?
length(popdata$Births[popdata$Births>mean(popdata$Births)])

#6.2  Relationships
# 6.2.1 Correlation
# Correlation tests the level of relationship between two variables
cor(popdata$Births,popdata$Deaths)
# 'cor.test' add the test for significance
cor.test(popdata$Births,popdata$Deaths)

# The test has a p-value that is <0.05
# It is statistically significant
# The correlation value of '0.6' is moderately strong and positive

# 6.2.2 Linear models
# This is achieved by the 'lm' function
# The dependent variable is put on the left of the function
lm(Deaths~Births,data = popdata)

# To test the significance, you can summarize the model
lm1<-lm(Deaths~Births,data = popdata)
summary(lm1)

# The model is statistically significant
# The coefficients are all statistically significant

# To add the regression line to the plot, use the 'abline' function
plot(popdata$Births,popdata$Deaths)

# Get the coefficients from the regression line
# Or type the 'lm' function in 'abline'
abline(lm1)

## 6.3 Comparing Means
## 6.3.1 t.test (Learn to interpret)
# It compares means between two groups
# Let us create a new factor variable, there are 3195 rows as shown below
nrow(popdata)
popdata$NewVar<-c(rep(1:2,floor(nrow(popdata)/2)),1)
popdata$NewVar<-as.factor(popdata$NewVar)
levels(popdata$NewVar)<-c("included","excluded")

# the new variable has two categories. We can conduct a t-test of births
t.test(Births~NewVar,data = popdata)

# Reslts shows that p-value is not significant.
# Mean Births in the different groups do not differ
# Mean births in the "included" group = 123.5788
# Mean births in the "excluded" group = 127.0491

## 6.3.2 ANOVA (Learn to interpret)
# It compares means between more than two groups
# We shall again create another variable with four categories
popdata$NewVar2<-c(rep(1:4,floor(nrow(popdata)/4)),1,2,3)
popdata$NewVar2<-as.factor(popdata$NewVar2)
levels(popdata$NewVar2)<-c("Group 1","Group 2","Group 3","Group 4")

# By default, 'group 1' will be the base group
# Means from other groups will be compared to it
# ANOVA is conducted using the 'aov' function
aov(Births~NewVar2,data = popdata)
summary(aov1)

# To see the 'coefficients' for all the groups, call them as below
aov1<-aov(Births~NewVar2,data = popdata)
coefficients(aov1)
TukeyHSD(aov1)

# Notice that the level base mean is used
# Other means are compared as 'deviation' from the base mean
# TukeyHSD shows the confidence intervale for each of the group sets


#########################################################
#7. Grahical analysis in R
# To plot use barplot, plot, histogram etc
# One can plot multiple photos in order to use them together on the same plot
Group<-levels(popdata$NewVar2)
means<-numeric(0)
for(i in Group){
  means[i]<-mean(popdata$Births[popdata$NewVar2==i],)
}

# Lets split the window to hold two plots
par(mfrow=c(1,2))
#First plot (Linear model plot)
plot(popdata$Births,popdata$Deaths)
abline(lm1)

# Second plot
barplot(means,col = c(1,2,3,4))

#########################################################
#8. Functions in R

## CLT
# To demostrate the CLT, we shall create a function to 
# 1. Randomize data
# 2. Sample 1000 times
# 3. Plot the data
CLTfun<-function(n=1000,x=30,dist){
  # Randomize data
  if(dist=="normal"){
    data1<-rnorm(1000,55,15)
  } else if(dist=="uniform"){
    data1<-runif(1000,10,115)
  } else {
    data1<-rexp(1000)
  }
  means<-numeric(0)
  # Sample 1000, record mean
  for (i in 1:n){ 
    means[i]<-mean(sample(data1,x))
  }
  # Plot the data
  par(mfrow=c(1,1))
  hist(means)
}
CLTfun(n=1001,x=30,"normal")

#########################################################
#9. Importance of using packages

# The base R has limitations hence we can't figure out all the analysis
# However, there are packages/libraries that can help with some functions
# Notice how we calculated the means, we can use the aggregate function in plyr
# It will easily summarize the means for the different groups in one line of code

