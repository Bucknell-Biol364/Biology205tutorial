---
  title: "205Tutorial"
output: html_document
---
  
#Welcome to R Studio! This is a R Script, where all comments need to have a hashtag prior to the text(like this line). All code is like below:

summary(cars)

#Cars is an embedded data set that you can explore at another time, for now let's keep going.

## Including Plots

plot(pressure)

#Now that we know some basic R script functions, we will move onto BIOL205 data. Let's walk through importing data from Excel.

#In the upper left hand corner --> File --> Import Dataset --> Import from Excel --> Browse, and look for your Excel file.

#If done correctly, once you "import" your file, it should appear in your
#environment tab in the upper right panel. It should also automatically open in
#a separate tab next to this tab (upper left hand corner of R Studio).

#Another way to import an Excel spreadsheet is via code. Make sure the excel file you're looking for is located in the same directory (folder) as this file:

install.packages("readxl", repos = "https://cloud.r-project.org")
library(readxl)
For205Tutorial <- read_excel("For205Tutorial.xlsx")
print(For205Tutorial)

#Once imported, confirm that the data values are the same as when they were in Excel. 


print(For205Tutorial)


#If you want to view your data at any time, you can either select the tab above
#or create a chunk with the code shown above. Capitilization is very important
#so make sure the code is written with puncutation/capitalization, or it will
#not work.
#Now we're going to show you how to plot your data, via a scatterplot to create a standard curve.
#First, you'll have to install ggplot2. When installing packages, the package title must be in single quotes, as below. Go ahead and run this code chunk:

install.packages('ggplot2')

#Notice there is red text; sometimes red texts means there is an error, other
#times it is not. For this specific situation, this red text is good! It means
#our package worked and downloaded properly.
#Once you install the package you need, you have to activate the package, via running the code chunk below.


library(ggplot2)


#Great!

#Now, let's try a basic scatterplot. The first code line: ggplot(For205Tutorial)
#is describing what graphing package we're using, and also what dataset we are
#using The second code line "aes(For205Tutorial$`Protein conc. (mg/mL`),
#For205Tutorial$`Absorbance (at 595nm)`)" details the x and y axis,
#respectively, from that data set. We have to tell R Studio what data set we're
#using for each axis, and the $ sign denotes which column the data is coming
#from. The third code line is telling R Studio what type of graph we want;
#specifically we want a point plot, or scatterplot.

ggplot(For205Tutorial) +
  aes(For205Tutorial$`Protein conc. (mg/mL)`, For205Tutorial$`Absorbance (at 595 nm)`) +
  geom_point()

#This is a good start, but we need to change the axis labels; let's copy and paste the above code into another grey chunk. 

ggplot(For205Tutorial) +
  aes(For205Tutorial$`Protein conc. (mg/mL)`, For205Tutorial$`Absorbance (at 595 nm)`) +
  geom_point() +
  xlab("Protein conc. (mg/mL)") +
  ylab("Absorbance (595 mm)")

#So we changed the axis by using the functions "xlab" and "ylab", then telling R
#what we want our labels to be called. It's important to match each parenthesis.
#Next, we want to clean up the graph, getting rid of the grey background and the
#gridlines (remember, we're trying to produce a graph that can be published in a
#scientific journal).


ggplot(For205Tutorial) +
  aes(For205Tutorial$`Protein conc. (mg/mL)`, For205Tutorial$`Absorbance (at 595 nm)`) +
  geom_point() +
  xlab("Protein conc. (mg/mL)") +
  ylab("Absorbance (595 mm)") +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))


#We have a nice looking graph, so let's add the regression line with
#"geom_smooth(method=lm, se = FALSE, color="black")." This will allow a linear
#trendline.

ggplot(For205Tutorial) +
  aes(For205Tutorial$`Protein conc. (mg/mL)`, For205Tutorial$`Absorbance (at 595 nm)`) +
  geom_point() +
  xlab("Protein conc. (mg/mL)") +
  ylab("Absorbance (595 mm)") +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  geom_smooth(method=lm, se = FALSE, color="black")

#So great, we have a line for the standards. But what is that line? We can
#actually take a look at the equation of the line by using the lm function.
#Below you can see the lm() function, with our x and y in the parentheses,
#separated with a squiggly: lm(x ~ y). The left arrow then assigns this function
#to a variable called "lm1". (You might actually see this variable pop up in the
#"Environment" tab of the upper right panel.) We can do several things to this
#variable, such as simply printing it:


lm1 <- lm(For205Tutorial$`Protein conc. (mg/mL)` ~ For205Tutorial$`Absorbance (at 595 nm)`)
print(lm1)


#Under coefficients we can find the y-intercept (-0.1665) as well as the slope
#(1.1052). Putting this together we get the following equation: y = 1.1052x +
#-0.1665 , when x is the protein concentration and y is the absorbance. Let's
#try to put this equation on our plot:


ggplot(For205Tutorial) +
  aes(For205Tutorial$`Protein conc. (mg/mL)`, For205Tutorial$`Absorbance (at 595 nm)`) +
  geom_point() +
  xlab("Protein conc. (mg/mL)") +
  ylab("Absorbance (595 mm)") +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  geom_smooth(method=lm, se = FALSE, color="black") +
  geom_text(x = 0.4, y=0.9, label="y = 1.105x + -0.1665")


#Cool. But this isn't all we want to do. Let's say we measure an unknown sample
#and get the following absorbance value: We know y (absorbance) but we are
#looking for x (concentration). Rearranging the equation gives: x = (y +
#0.1665)/1.1052. We can actually make this into a new variable.

y1 = 0.5
x1 <- (y1 + 0.1665)/1.1052
print(x1)


#Let's break down the above code chunk. First we told them what our unknown y
#concentration is. The next line defines a new variable, x, from the equation of
#the line that we found up in chunk 9. The last line of code then prints our x
#variable: 0.603 mg/mL. We can ignore that bracketed number in our output. But,
#why did we label the y and x with a 1? That's so we can look at more unknowns.
#To do so, all you need to do is copy chunk 11 and change the "x1"s to "x2"s and
#so on. If you noticed, the x's and y's you make will appear in the Environment
#tab.


c <- For205Tutorial$`Absorbance (at 595 nm)`
d <- For205Tutorial$`Protein conc. (mg/mL)`
m <- lm(d ~ c, For205Tutorial)
lm_eqn <- function(For205Tutorial){
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, list(a = format(coef(m)[1], digits = 4), b = format(coef(m)[2], digits = 4), r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));
}
ggplot(For205Tutorial) +
  aes(For205Tutorial$`Protein conc. (mg/mL)`, For205Tutorial$`Absorbance (at 595 nm)`) +
  geom_point() +
  xlab("Protein conc. (mg/mL)") +
  ylab("Absorbance (595 mm)") +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  geom_smooth(method=lm, se = FALSE, color="black") +
  geom_text(x = 0.4, y = 0.9, label = lm_eqn(For205Tutorial), parse = TRUE)