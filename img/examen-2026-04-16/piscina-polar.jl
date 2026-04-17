using CairoMakie, LaTeXStrings
include("../mytheme.jl")

f(θ) = 8 * sin(θ/2)^2
θ = range(0, 2π, length=100)
fig = Figure(backgroundcolor=:transparent)
ax = PolarAxis(fig[1, 1], title=L"Piscina polar $r = 8\sin(\theta/2)^2$", radius_at_origin = 0, rticks = (0:2:8, ["0", "2", "4", "6", "8"]), thetaticks = ([0, π/2, π, 3π/2], [L"0", L"\frac{\pi}{2}", L"\pi", L"\frac{3\pi}{2}"]), backgroundcolor = :transparent)
lines!(ax, θ, f.(θ), color=myblue)
band!(ax, θ, 0, f.(θ), color = (myblue, 0.5), alpha = 0.5)
save("img/examen-2026-04-16/piscina-polar.svg", fig, backgroundcolor=:transparent)
save("img/examen-2026-04-16/piscina-polar.pdf", fig, backgroundcolor=:transparent)
save("img/examen-2026-04-16/piscina-polar.png", fig, backgroundcolor=:transparent)
fig