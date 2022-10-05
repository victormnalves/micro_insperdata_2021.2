library(tidyverse)
library(haven)

wvs <- read.csv('bases/wvs_original.csv')

wvs0 <- wvs %>% 
  select(X001, X003, X007, X011, X025R, X028, 
         X040, X047_WVS, A006, F199, 
         S002VS, COUNTRY_ALPHA, S018, S020, S024)

wvs0$pais <- countrycode::countrycode(wvs0$COUNTRY_ALPHA, 
                                          origin = 'iso3c',
                                          destination = 'country.name')

wvs_categorizada <- wvs0 %>% 
  mutate_if(is.numeric, function(x) {x[x < 0] <- NA; x}) %>% 
  filter(!is.na(X025R),
         !is.na(X040),
         !is.na(X028),
         !is.na(X003),
         !is.na(X047_WVS),
         !is.na(X011),
         !is.na(A006),
         !is.na(F199)) %>% 
  mutate(sexo = ifelse(X001 == 1, 'Homem', 'Mulher'),
         idade = ifelse(X003 >= 0 & X003 <= 17, 'Abaixo de 18', 
                           ifelse(X003 >= 18 & X003 <= 30, '18 a 30',
                                  ifelse(X003 >= 31 & X003 <= 40, '31 a 40',
                                         ifelse(X003 >= 41 & X003 <= 50, '41 a 50',
                                                ifelse(X003 >= 61 & X003 <= 70, '61 a 70','Acima de 70'))))),
         estado_civil = ifelse(X007 %in% c(1:2), 'Casada ou morando junto', 
                       ifelse(X007 %in% c(3:5), 'Divorciada ou viúva', 'Solteira')),
         nivel_educacional = as.numeric(X025R),
         nivel_educacional = ifelse(X025R == 1, 'Ensino fundamental',
                        ifelse(X025R == 2, 'Ensino médio', 'Ensino superior ou técnico')),
         posicao_domicilio = ifelse(X040 == 0, 'Chefe da família', 'Não é chefe da família'),
         X028 = as.numeric(X028),
         status_emprego = ifelse(X028 == 1, 'Integral', 
                       ifelse(X028 == 2, 'Parcial',
                              ifelse(X028 == 3, 'Autônomo',
                                     ifelse(X028 == 4, 'Aposentado',
                                            ifelse(X028 == 5, 'Do lar',
                                                   ifelse(X028 %in% c(6,7), 'Desempregado', 'Outros')))))),
         filhos = ifelse(X011 == 0, 'Não possui filhos', 'Possui filhos'),
         F199 = as.numeric(F199),
         nviolencia_mulher = if_else(F199 == 1, 'Inaceitável', 'Aceitável'),
         importancia_religiao = A006,
         wave = S002VS
  ) %>% 
  mutate(sexo = as.factor(sexo),
         idade = as.factor(idade),
         estado_civil = as.factor(estado_civil),
         nivel_educacional = as.factor(nivel_educacional),
         filhos = as.factor(filhos),
         decil_renda = as.factor(X047_WVS),
         nviolencia_mulher = as.factor(nviolencia_mulher),
         status_emprego = as.factor(status_emprego),
         posicao_domicilio = as.factor(posicao_domicilio)
  ) %>% 
  mutate(dummy_sexo = ifelse(X001 == 1, 0, 1),
         dummy_idade = ifelse(X003 >= 0 & X003 <= 17, 1, 
                        ifelse(X003 >= 18 & X003 <= 30, 2,
                               ifelse(X003 >= 31 & X003 <= 40, 3,
                                      ifelse(X003 >= 41 & X003 <= 50, 4,
                                             ifelse(X003 >= 61 & X003 <= 70, 5, 6))))),
         dummy_estado_civil = ifelse(X007 %in% c(1:2), 1, 
                               ifelse(X007 %in% c(3:5), 2, 3)),
         dummy_nivel_educacional = as.numeric(X025R),
         dummy_nivel_educacional = ifelse(X025R == 1, 1,
                                    ifelse(X025R == 2, 2, 3)),
         dummy_posicao_domicilio = ifelse(X040 == 0, 1, 0),
         X028 = as.numeric(X028),
         dummy_status_emprego = ifelse(X028 == 1, 1, 
                                 ifelse(X028 == 2, 2,
                                        ifelse(X028 == 3, 3,
                                               ifelse(X028 == 4, 4,
                                                      ifelse(X028 == 5, 5,
                                                             ifelse(X028 %in% c(6,7), 6, 7)))))),
         dummy_filhos = ifelse(X011 == 0, 0, 1),
         dummy_nviolencia_mulher = as.numeric(F199),
         dummy_nviolencia_mulher = if_else(F199 > 1, 0, 1),
         dummy_importancia_religiao = if_else(A006 == 1, 1, 0),
  ) %>% 
  fastDummies::dummy_cols(select_columns = c('dummy_status_emprego', 
                                           'dummy_nivel_educacional', 
                                           'dummy_estado_civil', 
                                           'dummy_idade')) %>% 
  select(-c(dummy_status_emprego, 
          dummy_nivel_educacional, 
          dummy_estado_civil, 
          dummy_idade))
