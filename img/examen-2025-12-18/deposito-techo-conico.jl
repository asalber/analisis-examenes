using GLMakie
# using CairoMakie
graphictype = "png"
# GLMakie.activate!()
# CairoMakie.activate!(type = graphictype)
us = range(0, 1, 20)
vs = range(0, 2pi, 50)
# Inicializamos la figura y los ejes.
fig = Figure(resolution = (600, 400))
ax = Axis3(fig[1,1], aspect = :data)
# Dibujamos el cono
xs = [2u*cos(v) for u in us, v in vs]
ys = [2u*sin(v) for u in us, v in vs]
zs = [1 + 2u for u in us, v in vs]
Makie.surface!(ax, xs, ys, zs; colormap = :viridis, transparency = true, alpha = 0.5, rasterize = true)
# Dibujamos el cilindro
us = range(0, 3.0, 2)
xs = [2cos(v) for u in us, v in vs]
ys = [2sin(v) for u in us, v in vs]
zs = [u for u in us, v in vs]
Makie.surface!(ax, xs, ys, zs; colormap = :winter, transparency = true, alpha = 0.5)
# Trayectoria
g(t) = [2t*cos(2pi*t), 2t*sin(2pi*t), 1+2t] 
ts = range(0, 1, length = 100)
points = Point3.(g.(ts))
lines!(ax, points, linewidth = 2, color = :red)
fig
save("img/examen-2025-12-18/deposito-techo-conico." * graphictype, fig)