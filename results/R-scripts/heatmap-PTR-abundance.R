# Plot heatmap for correlation PTR-abundance

library(ggplot2)
library(dplyr)
library(ggcorrplot)
library(reshape2)
library(corrplot)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
data <- "../analysis-out/2-CorrelationPTR-Abundance/ptr-abundance-corr-groups.csv"
out_plot <- "../out_figures/Fig2A.png"

df <- read.csv(data)

df_corr <- select(df,"spearmanr_all","spearmanr_control","spearmanr_antibiotics", "spearmanr_early", "spearmanr_late")
plot.data <- as.matrix(df_corr)
rownames(plot.data) <- df$species
colnames(plot.data) <- c("All samples", "Control Cohort", "Antibiotics Cohort", "Early Life (DOL 1-30)", "Later Life (DOL>30)")
plot.data <- t(plot.data)

p.value <- select(df, "pval_all","pval_control","pval_antibiotics", "pval_early", "pval_late")
p.value <- as.matrix(p.value)
rownames(p.value)<-df$species
p.value <- t(p.value)
#plot.data$stars <- cut(plot.data$p.value, breaks=c(-Inf, 0.001, 0.01, 0.05, Inf), label=c("***", "**", "*", ""))  # Create column of significance labels

png(height=1200, width=1200, pointsize=25, file=out_plot)
corrplot(plot.data, is.corr=FALSE, p.mat= p.value, sig.level = .05, tl.col = "black", cl.lim=c(-1,1), col=colorRampPalette(c("blue","white","red"))(200), cl.ratio=0.1, cl.length = 5)
dev.off()

