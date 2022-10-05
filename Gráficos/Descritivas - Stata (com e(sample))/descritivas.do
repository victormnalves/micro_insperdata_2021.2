* Gráficos com e(sample)

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(catIS, note("")) by(catIS, title("É aceitável que um homem bata em sua esposa?")) by(catIS, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(catIS, subtitle("Por quintil de renda", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(catEduc, note("")) by(catEduc, title("É aceitável que um homem bata em sua esposa?")) by(catEduc, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(catEduc, subtitle("Por nível educacional", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(catES, note("")) by(catEduc, title("É aceitável que um homem bata em sua esposa?")) by(catES, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(catES, subtitle("Por estado ocupacional", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(responsavel_financeira, note("")) by(responsavel_financeira, title("É aceitável que um homem bata em sua esposa?")) by(responsavel_financeira, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(responsavel_financeira, subtitle("É responsável financeira do lar?", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(catAge, note("")) by(catAge, title("É aceitável que um homem bata em sua esposa?")) by(catAge, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(catAge, subtitle("Por faixa etária", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(catEC, note("")) by(catEC, title("É aceitável que um homem bata em sua esposa?")) by(catEC, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(catEC, subtitle("Por estado civil", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(religiao_import, note("")) by(religiao_import, title("É aceitável que um homem bata em sua esposa?")) by(religiao_import, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(religiao_import, subtitle("Considera a religião importante?", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

graph bar [pweight = S018] if e(sample), over(vdomest) scheme(s1mono) by(catNumeroFilhos, note("")) by(catNumeroFilhos, title("É aceitável que um homem bata em sua esposa?")) by(catNumeroFilhos, caption("Dados da WVS (2005-2020), apenas mulheres", size(2))) by(catNumeroFilhos, subtitle("Por número de filhos", size(3))) ytitle("Frequência relativa") blabel(bar, position(inside) format(%9.1f))

