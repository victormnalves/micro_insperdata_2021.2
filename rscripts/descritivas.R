library(tidyverse)
library(gridExtra)
library(ggthemes)
library(questionr)
library(survey)

### Manipulando a base ####

wvs_categorizada_mulheres <- wvs_categorizada %>% # Filtrando apenas mulheres
  filter(X001 == 'Mulher')

wvs_mulheres_inaceitavel <- wvs_categorizada_mulheres %>% 
  filter(F199 == 'Inaceitável')

wvs_mulheres_aceitavel <- wvs_categorizada_mulheres %>% 
  filter(F199 == 'Aceitável') 

#### Status ocupacional ####

a <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_inaceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X028, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Ocupação',
       y = 'Frequência relativa', 
       subtitle = 'Consideram inaceitável') +
  ylim(0, 0.4) +
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <-svydesign( 
  ~ 1 , 
  data = wvs_mulheres_aceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X028, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Ocupação',
       y = 'Frequência relativa', 
       subtitle = 'Consideram aceitável') +
  ylim(0, 0.4) +
  theme(axis.title.y = element_blank(),         axis.text.y = element_blank(),         axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))

### Posição no domicílio ####

wvs_mulheres_chefe <- wvs_categorizada_mulheres %>% 
  filter(X040 == 'Chefe da família')

wvs_mulheres_nchefe <- wvs_categorizada_mulheres %>% 
  filter(X040 == 'Não é chefe da família') 

a <- svydesign( 
    ~ 1 , 
    data = wvs_mulheres_chefe, 
    weights = ~ S018
  ) %>% ggsurvey() +
  geom_bar(aes(x = F199, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'É aceitável?',
       y = 'Frequência relativa', 
       subtitle = 'Chefe da família') +
  ylim(0, 0.8) +
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <-svydesign( 
  ~ 1 , 
  data = wvs_mulheres_nchefe, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = F199, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'É aceitável?',
       y = 'Frequência relativa', 
       subtitle = 'Não é chefe da família') +
  ylim(0, 0.8) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))


grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))

#### Educação ####

a <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_inaceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X025R, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  ylim(0, 0.5) +  
  labs(x = 'Nível educacional',
       y = 'Frequência relativa', 
       subtitle = 'Consideram inaceitável') +
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_aceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X025R, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  ylim(0, 0.5) +  
  labs(x = 'Nível educacional',
       y = 'Frequência relativa', 
       subtitle = 'Consideram aceitável') +
  theme(axis.title.y = element_blank(),         
        axis.text.y = element_blank(),         
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))

#### Renda ####

a <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_inaceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X047_WVS, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Decil de renda',
       y = 'Frequência relativa', 
       subtitle = 'Consideram inaceitável') +
    ylim(0, 0.25) + 
    theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_aceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X047_WVS, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Decil de renda',
       y = 'Frequência relativa', 
       subtitle = 'Consideram aceitável') +
  ylim(0, 0.25) + 
  theme(axis.title.y = element_blank(),         
        axis.text.y = element_blank(),         
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))
  
#### Idade ####

a <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_inaceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X003, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Faixa de idade',
       y = 'Frequência relativa', 
       subtitle = 'Consideram inaceitável') +
  ylim(0, 0.4) +
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <-svydesign( 
  ~ 1 , 
  data = wvs_mulheres_aceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X003, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Faixa de idade',
       y = 'Frequência relativa', 
       subtitle = 'Consideram aceitável') +
  ylim(0, 0.4) +
  theme(axis.title.y = element_blank(),         
        axis.text.y = element_blank(),         
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))

#### Filhos ####

a <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_inaceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X011, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Possui filhos?',
       y = 'Frequência relativa', 
       subtitle = 'Consideram inaceitável') +
  ylim(0, 0.8) +
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <-svydesign( 
  ~ 1 , 
  data = wvs_mulheres_aceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X011, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Possui filhos?',
       y = 'Frequência relativa', 
       subtitle = 'Consideram aceitável') +
  ylim(0, 0.8) +
  theme(axis.title.y = element_blank(),         
        axis.text.y = element_blank(),         
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))

#### Estado cívil ####

a <- svydesign( 
  ~ 1 , 
  data = wvs_mulheres_inaceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X007, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Estado civil',
       y = 'Frequência relativa', 
       subtitle = 'Consideram inaceitável') +
  ylim(0, 0.8) +
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <-svydesign( 
  ~ 1 , 
  data = wvs_mulheres_aceitavel, 
  weights = ~ S018
) %>% ggsurvey() +
  geom_bar(aes(x = X007, y= ..count.. / sum(..count..)), fill = '#69b3a2') +
  theme_minimal() +
  labs(x = 'Estado civil',
       y = 'Frequência relativa', 
       subtitle = 'Consideram aceitável') +
  ylim(0, 0.8) +
  theme(axis.title.y = element_blank(),         
        axis.text.y = element_blank(),         
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, top = 'É aceitável que um homem bata em sua esposa?'))

#### Evolução ####

a <- wvs_base %>% 
  mutate(F199 = if_else(F199 == 1, 1, 0),
         S002VS = as.factor(S002VS)) %>% 
  group_by(S002VS) %>% 
  filter(!is.na(F199)) %>% 
  summarise(media_nao_violencia = mean(F199)) %>% 
  ggplot() + 
  geom_col(aes(x = S002VS, y = media_nao_violencia), fill  = '#69b3a2') +
  theme_minimal() +
  ylim(0, 1) +
  labs(x = 'Wave',
       y= 'Proporção de não aceitação de violência',
       subtitle = 'No mundo') + 
  theme(plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

b <- wvs_base %>% 
  filter(S003 == 076) %>% 
  mutate(F199 = if_else(F199 == 1, 1, 0),
         S002VS = as.factor(S002VS)) %>% 
  group_by(S002VS) %>% 
  filter(!is.na(F199)) %>% 
  summarise(media_nao_violencia = mean(F199)) %>% 
  ggplot() + 
  geom_col(aes(x = S002VS, y = media_nao_violencia), fill  = '#69b3a2') +
  theme_minimal() +
  ylim(0, 1) +
  labs(x = 'Wave',
       y= 'Proporção de não aceitação de violência',
       subtitle = 'No Brasil') + 
  theme(axis.title.y = element_blank(),         
        axis.text.y = element_blank(),         
        axis.ticks.y = element_blank(),
        plot.title=element_text(size=12,face="bold"),
        legend.text=element_text(size=8),
        axis.text=element_text(size=8),
        axis.title = element_text(size = 10),
        legend.title = element_text(size = 10))

grid.arrange(arrangeGrob(a,b, ncol = 2, 
                         top = 'Evolução da proporção de não aceitação de violência em um relacionamento no mundo'))



