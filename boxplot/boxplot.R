library(ggplot2);
library(Cairo);

fancy_scientific <- function(l) {
     # turn in to character string in scientific notation
     l <- format(l, scientific = TRUE)
     l <- gsub("0e\\+00","0",l)
     # quote the part before the exponent to keep all the digits
     l <- gsub("^(.*)e", "'\\1'e", l)
     l <- gsub("e\\+","e",l)
     # turn the 'e+' into plotmath format
     l <- gsub("e", "%*%10^", l)
     l <- gsub("\\'1[\\.0]*\\'\\%\\*\\%", "", l)
     # return this as an expression
     parse(text=l)
}

#HEADER
#qid,system,value

# 1. Read data
data <- read.csv(file="boxplot.csv",sep=",",header=TRUE);

# 2. Plot the data. We want to plot each system against the value of k on the 
# x-axis. Since k is not discrete, we need to use factor(k) which will 
# discretize it.
# We are interested in the system timing, so that is our y value.
# We want to group by system, and we want to fill each
# boxplot with a different colour for each system
plot <- ggplot(data, aes(x=factor(k), y=time, group=interaction(k,system), fill=system))

# 3. Draws the boxplot
plot <- plot + geom_boxplot()

# 4. Fill in axis labels. We will use an italic k here
plot <- plot + scale_x_discrete(expression(paste(italic(k))), labels=c(10, 100, 1000))
plot <- plot + scale_y_continuous("Time [ms]")
# NOTE: Can also use scale_x_log10() or scale_y_log10() if desired

# 5. Make sure we are using the same text type as the paper we are writing
plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=25))

# 6. Set the colours for the boxes we made manually
plot <- plot + scale_fill_manual("System", values=c("A" = "#786fa6", 
                                                    "B" = "#f19066",
                                                    "C" = "#f5cd79",
                                                    "D" = "#778beb",
                                                    "E" = "#60a3bc",
                                                    "F" = "#cf6a87"))  

# 7. Move the legend if desired. Can have both positions such as "left", "right"
# or x/y coordinates
# Example 1:
#plot <- plot + theme(legend.position="bottom")

# Example 2:
#plot <- plot + theme(legend.position=c(0.2,0.8))

# Save the PDF
ggsave(plot,file="mboxplot.pdf",width=9,height=7, device=cairo_pdf)
embedFonts("mboxplot.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')
