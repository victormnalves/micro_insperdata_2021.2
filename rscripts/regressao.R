library(skimr)
library(VGAM)

skim(wvs_categorizada_mulheres)

str(wvs_categorizada_mulheres)
prop <- vglm(I(F199 == "Aceitável") ~ X025R + X007 + X040 + X001 + X003 + X028 + X047_WVS + X011 + S002VS,
             family = cumulative(parallel = TRUE, reverse = TRUE), 
             weights = S018, 
             data = wvs_categorizada_mulheres)

summary(prop)
