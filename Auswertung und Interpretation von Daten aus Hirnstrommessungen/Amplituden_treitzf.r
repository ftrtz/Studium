## Packages & Datensatz
setwd("C:/Users/Fabian/OneDrive/Dokumente/Psychologie/3. Semester/Auswertung und Interpretation von Daten aus Hirnstrommessungen/Daten")

library(ggplot2)
library(Rmisc)
library(ez)

amplitudes <- read.csv("C:/Users/Fabian/OneDrive/Dokumente/Psychologie/3. Semester/Auswertung und Interpretation von Daten aus Hirnstrommessungen/Daten/MMNamplituden2.txt")


## barplot
amp.summary <- summarySE(amplitudes, measurevar= 'amplitude', groupvars=c('condition', 'electrode'))
amp.plot <- ggplot(amp.summary, aes(electrode, amplitude))
amp.plot +
  geom_bar(aes(fill = condition), position = position_dodge2(),
           colour = "black", stat = "identity") +
  geom_errorbar(aes(group = condition, ymax = amplitude + sd, ymin = amplitude - sd),
                position = position_dodge(.9), width=.25) +
  labs(x = "Elektrode", y = "Amplitude (??V)") +
  scale_y_continuous(breaks = seq(-4, 4, 2), limits = c(-4.55, 4.55)) +
  scale_fill_grey(name = "Valenz", labels = c("Aversiv", "Neutral")) +
  theme_minimal()

## ANOVA
amplitudes <- data.frame(id, amplitudes)

amp.ez <- ezANOVA(amplitudes, dv = amplitude, wid = vp, within = c(condition, electrode),
                  type = 2, detailed = T)

## Post-hoc t-Tests
FzCz <- subset(amplitudes, electrode == "Fz" | electrode == "Cz")
M1M2 <- subset(amplitudes, electrode == "M1" | electrode == "M2")

t.test(amplitude ~ condition, FzCz, alternative = "less", paired = T)
t.test(amplitude ~ condition, M1M2, alternative = "greater", paired = T)

## MW und SD
summarySE(FzCz, measurevar= 'amplitude', groupvars='condition')

