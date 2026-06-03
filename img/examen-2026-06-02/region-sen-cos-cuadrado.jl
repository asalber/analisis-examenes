using CairoMakie

myblue   = "#0099CC"
mypurple = "#DB1286"
myred    = "#FF2152"
mygreen  = "#03BF3D"
myblack  = "#808080"
mygray   = "#B3B3B3"

f(x) = sin(x)
g(x) = cos(x)^2

u  = (sqrt(5) - 1)/2
x1 = asin(u)
x2 = π - asin(u)

xs = range(0, π; length = 400)
xr = range(x1, x2; length = 300)

fig = Figure(size = (600, 450), backgroundcolor = :transparent)
ax  = Axis(fig[1,1];
           backgroundcolor = :transparent,
           xlabel = L"$x$", ylabel = L"$y$",
           title = L"Región entre $\mathrm{sen}(x)$ y $\cos(x)^2$",
           # texto en mygray
           titlecolor = mygray,
           titlesize = 18,
           xlabelcolor = mygray, ylabelcolor = mygray,
           xticklabelcolor = mygray, yticklabelcolor = mygray,
           # bordes (ejes y marcas) en myblack
           leftspinecolor = myblack, rightspinecolor = myblack,
           topspinecolor = myblack,  bottomspinecolor = myblack,
           xtickcolor = myblack, ytickcolor = myblack)

# región
band!(ax, xr, g.(xr), f.(xr); color = (myblue, 0.35))

# curvas
lines!(ax, xs, f.(xs); color = myblue, linewidth = 2.5, label = L"$\mathrm{sen}(x)$")
lines!(ax, xs, g.(xs); color = myred,  linewidth = 2.5, label = L"$\cos(x)^2$")

# verticales en los cortes y puntos de intersección (bordes -> myblack)
vlines!(ax, [x1, x2]; color = (myblack, 0.5), linestyle = :dash)
scatter!(ax, [x1, x2], [f(x1), f(x2)]; color = myblack, markersize = 10)

axislegend(ax; position = :rt, labelcolor = mygray, framecolor = myblack, backgroundcolor = :transparent)
fig

save("region-sen-cos-cuadrado.png", fig)
save("region-sen-cos-cuadrado.pdf", fig)
save("region-sen-cos-cuadrado.svg", fig)