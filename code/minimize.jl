using LinearAlgebra
using ForwardDiff
using PyPlot

function f(x)
    return x.^4 + x.^3 - x.^2 - x
end

function df(x) 
    return 4.0*x.^3 + 3.0*x.^2 - 2.0*x - 1
end

function ddf(x)
    return 12.0*x.^2 + 6.0*x - 2.0
end

function newton(x) 
    return x - ddf(x)\df(x)
end

function regularized_newton(x)
    beta = 1.0
    H = ddf(x)
    while !isposdef(H)
        H = H + beta*I
    end
    xk = x - H \ df(x)
end

function armijo_regularized_newton(x)
    beta = 1.0
    H = ddf(x)
    while !isposdef(H)
        H = H + beta*I
    end

    alpha = 1.0
    b = 0.01
    c = 0.5
    delta_x = -H \ df(x)
    while f(x+alpha*delta_x) > f(x) + b*alpha*df(x)*delta_x
        alpha = c*alpha
    end
    xk = x + alpha*delta_x
end

function iteration(func, x0) 
    xk = func(x0)
    r = xk - x0
    x_seq = [x0]
    while abs(r) > 1e-8
        x_seq = [x_seq xk]
        xk1 = func(xk)
        r = xk1 - xk
        xk = xk1
    end
    return x_seq
end

x = LinRange(-1.75, 1.25, 1000)
plot(x, f(x))

x0 = 0.0
xguess = iteration(newton, x0)
println(f(xguess))
plot(xguess, f(xguess), "rx")

xguess = iteration(regularized_newton, x0)
println(f(xguess))
plot(xguess, f(xguess), "gx")

xguess = iteration(armijo_regularized_newton, x0)
println(xguess)
println(f(xguess))
plot(xguess, f(xguess), "bx")

savefig("minimize.png")
