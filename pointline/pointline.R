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
#k,qlen,algorithm,time

# 1. Read data
data <- read.csv(file="pointline.csv",sep=",",header=TRUE);

# 2. Plot the data. We are interested to compare time 
# across the various query lengths and k values for each algorithm
plot <- ggplot(data, aes(x=qlen, y=time, group=interaction(k,algorithm), linetype=factor(k), shape=factor(algorithm), colour=factor(algorithm)))

# 3. Draws the points and lines
plot <- plot + geom_point() + geom_line()

# 4. Fill in axis labels.
plot <- plot + scale_x_continuous("Query Length")
plot <- plot + scale_y_continuous("Time [ms]")
# NOTE: Can also use scale_x_log10() or scale_y_log10() if desired

# 5. Make sure we are using the same text type as the paper we are writing
plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=25))

# 6. Set the colours for the lines. We need one colour per system, as we
# set colour=factor(system)
plot <- plot + scale_colour_manual("Algorithm", values=c("A" = "#786fa6", 
                                                    "B" = "#f19066",
                                                    "C" = "#f5cd79"))
# Set the shapes now. We also need one shape per system
plot <- plot + scale_shape_manual("Algorithm", values=c(22,23,24))

# Set the line-types. We need one type of line for each k we have
plot <- plot + scale_linetype_manual(expression(paste(italic(k))), values=c("solid", "dashed"))


# 7. Move the legend if desired. Can have both positions such as "left", "right"
# or x/y coordinates
# Example 1:
#plot <- plot + theme(legend.position="bottom")

# Example 2:
#plot <- plot + theme(legend.position=c(0.2,0.8))

# Save the PDF
ggsave(plot,file="mpointline.pdf",width=9,height=7, device=cairo_pdf)
embedFonts("mpointline.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')
