# PERMANOVA analysis to see if there are difference in AMR between patients treated with TC and control

setwd("/Users/stebliankin/Desktop/AntibioticsFinal/Slurm-PTR-Analysis")

metric <- "jaccard"

#in_file <- "/Users/stebliankin/Desktop/AntibioticsProject/AntibioticsPTR/PTR-analysis/data/tc_permanova_in_scaled.csv"
in_file <- "/Users/stebliankin/Desktop/AntibioticsProject/AntibioticsPTR/PTR-analysis/data/tc_permanova_in_TC-rest.csv"
PCOA_out <- "data/Gibson-et-al/PERMANOVA/tc_pcoa.png"
permanova_out = "data/Gibson-et-al/PERMANOVA/tc_PERMANOVA.csv"

################################
# Read the data
################################
dataMatrix<-read.csv(in_file, sep=",", header=TRUE)
df <- as.data.frame(dataMatrix)
original_df <- df
Antibiotics <- df[,1]
df <- df[,-1]

# Remove zero columns:
df <- df[, colSums(df !=0)>0]
list_na <- colnames(df)[ apply(df, 2, anyNA) ]
list_na
################################
# PCoA
################################

# Calculate distance matrix
library(vegan)
dist <- vegdist(df, method=metric)


#  Train PCoA model
library(ape)
PCOA <- pcoa(dist)

# Some distance measures may result in negative eigenvalues. In that case, add a correction:
PCOA <- pcoa(dist, correction = "cailliez")

# transform PCoA components into data frame
PCOA1<-PCOA$vectors[,1]
PCOA2<-PCOA$vectors[,2]
PCOA.frame <- data.frame(PCOA1, PCOA2,Antibiotics)

# plot the results
library(ggplot2)

ggplot(PCOA.frame, aes(x=PCOA1, y=PCOA2, color=Antibiotics))+ geom_point() + ggtitle(paste("PCoA Ordination:","β-lactams"))+
  theme(plot.title = element_text(size=14, face="bold", hjust = 0.5))
ggsave(PCOA_out, plot=last_plot(),device = NULL, width = 5, height = 3)

################################
# PERMANOVA
################################

Ticarcillin.Clavulanate <- Antibiotics
perm.results <- adonis(df ~ Ticarcillin.Clavulanate, permutations = 999, method = metric)
perm.results$aov.tab
write.csv(perm.results$aov.tab, permanova_out)


