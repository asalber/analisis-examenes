using CairoMakie

myblue = "#0099CC"
myred  = "#ff2152"

L = 7.57
h(x) = 1 + x/2

xs = range(0, L; length = 300)
hs = h.(xs)

x0 = 4.75
Δx = 0.25
Δy = Δx/2
y1 = h(x0)

rect(x, y, w, hgt) = Point2f[(x, y), (x+w, y), (x+w, y+hgt), (x, y+hgt)]

fig = Figure(size = (850, 550))
ax  = Axis(fig[1,1]; xlabel = "x (m)", ylabel = "altura (m)",
           title = "Perfil del muro",
           aspect = DataAspect(),
           xticks = ([0, L], ["0", "L"]))
xlims!(ax, 0, L)
ylims!(ax, 0, h(L) + 0.3)

band!(ax, xs, fill(0.0, length(xs)), hs; color = (:slategray, 0.25))
lines!(ax, xs, hs; color = :black, linewidth = 2)

poly!(ax, rect(x0, 0, Δx, y1);     color = (myblue, 0.5), strokecolor = myblue, strokewidth = 2)
poly!(ax, rect(x0, y1/2, Δx, Δy);  color = (myred, 0.6),  strokecolor = myred,  strokewidth = 2)

# --- cota Δy (a la derecha del segundo rectángulo, dentro del eje) ---
xr = x0 + Δx + 0.10
lines!(ax, [xr, xr], [y1/2, y1/2 + Δy]; color = myred)
lines!(ax, [xr-0.04, xr+0.04], [y1/2, y1/2];       color = myred)
lines!(ax, [xr-0.04, xr+0.04], [y1/2+Δy, y1/2+Δy]; color = myred)
text!(ax, xr + 0.08, y1/2 + Δy/2; text = L"\Delta y",
      align = (:left, :center), fontsize = 22, color = myred)

# --- cota Δx DEBAJO del eje x (sobre ax.blockscene, en píxeles) ---
xpix(lims, vp, x) = vp.origin[1] + (x - lims.origin[1]) / lims.widths[1] * vp.widths[1]

bracket = lift(ax.finallimits, ax.scene.viewport) do lims, vp
    xa, xb = xpix(lims, vp, x0), xpix(lims, vp, x0 + Δx)
    yb = vp.origin[2] - 12
    Point2f[(xa, yb), (xb, yb),
            (xa, yb-4), (xa, yb+4),
            (xb, yb-4), (xb, yb+4)]
end
linesegments!(ax.blockscene, bracket; space = :pixel, color = myblue, linewidth = 1.5)

labelpos = lift(ax.finallimits, ax.scene.viewport) do lims, vp
    Point2f(xpix(lims, vp, x0 + Δx/2), vp.origin[2] - 16)
end
text!(ax.blockscene, labelpos; text = L"\Delta x", space = :pixel,
      align = (:center, :top), fontsize = 22, color = myblue)

fig

save("perfil-muro.png", fig)
save("perfil-muro.svg", fig)
save("perfil-muro.pdf", fig)