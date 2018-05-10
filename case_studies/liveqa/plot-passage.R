library(ggplot2);
library(scales);

# Read data
data <- read.csv(file="passage_timings.txt",sep=",",header=TRUE);

# Subset the data
data <- subset(data, qlen < 32)

# Plot time/1000 since time is in milliseconds and we want it in seconds
plot <- ggplot(data, aes(factor(qlen), y=time/1000, fill=type))
plot <- plot + geom_boxplot()

# Note here instead of hand-writing the breaks vector, we use a sequence instead
plot <- plot + scale_x_discrete("Query Length", breaks=seq(0, 30, by=5))
plot <- plot + scale_y_continuous("Time [s]", breaks = seq(0, 100, by=10))

plot <- plot + scale_fill_manual(values=c("#8BCBDE"))

# Some horizontal lines to represent various times
plot <- plot + geom_hline(aes(yintercept=60), colour="red", linetype="dashed")
plot <- plot + geom_hline(aes(yintercept=50), colour="#FF6600", linetype="dashed")
plot <- plot + geom_hline(aes(yintercept=40), colour="orange",linetype="dashed")

# Remove the legend - we don't need it here
plot <- plot + guides(fill=FALSE)

# Don't use Libertine font here just to show the default
plot <- plot + theme(text = element_text(size = 25))

#plot <- plot + theme(axis.title.y=element_text(margin=margin(0,20,0,0)))

ggsave(plot,file="liveqa-pass.pdf",width=10,height=7)
embedFonts("liveqa-pass.pdf",options='-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -dSubsetFonts=true -dCompressFonts=true -dCompatibilityLevel=1.4')

