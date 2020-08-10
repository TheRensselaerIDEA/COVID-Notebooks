knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")
'%ni%' <- Negate('%in%')

## Unfiltered MRR

data_1 <- readRDS("./TemporalResults/NationalModel/ALL_C_sig.rds")
data_1 <- melt(data_1)
data_1 <- subset(data_1, coefficients != "(Intercept)")

COEF <- data_1$coefficients

data_2 <- readRDS("./TemporalResults/NationalModel/ALL_C.rds")
data_2 <- melt(data_2)

data_2 <- data_2[data_2$coefficients %in% COEF, ]
# data_2 <- data_2[data_2$coefficients %ni% COEF, ]

data_1 <- dplyr::rename(data_1, c(date = variable, `Social Determinants` = coefficients))
data_2 <- dplyr::rename(data_2, c(date = variable, `Social Determinants` = coefficients))

mrr <- ggplot(mapping = aes(x=date, y=value, group=`Social Determinants`, color=`Social Determinants`)) +
              geom_point(data = data_1) +
              geom_line(data = data_2) +
              ggtitle("Temporal Analysis Significant Factors MRR Plot") +
              ylab("MRR")
mrr

data_3 <- readRDS("./TemporalResults/NationalModel/ALL_P_sig.rds")
data_3 <- melt(data_3)
data_3 <- subset(data_3, coefficients != "(Intercept)")

data_4 <- readRDS("./TemporalResults/NationalModel/ALL_P.rds")
data_4 <- melt(data_4)

data_4 <- data_4[data_4$coefficients %in% COEF, ]
# data_4 <- data_4[data_4$coefficients %ni% COEF, ]

data_3 <- dplyr::rename(data_3, c(date = variable, `Social Determinants` = coefficients))
data_4 <- dplyr::rename(data_4, c(date = variable, `Social Determinants` = coefficients))

p <- ggplot(mapping = aes(x=date, y=value, group=`Social Determinants`, color=`Social Determinants`)) +
            geom_point(data = data_3) +
            geom_line(data = data_4) +
            ggtitle("Temporal Analysis Significant Factors p-value Plot") +
            ylab("p-value")
p

figure <- ggarrange(mrr, p,
                    legend = "right", 
                    common.legend = TRUE, 
                    ncol = 1, nrow = 2)
figure
