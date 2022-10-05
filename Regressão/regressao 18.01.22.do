* Programação Regressão
* Projeto Insper Data

log using regressao.log

* Importando o excel
import excel "\\tsclient\D\Faculdade\Insper Data\Projeto\Seminário Final\base_excel.xlsx", sheet("base atualizada") firstrow

* Transformando variáveis em numéricas e trocando "NA" por ".", também colocando X028 = 9 como missing porque não tem no dicionário

destring, replace ignore("NA")
replace X028 = . if X028 == 9
* Eliminando valores negativos da base
ds, has(type numeric)
foreach var in `r(varlist)' {
    replace `var' = . if  `var' < 0
}

* Adicionando o peso amostral
svyset _n [pw=S018], strata(S024)

rename X001 sexo
tab sexo, gen(dummysexo)
gen catSexo = 1 if dummysexo== 1
replace catSexo = 2 if dummysexo== 1


label define TraduzindocatSexo 1 "masculino" 2 "feminino" 
label values catSexo TraduzindocatSexo
* dummysexo1 = male
* dummysexo2 = female
rename X003 idade
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

rename X007 estado_civil
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
rename X011 n_filhos
gen dummyfilhos  = inrange(n_filhos,1,5)

gen catFilhos = 0 if dummyfilhos == 0
replace catFilhos = 1 if dummyfilhos == 1


label define TraduzindocatFilhos 0 "sem filhos" 1 "com filhos" 
label values catFilhos TraduzindocatFilhos

* X025 - 293,613 missings
rename X025 nivel_educ1
gen dummyNE1_1 = inrange(nivel_educ1,1,2)
gen dummyNE1_2 = inrange(nivel_educ1,3,6)
gen dummyNE1_3 = inrange(nivel_educ1,7,8)
* dummyNE_1 = elementary education
* dummyNE_2 = secundary school 
* dummyNE_3 = university 
* X025R - 7,620 missings
rename X025R nivel_educ2
tab nivel_educ2, gen(dummyNE2_)

gen catEduc = 1 if dummyNE2_1 == 1
replace catEduc = 2 if dummyNE2_2 == 1
replace catEduc = 3 if dummyNE2_3 == 1

label define TraduzindocatEduc 1 "elementary educacional" 2 "secundary school" 3 "university"
label values catEduc TraduzindocatEduc

* dummyNE2_1 = lower education level
* dummyNE2_2 = middle education level
* dummyNE2_3 = upper education level 
rename X028 employ_status
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

rename X040 chefe_casa
tab chefe_casa, gen(dummychefe)

gen catChefe = 1 if dummychefe1 == 1
replace catChefe = 2 if dummychefe2 == 1

label define TraduzindocatChefe 1 "No" 2 "Yes" 
label values catChefe TraduzindocatChefe
* dummychefe1 = No
* dummychefe2 = Yes
rename X047_WVS scale_income
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
rename F025old religiao
rename S002VS wave
rename F114D violencia_outros
gen nao_voutros = 1 if violencia_outros == 1
replace nao_voutros = 0 if violencia_outros != 1 
replace nao_voutros = . if violencia_outros == .

label define Traduzindonvoutros 1 "não aceitável" 0 "aceitável"
label values nao_voutros Traduzindonvoutros
* não_voutros = 1 violência contra os outros não aceitável

rename S020 ano_survey
rename F199 violencia_domest
gen nao_vdomest = 1 if violencia_domest == 1
replace nao_vdomest = 0 if violencia_domest != 1 
replace nao_vdomest = . if violencia_domest == .

label define Traduzindonvdomest 1 "não aceitável" 0 "aceitável"
label values nao_vdomest Traduzindonvdomest

rename A006 religion_importance
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

* para os efeitos fixos
replace religiao = 91 if religiao == .

* Efeito fixo de país e wave
* Tiramos violência contra os outros, visto que não está em nossa hipótese econômica
* Podemos usar violência contra os outros só com as duas últimas waves

* Mudando a estética dos gráficos
ssc install grstyle, replace
ssc install palettes, replace
ssc install colrspace, replace

grstyle init
grstyle color background white
grstyle color major_grid dimgray
grstyle linewidth major_grid thin
grstyle yesno draw_major_hgrid yes
grstyle yesno grid_draw_min yes
grstyle yesno grid_draw_max yes
grstyle anglestyle vertical_tick horizontal

gen religiao_import = 0 if catRelIm==4
replace religiao_import = 1 if catRelIm==1 | catRelIm==3 | catRelIm==2

*TROCAR IB7.CatES POR IB6.CatES !!!!!!!!!!!!!!
svy: logit nao_vdomest ib10.catIS ib1.catEduc ib6.catES ib1.catChefe ib6.catAge  ib3.catEC religiao_import ib1.catFilhos i.pais_reg  i.wave
margins, dydx(catRelIm)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "a importância da religião", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Very Important" 2 "Rather Important" 3 `""Not Very" "Important""', labsize(vsmall))
margins, dydx(catEC)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "o estado civil", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""Married or living" "together as married""' 2 `""Divorced," "separated," "widowed""', labsize(vsmall))
margins, dydx(catES)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "o status de emprego", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Tempo Integral" 2 "Tempo Parcial" 3 "Autônoma" 4 "Aposentada" 5 "Do lar" 6 `""Outros" " ""', labsize(vsmall))
margins, dydx(catChefe)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "se é ou não chefe da família", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""É chefe da família" " ""', labsize(vsmall))
margins, dydx(catIS)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "o decil de renda", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Decil 2" 2 "Decil 3" 3 "Decil 4" 4 "Decil 5" 5 "Decil 6" 6 "Decil 7" 7 "Decil 8" 8 "Decil 9" 9 `""Decil 10" " ""', labsize(vsmall))

margins, dydx(ib1.catEduc)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "o nível educacional", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") 
 
svy: logit nao_vdomest ib10.catIS ib1.catEduc ib6.catES ib1.catChefe ib6.catAge  ib3.catEC religiao_import ib1.catFilhos i.pais_reg  i.wave if pais == "Brazil"
margins, dydx(catIS)
marginsplot, nolabels allxlabels xtitle("Efeito marginal sobre" "o decil de renda", size(small)) ytitle("Efeitos em Y (Não aceitação" "da violência contra mulher)", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "second step" 2 "third step" 3 "fourth step" 4 "fifth step" 5 "sixth step" 6 "seventh step" 7 "eighth step" 8 "nineth step" 9 `""higher step" " ""', labsize(vsmall))

* Rodamos com religião, porém percebemos que não trouxe resultados significantes. Desse modo, achamos que por motivos teóricos e empíricos era melhor tirar o efeito fixo de religião

* Tabela do mundo
summ nao_vdomest catAge catRelIm catEC catFilhos catEduc catES catChefe catIS 
* Tabela do Brasil
summ nao_vdomest catAge catRelIm catEC catFilhos catEduc catES catChefe catIS if pais == "Brazil"
svy: mean nao_vdomest dummyidade* dummyEC* dummyfilhos dummyNE2_* dummyES* dummychefe* dummyIS* dummyregimp*
svy: mean nao_vdomest dummyidade* dummyEC* dummyfilhos dummyNE2_* dummyES* dummychefe* dummyIS* dummyregimp* if Pais == "Brazil"
* Logit ordenado vai ficar como próximos passos, pós apresentação, mas que já foi mapeado
 
