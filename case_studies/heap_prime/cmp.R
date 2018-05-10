library(ggplot2);
library(scales);
library(grid);
library(gridExtra);
library(Cairo);

# This is a function that allows us to have nice looking 10^x y axis
fancy_scientific <- function(l) {
     # turn in to character string in scientific notation
     l <- format(l, scientific = TRUE)
     l <- gsub("0e\\+00","0",l)
     # quote the part before the exponent to keep all the digits
     l <- gsub("^(.*)e", "'\\1'e", l)
     l <- gsub("e\\+","e",l)
     # turn the 'e+' into plotmath format
     l <- gsub("e", "%*%10^", l)
     #l <- gsub("\\'1[\\.0]*\\'\\%\\*\\%", "", l)
     # return this as an expression
     parse(text=l)
}

#runs.txt 
#k algo heap query num_terms time_ms

# Read data
data <- read.csv(file="runs.txt",sep=" ",header=TRUE);

# Plot each algorithm across the x axis, time on the y axis, group by the algorithm x Heap setup
plot <- ggplot(data,aes(x=factor(algo), y=time_ms, group=interaction(algo,heap), fill=interaction(heap)))
plot <- plot + geom_boxplot()

# Facet into one facet per k value
plot <- plot + facet_grid(. ~ k)

plot <- plot + scale_x_discrete("Algorithm", labels=c("BMW","Wand"))

# Note the use of our new fancy scientific labels on the y axis :-)
plot <- plot + scale_y_log10("Time [ms]", labels=fancy_scientific, breaks = c(0.1, 1, 10, 100, 1000))

# Let's pick some nice colours
plot <- plot + scale_fill_manual("Algorithm", 
                                 values=c("#ff9f43", "#ff6b6b", "#2e86de"),
                                 labels=c("noprime" = "No Prime","oracle" = "Oracle","primed" = "K-th Priming"))

# Again, use our Libertine font
plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=22)) 

# Example of putting the legend at the top of the graph
plot <- plot + theme(legend.position="top")

ggsave(plot,file="cmp.pdf",width=10,height=7, device=cairo_pdf)
embedFonts("cmp.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')
