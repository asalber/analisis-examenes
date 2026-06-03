using CairoMakie, GeometryBasics

# ---------- Colores ----------
myblue = "#0099CC"

# ---------- Parámetros ----------
w   = 0.5
θ0  = π
θ1  = 2π
N   = 300

θs = range(θ0, θ1; length = N)

# ---------- Curva polar r = θ/2 ----------
r(θ)  = θ/2
xc(θ) = r(θ)*cos(θ)
yc(θ) = r(θ)*sin(θ)
dx(θ) = 0.5cos(θ) - 0.5θ*sin(θ)
dy(θ) = 0.5sin(θ) + 0.5θ*cos(θ)

# ---------- Longitud de arco y altura ----------
S(θ)      = 0.25*(θ*sqrt(θ^2+1) + asinh(θ))
arclen(θ) = S(θ) - S(θ0)
h(θ)      = 1.0 + 0.5*arclen(θ)

# ---------- Vértices (A,B,C,D por sección) ----------
verts = Point3f[]
for θ in θs
    cx, cy = xc(θ), yc(θ)
    tx, ty = dx(θ), dy(θ)
    L = hypot(tx, ty)
    nx, ny = -ty/L, tx/L
    hz = h(θ)
    push!(verts, Point3f(cx + w/2*nx, cy + w/2*ny, 0 ))   # A  inferior +
    push!(verts, Point3f(cx - w/2*nx, cy - w/2*ny, 0 ))   # B  inferior -
    push!(verts, Point3f(cx + w/2*nx, cy + w/2*ny, hz))   # C  superior +
    push!(verts, Point3f(cx - w/2*nx, cy - w/2*ny, hz))   # D  superior -
end

faces = GLTriangleFace[]
quad!(a,b,c,d) = (push!(faces, GLTriangleFace(a,b,c)); push!(faces, GLTriangleFace(a,c,d)))
for i in 1:N-1
    b0, b1 = 4*(i-1), 4*i
    Ai,Bi,Ci,Di = b0+1,b0+2,b0+3,b0+4
    Aj,Bj,Cj,Dj = b1+1,b1+2,b1+3,b1+4
    quad!(Ai, Aj, Cj, Ci); quad!(Bi, Di, Dj, Bj)
    quad!(Ci, Cj, Dj, Di); quad!(Ai, Bi, Bj, Aj)
end
quad!(1, 2, 4, 3)
bN = 4*(N-1); quad!(bN+1, bN+3, bN+4, bN+2)
muro = GeometryBasics.Mesh(verts, faces)

# ---------- Aristas ----------
A = verts[1:4:end]   # arista inferior +
B = verts[2:4:end]   # arista inferior -
C = verts[3:4:end]   # arista superior +
D = verts[4:4:end]   # arista superior -

# ---------- Dibujo ----------
fig = Figure(size = (800,600))
ax  = Axis3(fig[1,1]; aspect = :data,
            xlabel = "x", ylabel = "y", zlabel = "altura (m)",
            title = "Muro en forma de espiral")

mesh!(ax, muro; color = myblue, transparency = true, alpha = 0.5)

for edge in (A, B, C, D)                       # 4 aristas longitudinales
    lines!(ax, edge; color = :gray20, linewidth = 2.5)
end
lines!(ax, [A[1],   B[1],   D[1],   C[1],   A[1]];   color = :gray20, linewidth = 2.5)  # tapa inicial
lines!(ax, [A[end], B[end], D[end], C[end], A[end]]; color = :gray20, linewidth = 2.5)  # tapa final

