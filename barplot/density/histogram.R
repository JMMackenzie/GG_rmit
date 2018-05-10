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
#dataset,value

# 1. Read data
data <- read.csv(file="density.csv",sep=",",header=TRUE);

# 2. Plot the data. We don't have explicit x/y here, we let ggplot handle it
# for us. After all, we are plotting a distribution. Note we need to use
# factor() to discretize the dataset value because it is an integer
plot <- ggplot(data, aes(value, group=factor(dataset), fill=factor(dataset)))

# 3. Create the plot. We use a binwidth of 2, meaning the buckets will be
# 2 units wide (ie, [1, 2], [3, 4], etc
plot <- plot + geom_histogram(binwidth=2)

# We will make two facets, on for each dataset
plot <- plot + facet_wrap(~dataset) 

# 4. Fill in axis labels.
plot <- plot + scale_x_continuous("Data value")
plot <- plot + scale_y_continuous("Count")

# 5. Make sure we are using the same text type as the paper we are writing
plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=25))

# 6. Set the colours for the boxes we made manually
plot <- plot + scale_fill_manual("Dataset", values=c("1" = "#786fa6", 
                                                     "2" = "#f19066"))

# 7. Move the legend if desired. Can have both positions such as "left", "right"
# or x/y coordinates
# Example 1:
#plot <- plot + theme(legend.position="bottom")

# Example 2:
#plot <- plot + theme(legend.position=c(0.2,0.8))

# Save the PDF
ggsave(plot,file="mhistogram.pdf",width=9,height=7, device=cairo_pdf)
embedFonts("mhistogram.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')
