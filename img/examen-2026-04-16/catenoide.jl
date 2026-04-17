using CairoMakie, LaTeXStrings

include("../mytheme.jl")


a = 1.0
b = 2.0
t = LinRange(-b, b, 100)
θ = LinRange(0, 2π, 100)
x = [ti for ti in t, _ in θ]
y = [a * cosh(ti / a) * cos(θj) for ti in t, θj in θ]
z = [a * cosh(ti / a) * sin(θj) for ti in t, θj in θ]
fig = Figure(backgroundcolor=:transparent)
ax = Axis3(fig[1, 1],
    title = L"Catenoide  $y = \cosh(x)$",
    xlabel = "x", ylabel = "y", zlabel = "z", backgroundcolor = :transparent
)
surface!(ax, x, y, z, colormap = :viridis)
save("img/examen-2026-04-16/catenoide.svg", fig, backgroundcolor=:transparent)
save("img/examen-2026-04-16/catenoide.pdf", fig, backgroundcolor=:transparent)
save("img/examen-2026-04-16/catenoide.png", fig, backgroundcolor=:transparent)
fig