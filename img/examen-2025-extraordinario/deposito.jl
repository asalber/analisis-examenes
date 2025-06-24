using Plots, LaTeXStrings
f(x) = 2-sin(x/4-1)
g(x) = log2(x)
plot(f, 0, 4, label = L"2-\operatorname{sen}\left(\frac{x}{4}-1\right)")
plot!(g,1, 4, label = L"\log_2(x)")
# Guardar el gráfico.
savefig("img/deposito.pdf")