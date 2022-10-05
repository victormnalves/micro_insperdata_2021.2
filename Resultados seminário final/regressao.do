* Programação Regressão
* Projeto Insper Data

cd C:\Users\Malu\Downloads

log using regressao.log

* Importando o excel
import delimited C:\Users\Malu\Downloads\base.csv

* Transformando variáveis em numéricas e trocando "NA" por ".", também colocando X028 = 9 como missing porque não tem no dicionário

destring, replace ignore("NA")
replace x028 = . if x028 == 9
replace x036e = . if x036e == 11
* Eliminando valores negativos da base
ds, has(type numeric)
foreach var in `r(varlist)' {
    replace `var' = . if  `var' < 0
}

* Adicionando o peso amostral
svyset _n [pw=s018], strata(s024)

rename x001 sexo
tab sexo, gen(dummysexo)
gen catSexo = 1 if dummysexo== 1
replace catSexo = 2 if dummysexo== 1


label define TraduzindocatSexo 1 "masculino" 2 "feminino" 
label values catSexo TraduzindocatSexo
* dummysexo1 = male
* dummysexo2 = female
rename x002 ano_nascimento
rename x003 idade
gen dummyidade1 = inrange(idade,18,30)
gen dummyidade2 = inrange(idade,31,40)
gen dummyidade3 = inrange(idade,41,50)
gen dummyidade4 = inrange(idade,51,60)
gen dummyidade5 = inrange(idade,61,70)
gen dummyidade6 = idade >= 71

gen catAge = 1 if dummyidade1 == 1
replace catAge = 2 if dummyidade2 == 1
replace catAge = 3 if dummyidade3 == 1
replace catAge = 4 if dummyidade4 == 1
replace catAge = 5 if dummyidade5 == 1
replace catAge = 6 if dummyidade6 == 1


label define TraduzindocatAge 1 "18 à 30" 2 "31 à 40" 3 "41 à 50" 4 "51 à 60" 5 "61 à 70" 6 "+ 71"
label values catAge TraduzindocatAge

rename x007 estado_civil
gen dummyEC1 = inrange(estado_civil,1,2)
gen dummyEC2 = inrange(estado_civil,3,5)
gen dummyEC3 = estado_civil == 6

gen catEC = 1 if dummyEC1 == 1
replace catEC = 2 if dummyEC2 == 1
replace catEC = 3 if dummyEC3 == 1


label define TraduzindocatEC 1 "married or living together as married" 2 "divorced, separated, widowed" 3 "single/never married"
label values catEC TraduzindocatEC

* dummyEC1 = married or living together as married
* dummyEC2 = divorced, separated, widowed
* dummyEC3 = single/never married
rename x011 n_filhos
gen dummyfilhos  = inrange(n_filhos,1,5)

gen catFilhos = 0 if dummyfilhos == 0
replace catFilhos = 1 if dummyfilhos == 1


label define TraduzindocatFilhos 0 "sem filhos" 1 "com filhos" 
label values catFilhos TraduzindocatFilhos

* X025 - 293,613 missings
rename x025 nivel_educ1
gen dummyNE1_1 = inrange(nivel_educ1,1,2)
gen dummyNE1_2 = inrange(nivel_educ1,3,6)
gen dummyNE1_3 = inrange(nivel_educ1,7,8)
* dummyNE_1 = elementary education
* dummyNE_2 = secundary school 
* dummyNE_3 = university 
* X025R - 7,620 missings
rename x025r nivel_educ2
tab nivel_educ2, gen(dummyNE2_)

gen catEduc = 1 if dummyNE2_1 == 1
replace catEduc = 2 if dummyNE2_2 == 1
replace catEduc = 3 if dummyNE2_3 == 1

label define TraduzindocatEduc 1 "elementary educacional" 2 "secundary school" 3 "university"
label values catEduc TraduzindocatEduc

* dummyNE2_1 = lower education level
* dummyNE2_2 = middle education level
* dummyNE2_3 = upper education level 
rename x028 employ_status
gen dummyES1 = employ_status == 1
gen dummyES2 = employ_status == 2
gen dummyES3 = employ_status == 3
gen dummyES4 = employ_status == 4
gen dummyES5 = employ_status == 5
gen dummyES6 = inrange(employ_status,6,7)
gen dummyES7 = employ_status == 8

gen catES = 1 if dummyES1 == 1
replace catES = 2 if dummyES2 == 1
replace catES = 3 if dummyES3 == 1
replace catES = 4 if dummyES4 == 1
replace catES = 5 if dummyES5 == 1
replace catES = 6 if dummyES6 == 1
replace catES = 7 if dummyES7 == 1

label define TraduzindocatES 1 "full time" 2 "part time" 3 "self employed" 4 "retired" 5 "housewife" 6 "unemployed" 7 "other"
label values catES TraduzindocatES

* dummyES1 = full time
* dummyES2 = part time
* dummyES3 = self employed
* dummyES4 = retired
* dummyES5 = housewife
* dummyES6 = students
* dummyES7 = unemployed
* dummyES8 = other
rename x036 ocupacao1
replace ocupacao1 = 1 if ocupacao1 <= 16
gen dummyOC1_1 = ocupacao1 == 1
gen dummyOC1_2 = ocupacao1 == 21
gen dummyOC1_3 = inrange(ocupacao1,22,25)
gen dummyOC1_4 = ocupacao1 == 31
gen dummyOC1_5 = inrange(ocupacao1,32,34)
gen dummyOC1_6 = ocupacao1 == 41
gen dummyOC1_7 = ocupacao1 == 42
gen dummyOC1_8 = ocupacao1 == 51
gen dummyOC1_9 = ocupacao1 == 61
gen catOC1 = 1 if dummyOC1_1 == 1
replace catOC1 = 2 if dummyOC1_2 == 1
replace catOC1 = 3 if dummyOC1_3 == 1
replace catOC1 = 4 if dummyOC1_4 == 1
replace catOC1 = 5 if dummyOC1_5 == 1
replace catOC1 = 6 if dummyOC1_6 == 1
replace catOC1 = 7 if dummyOC1_7 == 1
replace catOC1 = 8 if dummyOC1_8 == 1
replace catOC1 = 9 if dummyOC1_9 == 1
label define TraduzindocatOC1 1 "employer/manager of establishment" 2 "professional worker" 3 "non-manual office worker" 4 "foreman and supervisor" 5 "manual worker" 6 "farmer: has own farm" 7 "agricultural worker" 8 "member armed forces" 9 "never had job"
label values catOC1 TraduzindocatOC1

* dummy_groupOC1_1 = employer/manager of establishment
* dummy_groupOC1_2 = professional worker
* dummy_groupOC1_3 = non-manual office worker
* dummy_groupOC1_4 = foreman and supervisor
* dummy_groupOC1_5 = manual worker
* dummy_groupOC1_6 = farmer: has own farm
* dummy_groupOC1_7 = agricultural worker
* dummy_groupOC1_8 = member armed forces
* dummy_groupOC1_9 = never had job
* ocupacao1 - employers = 1

rename x036e ocupacao2
tab ocupacao2, gen(dummyOC2_)

gen catOC2 = 1 if dummyOC2_1 == 1
replace catOC2 = 2 if dummyOC2_2 == 1
replace catOC2 = 3 if dummyOC2_3 == 1
replace catOC2 = 4 if dummyOC2_4 == 1
replace catOC2 = 5 if dummyOC2_5 == 1
replace catOC2 = 6 if dummyOC2_6 == 1
replace catOC2 = 7 if dummyOC2_7 == 1
replace catOC2 = 8 if dummyOC2_8 == 1
replace catOC2 = 9 if dummyOC2_9 == 1
replace catOC2 = 10 if dummyOC2_10 == 1
replace catOC2 = 11 if dummyOC2_11 == 1

label define TraduzindocatOC2 1 "never had a job" 2 "professional and technical" 3 "higher administrative" 4 "clerical" 5 "sales" 6 "service" 7 "skilled worker" 8 "semi-skilled worked" 9 "unskilled worker" 10 "farm worker" 11 "farm proprietor"
label values catOC2 TraduzindocatOC2
* dummyOC2_1 = never had a job
* dummyOC2_2 = professional and technical
* dummyOC2_3 = higher administrative
* dummyOC2_4 = clerical
* dummyOC2_5 = sales
* dummyOC2_6 = service
* dummyOC2_7 = skilled worker
* dummyOC2_8 = semi-skilled worked
* dummyOC2_9 = unskilled worker
* dummyOC2_10 = farm worker
* dummyOC2_11 = farm proprietor
rename x040 chefe_casa
tab chefe_casa, gen(dummychefe)

gen catChefe = 1 if dummychefe1 == 1
replace catChefe = 2 if dummychefe2 == 1

label define TraduzindocatChefe 1 "No" 2 "Yes" 
label values catChefe TraduzindocatChefe
* dummychefe1 = No
* dummychefe2 = Yes
rename x047_wvs scale_income
tab scale_income, gen(dummyIS)

gen catIS = 1 if dummyIS1 == 1
replace catIS = 2 if dummyIS2 == 1
replace catIS = 3 if dummyIS3 == 1
replace catIS = 4 if dummyIS4 == 1
replace catIS = 5 if dummyIS5 == 1
replace catIS = 6 if dummyIS6 == 1
replace catIS = 7 if dummyIS7 == 1
replace catIS = 8 if dummyIS8 == 1
replace catIS = 9 if dummyIS9 == 1
replace catIS = 10 if dummyIS10 == 1

label define TraduzindocatIS 1 "lower step" 2 "second step" 3 "third step" 4 "fourth step" 5 "fifth step" 6 "sixth step" 7 "seventh step" 8 "eighth step" 9 "nineth step" 10 "higher step"
label values catIS TraduzindocatIS

* dummyIL1 = low income level
* dummyIL2 = medium income level
* dummyIL3 = high income level
rename f025old religiao
rename f028 attend_religious 
rename s002vs wave
rename f114d violencia_outros
gen nao_voutros = 1 if violencia_outros == 1
replace nao_voutros = 0 if violencia_outros != 1 
replace nao_voutros = . if violencia_outros == .

label define Traduzindonvoutros 1 "não aceitável" 0 "aceitável"
label values nao_voutros Traduzindonvoutros
* não_voutros = 1 violência contra os outros não aceitável

rename s020 ano_survey
rename f199 violencia_domest
gen nao_vdomest = 1 if violencia_domest == 1
replace nao_vdomest = 0 if violencia_domest != 1 
replace nao_vdomest = . if violencia_domest == .

label define Traduzindonvdomest 1 "não aceitável" 0 "aceitável"
label values nao_vdomest Traduzindonvdomest

rename s003 country_code
rename a006 religion_importance
tab religion_importance, gen(dummyregimp)

gen catRelIm = 1 if dummyregimp1 == 1
replace catRelIm = 2 if dummyregimp2 == 1
replace catRelIm = 3 if dummyregimp3 == 1
replace catRelIm = 4 if dummyregimp4 == 1

label define TraduzindocatRelIm 1 "very important" 2 "rather important" 3 "not very important" 4 "not at all important"
label values catRelIm TraduzindocatRelIm

* dummyregimp1 = very important
* dummyregimp2 = rather important
* dummyregimp3 = not very important
* dummyregimp4 = not at all important

* Fazendo a regressão
* var y: nao_vdomest

* Transformando em numérica "Pais" para usar de efeito fixo
encode pais, generate(pais_reg)
replace religião = "" if religião == "NA"
encode religião, generate(rel_reg)


* para os efeitos fixos
replace religiao = 91 if religiao == .
replace ocupacao1 = 82 if ocupacao1 == .
replace ocupacao2 = 12 if ocupacao2 == .

* Efeito fixo de país e wave
* Tiramos violência contra os outros, visto que não está em nossa hipótese econômica
* Podemos usar violência contra os outros só com as duas últimas waves
svy: logit nao_vdomest ib6.catAge ib4.catRelIm ib3.catEC ib1.catFilhos ib1.catEduc ib7.catES ib1.catChefe ib1.catIS i.pais_reg i.wave
margins, dydx(catRelIm)
marginsplot
margins, dydx(catEC)
marginsplot
margins, dydx(catES)
marginsplot
margins, dydx(catChefe)
marginsplot
margins, dydx(catIS)
marginsplot

 
svy: logit nao_vdomest ib6.catAge ib4.catRelIm ib3.catEC ib1.catFilhos ib1.catEduc ib7.catES ib1.catChefe ib1.catIS i.wave if pais == "Brazil"
margins, dydx(catIS)
marginsplot 
* Rodamos com religião, porém percebemos que não trouxe resultados significantes. Desse modo, achamos que por motivos teóricos e empíricos era melhor tirar o efeito fixo de religião

* Tabela do mundo
summ nao_vdomest catAge catRelIm catEC catFilhos catEduc catES catChefe catIS 
* Tabela do Brasil
summ nao_vdomest catAge catRelIm catEC catFilhos catEduc catES catChefe catIS if pais == "Brazil"

* Logit ordenado vai ficar como próximos passos, pós apresentação, mas que já foi mapeado
 
