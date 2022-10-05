wvs1 <- wvs0 %>% 
  mutate_if(is.numeric, function(x) {x[x < 0] <- NA; x}) %>% 
  filter(S002VS %in% c(5,6,7))

wvs2 <- wvs0 %>% 
  filter(X001 == 2)

wvs3 <- wvs0 %>%
  filter(X001 == 2) %>% 
  mutate_if(is.numeric, function(x) {x[x < 0] <- NA; x})

wvs4 <- wvs0 %>%
  filter(X001 == 2,
         S002VS %in% c(5,6,7))

wvs5 <- wvs0 %>% 
  filter(X001 == 2, 
         S002VS %in% c(5,6,7),
  ) %>% 
  mutate(X047_WVS = ifelse(X047_WVS %in% c(1,2), 1,
                           ifelse(X047_WVS %in% c(3,4), 2,
                                  ifelse(X047_WVS %in% c(5,6), 3,
                                         ifelse(X047_WVS %in% c(7,8), 4, 5)))),
         violencia_domestica_categorizada = ifelse(F199 == 1, 1,
                                                   ifelse(F199 %in% c(2:4), 2,
                                                          ifelse(F199 %in% c(5:7), 3,
                                                                 ifelse(F199 %in% c(7:10), 4, F199))))) %>% 
  mutate_if(is.numeric, function(x) {x[x < 0] <- NA; x})

wvs6 <- wvs_categorizada %>% 
  filter(X001 == 2)

write.csv(wvs0, 'bases/wvs0.csv')
write_dta(wvs0, 'bases/wvs0.dta')

write.csv(wvs1, 'bases/wvs1.csv')
write_dta(wvs1, 'bases/wvs1.dta')

write.csv(wvs2, 'bases/wvs2.csv')
write_dta(wvs2, 'bases/wvs2.dta')

write.csv(wvs3, 'bases/wvs3.csv')
write_dta(wvs3, 'bases/wvs3.dta')

write.csv(wvs4, 'bases/wvs4.csv')
write_dta(wvs4, 'bases/wvs4.dta')

write.csv(wvs5, 'bases/wvs5.csv')
write_dta(wvs5, 'bases/wvs5.dta')

write.csv(wvs_categorizada, 'bases/wvs_categorizada.csv')
write_dta(wvs_categorizada, 'bases/wvs_categorizada.dta')

write.csv(wvs6, 'bases/wvs6.csv')
write_dta(wvs6, 'bases/wvs6.dta')