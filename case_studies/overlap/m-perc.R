library(ggplot2);
library(scales);
library(grid);
library(gridExtra);
library(Cairo);


data <- read.csv(file="mg.txt",sep=" ",header=TRUE);

# Want to show how the overlap of the achieved results set compares to the expected results set as the number of postings processed approaches 100%
# Note that the 'expected' result is the rank-safe result, which is achieved by processing 100% of the postings
plot <- ggplot(data,aes(x=perc, y=overlap, group=factor(group), colour=factor(group), shape=factor(group), fill=factor(group)))

plot <- plot + geom_point(size=2.2)

plot <- plot + scale_x_continuous("% Postings Processed") + scale_y_continuous("Overlap", labels=percent)
plot <- plot + scale_colour_manual("No. Terms", labels=c("2-5", "6-10", "11-15", "17-20"), values = c("#00A779", "#0b5fa5", "#ff9400", "#ff5c00")) 
plot <- plot + scale_fill_manual("No. Terms", labels=c("2-5", "6-10", "11-15", "17-20"), values = c("#00A779", "#0b5fa5", "#ff9400", "#ff5c00")) 
plot <- plot + scale_shape_manual("No. Terms", labels=c("2-5", "6-10", "11-15", "17-20"), values = c(21,22,23,24))

plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=24), legend.position=c(0.86,0.47)) 

ggsave(plot,file="mg-overlap.pdf",width=10,height=7, device=cairo_pdf)
embedFonts("mg-overlap.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')
