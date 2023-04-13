# This R code performs statistical analysis of signal quality parameters (SQP).
# The method for calculation of SQPs is in-detail presented in paper titled 
# "A New Algorithm for Fetal Heart Rate Detection: Fractional Order Calculus Approach"
# authored by Ilija Tanaskovic and Nadica Miljkovic

# R version
# platform       x86_64-w64-mingw32          
# arch           x86_64                      
# os             mingw32                     
# system         x86_64, mingw32             
# status                                     
# major          4                           
# minor          1.2                         
# year           2021                        
# month          11                          
# day            01                          
# svn rev        81115                       
# language       R                           
# version.string R version 4.1.2 (2021-11-01)
# nickname       Bird Hippie        

# setting the directory to the same path where the table with parameters
# and R code are saved on a computer
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# reading data
dat <- read.csv("signal quality parameters for statistical test.csv")
View(dat)

# test normality of parameters (for p-value > 0.05 normality can be assumed)
shapiro.test(dat$snr_pre)
shapiro.test(dat$snr_post) # normal
shapiro.test(dat$xSQI_pre)
shapiro.test(dat$xSQI_post)
shapiro.test(dat$fQRS_to_mQRS_pre)
shapiro.test(dat$fQRS_to_mQRS_post)

# paired Wilcoxon's Signed-Ranks test is used for non-normally distributed data
wilcox.test(dat$snr_pre, dat$snr_post, paired = T)
wilcox.test(dat$xSQI_pre, dat$xSQI_post, paired = T)
wilcox.test(dat$fQRS_to_mQRS_pre, dat$fQRS_to_mQRS_post, paired = T)
