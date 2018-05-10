Getting Started
===============

Requirements
------------
* R/RScript
* ggplot2
* cairo_pdf
* Probably a bunch of other stuff I can't remember

For the following, I assume the top of your `.R` file looks like:
```
library(ggplot2);
library(Cairo);
```

Input & Output
--------------
In this tutorial, I will assume all input is taken from pre-defined
csv files, and output to PDF files. This is not the *only* way, but
it is my preferred way.

### Reading CSV files
Assume you have a csv file with a header, named `m.csv`, as follows:
```
model,colour,age,size
xyz,red,12,22.12
xyz,blue,7,23.99
abc,green,21,30.22
...
abc,blue,4,10.23
```

You can read this into a data frame like so:
```
myData <- read.csv(file="m.csv", sep=",", header=TRUE);
```
### Subsets
If you don't want all of the available data, you can
choose to subset it. For example, let us assume that
we don't care about `xyz` models for now. Then, we can do:
```
mySubset <- subset(myData, model != "xyz");
```
If you wish to subset on multiple conditions, you can use AND/OR
semantics like so:
```
mySubset <- subset(myData, model != "xyz" & age > 2);
```

### Output
Assume you have created a ggplot object named myPlot, and you
want to write it to a file. The basic output command is called
`ggsave` and is generally called as follows:
```
ggsave(myPlot, width=9, height=7, device=cairo_pdf)
```

* width and height refer to the dimensions of the output PDF. I find that generally 9 wide and around 7 high is good for a *single column* and 18 wide and 7 high is good for a *double column* graph. Of course, this will depend on the TeX template, so I suggest trying a variety of sizes.
* device tells ggplot which PDF back-end to use. We will use cairo, as it allows special fonts to be used (more on this later)


Now we are ready to start making some plots.
