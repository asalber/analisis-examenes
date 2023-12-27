using GLMakie
graphictype = "pdf"
#GLMakie.activate!()
CairoMakie.activate!(type = graphictype)
myblue = RGBf(0.067,0.529,0.871)
myred = RGBf(1.0, 0.13, 0.32)
size_inches = (8, 6)
size_pt = 100 .* size_inches
fig = Figure(resolution = size_pt, fontsize = 16)
ax = Axis3(fig[1,1], aspect = :data, elevation = pi/10)

# Define the ranges for theta and r
theta = range(0, stop = 2pi, length = 100)  # azimuthal angle
r = range(0, stop = 1, length = 50)        # radius

# Create a grid of points using array comprehension
xs, ys, zs = [r * cos(theta) for r in r, theta in theta], 
          [r * sin(theta) for r in r, theta in theta], 
          [2 * r for r in r, theta in theta]

# Plot the cone
surface!(ax, xs, ys, zs, colormap = :Blues_3)

# Define the ranges for theta and phi
theta = range(0, stop = 2pi, length = 100)  # azimuthal angle
phi = range(0, stop = pi/2, length = 50)   # polar angle (only half for a semi-sphere)

# Create a grid of points using array comprehension
xs, ys, zs = [R * sin(phi) * cos(theta) for phi in phi, theta in theta], 
          [R * sin(phi) * sin(theta) for phi in phi, theta in theta], 
          [R * cos(phi) for phi in phi, theta in theta]

# Define the radius of the semi-sphere and the center coordinates
R = 1 
center_x = 0
center_y = 0
center_z = 2

# Shift the center of the semi-sphere
xs .+= center_x
ys .+= center_y
zs .+= center_z

# Plot the semi-sphere
surface!(ax, xs, ys, zs, colormap = :Reds_3)

save("img/examen-2023-12-22/helado." * graphictype, fig, pt_per_unit = 1)
fig