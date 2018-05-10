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
#querylength,count,dataset

# 1. Read data
data <- read.csv(file="barplot.csv",sep=",",header=TRUE);

# 2. Plot the data. Our x will be the querylength, y the count
plot <- ggplot(data, aes(x=querylength, y=count, group=dataset, fill=dataset))

# 3. Draws the bargraph. stat="identity" tells ggplot that we made calculated
# the counts ourselves, so it does not need to
plot <- plot + geom_bar(stat="identity")

# 4. Fill in axis labels. We will use an italic k here
plot <- plot + scale_x_continuous("Query Length", breaks=c(2,4,6,8,10))
plot <- plot + scale_y_continuous("Queries Observed")

# 5. Make sure we are using the same text type as the paper we are writing
plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=25))

# 6. Set the colours for the boxes we made manually
plot <- plot + scale_fill_manual("Dataset", values=c("A" = "#786fa6", 
                                                     "B" = "#f19066"))

# 7. Move the legend if desired. Can have both positions such as "left", "right"
# or x/y coordinates
# Example 1:
#plot <- plot + theme(legend.position="bottom")

# Example 2:
#plot <- plot + theme(legend.position=c(0.2,0.8))

# Save the PDF
ggsave(plot,file="mbarplot-stack.pdf",width=9,height=7, device=cairo_pdf)
embedFonts("mbarplot-stack.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')
