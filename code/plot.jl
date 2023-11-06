using Plots

x = range(0, 10, length=100)
y1 = @. exp(-0.1x) * cos(4x)
y2 = @. exp(-0.3x) * cos(4x)
y3 = @. exp(-0.1x)
y4 = @. exp(-0.3x)
y = [y1 y2 y3 y4]

p1 = plot(x, y)
p2 = plot(x, y, title="Title 2", lw=3)
p3 = scatter(x, y, ms=2, ma=0.5, xlabel="xlabel 3")
p4 = scatter(x, y, title="Title 4", ms=2, ma=0.2)
plot(p1, p2, p3, p4, layout=(2,2), legend=false)

savefig("doc/plot.png")
