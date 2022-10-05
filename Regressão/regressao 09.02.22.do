* Programação Regressão
* Projeto Insper Data

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

* Sexo 
rename X001 sexo
tab sexo, gen(dummysexo)
gen catSexo = 1 if dummysexo== 1
replace catSexo = 2 if dummysexo== 1

label define TraduzindocatSexo 1 "Masculino" 2 "Feminino" 
label values catSexo TraduzindocatSexo

* Idade
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

*Estado civil
rename X007 estado_civil
gen dummyEC1 = inrange(estado_civil,1,2)
gen dummyEC2 = inrange(estado_civil,3,5)
gen dummyEC3 = estado_civil == 6
gen catEC = 1 if dummyEC1 == 1
replace catEC = 2 if dummyEC2 == 1
replace catEC = 3 if dummyEC3 == 1

label define TraduzindocatEC 1 "Casada ou morando junto como casada" 2 "Divorciada, separada ou viúva" 3 "Solteira"
label values catEC TraduzindocatEC

* Filhos
rename X011 n_filhos

** Criando uma dummy para com e sem filhos
gen dummyfilhos  = inrange(n_filhos,1,5)
gen catFilhos = 0 if dummyfilhos == 0
replace catFilhos = 1 if dummyfilhos == 1
label define TraduzindocatFilhos 0 "Sem filhos" 1 "Com filhos" 
label values catFilhos TraduzindocatFilhos

** Criando dummies para número de filhos agrupado (1, 2, 3 ou mais filhos)
gen dummy_nfilhos1 = n_filhos == 0
gen dummy_nfilhos2 = n_filhos == 1
gen dummy_nfilhos3 = n_filhos == 2
gen dummy_nfilhos4 = inrange(n_filhos,3,5)
gen catNumeroFilhos = 1 if dummy_nfilhos1 == 1
replace catNumeroFilhos = 2 if dummy_nfilhos2 == 1
replace catNumeroFilhos = 3 if dummy_nfilhos3 == 1
replace catNumeroFilhos = 4 if dummy_nfilhos4 == 1 

label define TraduzindocatNumeroFilhos 1 "Sem filhos" 2 "Um filho" 3 "Dois filhos" 4 "Três ou mais filhos" 
label values catNumeroFilhos TraduzindocatNumeroFilhos

* Nivel educacional
rename X025R nivel_educ2
tab nivel_educ2, gen(dummyNE2_)
gen catEduc = 1 if dummyNE2_1 == 1
replace catEduc = 2 if dummyNE2_2 == 1
replace catEduc = 3 if dummyNE2_3 == 1

label define TraduzindocatEduc 1 "Ensino fundamental" 2 "Ensino médio" 3 "Ensino técnico ou superior"
label values catEduc TraduzindocatEduc

* Emprego
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

label define TraduzindocatES 1 "Tempo integral" 2 "Tempo parcial" 3 "Autônoma" 4 "Aposentada" 5 "Do lar" 6 "Desempregada" 7 "Outros"
label values catES TraduzindocatES

* Chefe da casa
rename X040 chefe_casa
tab chefe_casa, gen(dummychefe)
gen catChefe = 1 if dummychefe1 == 1
replace catChefe = 2 if dummychefe2 == 1

label define TraduzindocatChefe 1 "Não" 2 "Sim" 
label values catChefe TraduzindocatChefe

** Dummy para responsável financeira
gen responsavel_financeira = 0 if catChefe == 1
replace responsavel_financeira = 1 if catChefe == 2

* Escala de renda
rename X047_WVS scale_income
tab scale_income, gen(dummyIS)
gen catIS = 1 if dummyIS1 == 1
replace catIS = 2 if dummyIS2 == 1
replace catIS = 3 if dummyIS3 == 1
replace catIS = 4 if dummyIS4 == 1
replace catIS = 5 if dummyIS5 == 1

label define TraduzindocatIS 1 "1º quintil" 2 "2º quintil" 3 "3º quintil" 4 "4º quintil" 5 "5º quintil"
label values catIS TraduzindocatIS

* Waves
rename S002VS wave

* Ano
rename S020 ano_survey

* Violência contra mulher
rename F199 violencia_domest

** Dummy de não aceitação
gen nao_vdomest = 1 if violencia_domest == 1
replace nao_vdomest = 0 if violencia_domest != 1 
replace nao_vdomest = . if violencia_domest == .

label define Traduzindonvdomest 1 "Não aceitável" 0 "Aceitável"
label values nao_vdomest Traduzindonvdomest

** Dummy de aceitação
gen vdomest = 0 if nao_vdomest == 1
replace vdomest = 1 if nao_vdomest == 0 
replace vdomest = . if nao_vdomest == .

label define Traduzindovdomest 0 "Não aceitável" 1 "Aceitável"
label values vdomest Traduzindovdomest

* Importância da religião
rename A006 religion_importance
tab religion_importance, gen(dummyregimp)

gen catRelIm = 1 if dummyregimp1 == 1
replace catRelIm = 2 if dummyregimp2 == 1
replace catRelIm = 3 if dummyregimp3 == 1
replace catRelIm = 4 if dummyregimp4 == 1

label define TraduzindocatRelIm 1 "Muito importante" 2 "Um pouco importante" 3 "Não muito importante" 4 "Não importante"
label values catRelIm TraduzindocatRelIm

gen religiao_import = 0 if catRelIm==4
replace religiao_import = 1 if catRelIm==1 | catRelIm==3 | catRelIm==2

* País
encode pais, generate(pais_reg)

* Dropando a categoria 7 (outros) da variável status de emprego
drop if catES == 7

* REGRESSÕES (precisamos refazer as labels dos efeitos marginais)

** Mundo

svy: logit vdomest ib1.catIS ib1.catEduc ib1.catES responsavel_financeira ib1.catAge ib3.catEC religiao_import ib1.catNumeroFilhos i.pais_reg  i.wave i.pais_reg

margins, dydx(catIS)
marginsplot, nolabels allxlabels xtitle("Quintil de renda", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "2º quintil" 2 "3º quintil"  3 "4º quintil"  4 "5º quintil", labsize(vsmall)) yline(0)

margins, dydx(catEduc)
marginsplot, nolabels allxlabels xtitle("Nível educacional", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Ensino médio" 2 `" "Ensino técnico" "ou superior" "', labsize(vsmall)) yline(0)

margins, dydx(catES)
marginsplot, nolabels allxlabels xtitle("Status de emprego", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Tempo parcial" 2 "Autônoma" 3 "Aposentada" 4 "Do lar" 5 `""Desempregada" " ""', labsize(vsmall)) yline(0)

margins, dydx(responsavel_financeira)
marginsplot, nolabels allxlabels xtitle("Responsável financeira", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""É responsável financeira do lar" " ""', labsize(vsmall)) yline(0)

margins, dydx(catAge)
marginsplot, nolabels allxlabels xtitle("Faixa etária", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "31 à 40" 2 "41 à 50" 3 "51 à 60" 4 "61 à 70" 5 "+ 71", labsize(vsmall)) yline(0)

margins, dydx(catEC)
marginsplot, nolabels allxlabels xtitle("Estado civil", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `" "Casada ou" "morando junto como casada" "' 2 `" "Divorciada," "separada" "ou viúva" "', labsize(vsmall)) yline(0)

margins, dydx(religiao_import)
marginsplot, nolabels allxlabels xtitle("Importância da religião", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""Considera religião algo importante" " ""', labsize(vsmall)) yline(0)

margins, dydx(catNumeroFilhos)
marginsplot, nolabels allxlabels xtitle("Quantidade de filhos", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Um filho" 2 "Dois filhos" 3 `" "Três ou" "mais filhos" "', labsize(vsmall)) yline(0)

 
** Brasil
svy: logit vdomest ib1.catIS ib1.catEduc ib1.catES responsavel_financeira ib1.catAge  ib3.catEC religiao_import ib1.catNumeroFilhos i.wave if pais == "Brazil"

margins, dydx(catIS)
marginsplot, nolabels allxlabels xtitle("Quintil de renda", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "2º quintil" 2 "3º quintil"  3 "4º quintil"  4 "5º quintil", labsize(vsmall)) yline(0)

margins, dydx(catEduc)
marginsplot, nolabels allxlabels xtitle("Nível educacional", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Ensino médio" 2 `" "Ensino técnico" "ou superior" "', labsize(vsmall)) yline(0)

margins, dydx(catES)
marginsplot, nolabels allxlabels xtitle("Status de emprego", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Tempo parcial" 2 "Autônoma" 3 "Aposentada" 4 "Do lar" 5 `""Desempregada" " ""', labsize(vsmall)) yline(0)

margins, dydx(responsavel_financeira)
marginsplot, nolabels allxlabels xtitle("Responsável financeira", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""É responsável financeira do lar" " ""', labsize(vsmall)) yline(0)

margins, dydx(catAge)
marginsplot, nolabels allxlabels xtitle("Faixa etária", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "31 à 40" 2 "41 à 50" 3 "51 à 60" 4 "61 à 70" 5 "+ 71", labsize(vsmall)) yline(0)

margins, dydx(catEC)
marginsplot, nolabels allxlabels xtitle("Estado civil", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `" "Casada ou" "morando junto como casada" "' 2 `" "Divorciada," "separada" "ou viúva" "', labsize(vsmall)) yline(0)

margins, dydx(religiao_import)
marginsplot, nolabels allxlabels xtitle("Importância da religião", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""Considera religião algo importante" " ""', labsize(vsmall)) yline(0)

margins, dydx(catNumeroFilhos)
marginsplot, nolabels allxlabels xtitle("Quantidade de filhos", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Um filho" 2 "Dois filhos" 3 `" "Três ou" "mais filhos" "', labsize(vsmall)) yline(0)

** Mundo (Apenas mulheres casadas)
svy: logit vdomest ib1.catIS ib1.catEduc ib1.catES responsavel_financeira ib1.catAge religiao_import ib1.catNumeroFilhos i.pais_reg i.wave i.pais_reg if catEC == 1

margins, dydx(catIS)
marginsplot, nolabels allxlabels xtitle("Quintil de renda", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "2º quintil" 2 "3º quintil"  3 "4º quintil"  4 "5º quintil", labsize(vsmall)) yline(0)

margins, dydx(catEduc)
marginsplot, nolabels allxlabels xtitle("Nível educacional", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Ensino médio" 2 `" "Ensino técnico" "ou superior" "', labsize(vsmall)) yline(0)

margins, dydx(catES)
marginsplot, nolabels allxlabels xtitle("Status de emprego", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Tempo parcial" 2 "Autônoma" 3 "Aposentada" 4 "Do lar" 5 `""Desempregada" " ""', labsize(vsmall)) yline(0)

margins, dydx(responsavel_financeira)
marginsplot, nolabels allxlabels xtitle("Responsável financeira", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""É responsável financeira do lar" " ""', labsize(vsmall)) yline(0)

margins, dydx(catAge)
marginsplot, nolabels allxlabels xtitle("Faixa etária", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "31 à 40" 2 "41 à 50" 3 "51 à 60" 4 "61 à 70" 5 "+ 71", labsize(vsmall)) yline(0)

margins, dydx(religiao_import)
marginsplot, nolabels allxlabels xtitle("Importância da religião", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""Considera religião algo importante" " ""', labsize(vsmall)) yline(0)

margins, dydx(catNumeroFilhos)
marginsplot, nolabels allxlabels xtitle("Quantidade de filhos", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Um filho" 2 "Dois filhos" 3 `" "Três ou" "mais filhos" "', labsize(vsmall)) yline(0)

** Brasil (Apenas mulheres casadas)
svy: logit vdomest ib1.catIS ib1.catEduc ib1.catES responsavel_financeira ib1.catAge religiao_import ib1.catNumeroFilhos i.wave if catEC == 1 & pais == "Brazil"

margins, dydx(catIS)
marginsplot, nolabels allxlabels xtitle("Quintil de renda", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "2º quintil" 2 "3º quintil"  3 "4º quintil"  4 "5º quintil", labsize(vsmall)) yline(0)

margins, dydx(catEduc)
marginsplot, nolabels allxlabels xtitle("Nível educacional", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Ensino médio" 2 `" "Ensino técnico" "ou superior" "', labsize(vsmall)) yline(0)

margins, dydx(catES)
marginsplot, nolabels allxlabels xtitle("Status de emprego", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Tempo parcial" 2 "Autônoma" 3 "Aposentada" 4 "Do lar" 5 `""Desempregada" " ""', labsize(vsmall)) yline(0)

margins, dydx(responsavel_financeira)
marginsplot, nolabels allxlabels xtitle("Responsável financeira", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""É responsável financeira do lar" " ""', labsize(vsmall)) yline(0)

margins, dydx(catAge)
marginsplot, nolabels allxlabels xtitle("Faixa etária", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "31 à 40" 2 "41 à 50" 3 "51 à 60" 4 "61 à 70" 5 "+ 71", labsize(vsmall)) yline(0)

margins, dydx(religiao_import)
marginsplot, nolabels allxlabels xtitle("Importância da religião", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 `""Considera religião algo importante" " ""', labsize(vsmall)) yline(0)

margins, dydx(catNumeroFilhos)
marginsplot, nolabels allxlabels xtitle("Quantidade de filhos", size(small)) ytitle("Aceitação da violência contra mulher", size(small)) title("Efeito marginal com 95%" "de confiança") xlabel(1 "Um filho" 2 "Dois filhos" 3 `" "Três ou" "mais filhos" "', labsize(vsmall)) yline(0)

* REGRESSÃO DE LOGIT ORDENADO

** Mundo

svy: ologit violencia_domestica_categorizada ib1.catIS ib1.catEduc ib1.catES responsavel_financeira ib1.catAge ib3.catEC religiao_import ib1.catNumeroFilhos i.pais_reg
i.wave i.pais_reg

margins, dydx(*)
 


* Rodamos com religião, porém percebemos que não trouxe resultados significantes. Desse modo, achamos que por motivos teóricos e empíricos era melhor tirar o efeito fixo de religião

* TABELAS

** Mundo

svy: mean vdomest catIS catEduc catES responsavel_financeira catAge religiao_import catNumeroFilhos

** Brasil

svy: mean vdomest catIS catEduc catES responsavel_financeira catAge religiao_import catNumeroFilhos if pais == "Brazil"

* Logit ordenado vai ficar como próximos passos, pós apresentação, mas que já foi mapeado
 
