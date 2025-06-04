using Plots, LaTeXStrings
f(θ) = 2sin(2θ)
g(θ) = 1
θs = 0:0.01:2π

# conversión a coordenadas cartesianas
x1s = @. f(θs) * cos(θs);  y1s = @. f(θs) * sin(θs)
x2s = @. g(θs) * cos(θs);  y2s = @. g(θs) * sin(θs)

# Intersección
r_fill = @. min(abs(f(θs)), g(θs))

# conversion  
x_fill = @. r_fill * cos(θs)
y_fill = @. r_fill * sin(θs)

# Gráfico
plot(x_fill, y_fill,
    seriestype = :shape,
    fillalpha = 0.3,
    aspect_ratio = 1,
    linecolor = :white,
    label = ""
)

plot!(x1s, y1s, label = L"$r = 2\operatorname{sen}(2θ)$", legend = :right)

plot!(x2s, y2s,
    color = :steelblue,
    label = L"$r = 1$",
)

savefig("img/flor-circulo.png")
savefig("img/flor-circulo.pdf")