using LinearAlgebra
using ForwardDiff
using PyPlot

Q = Diagonal([0.5; 1.0])

function f(x)
    return 0.5*(x-[1.0; 0])'*Q*(x-[1.0; 0])
end

function df(x)
    return Q*(x-[1.0; 0])
end

function ddf(x)
    return Q
end

A = [1.0 -1.0]
b = -1.0
function c(x)
    return dot(A, x) - b
end

function dc(x)
    return A
end

function plot_func()
    sample_num = 20
    x = kron(ones(sample_num), LinRange(-4.0, 4.0, sample_num)')
    y = kron(ones(sample_num)', LinRange(-4.0, 4.0, sample_num))
    z = zeros(sample_num, sample_num)
    for i = 1:sample_num
        for j = 1:sample_num
            z[i, j] = f([x[i, j]; y[i, j]])
        end
    end

    contour(x, y, z)
    xc = LinRange(-4, 3, sample_num)
    plot(xc, xc.+1, "y")
end

function lagrangian_augumented(x, lambda, rou)
    p = max(0, c(x))
    return f(x) + lambda*p + 0.5*rou*p'*p
end

function newton_solve(x, lambda, rou)
    p = max(0, c(x))
    C = zeros(1, 2)
    if isposdef(c(x))
        C = dc(x)
    end
    g = df(x) + (lambda + rou*p)*C'
    while norm(g) > 1e-8
        H = ddf(x) + rou*C'*C
        delta_x = -H\g
        x = x + delta_x
        println(H)
        println(x)
        p = max(0, c(x))
        C = zeros(1,2)
        if isposdef(c(x))
            C = dc(x)
        end
        g = df(x) + (lambda + rou*p)*C'
    end
    return x
end

function iteration(func, x0, lambda_0, rou) 
    x_k = func(x0, lambda_0, rou)
    lambda_k = max.(0, lambda_0+rou*c(x_k))
    rou = rou * 10

    r = norm(x_k - x0)
    x_seq = x0
    lambda_seq = [lambda_0]
    count = 0
    while abs(r) > 1e-8 && count < 20
        x_seq = [x_seq x_k]
        lambda_seq = [lambda_seq lambda_k]
        x_k1 = func(x_k, lambda_k, rou)
        lambda_k1 = max.(0, lambda_k+rou*c(x_k1))
        r = norm(x_k1 - x_k)
        x_k = x_k1
        lambda_k = lambda_k1
        rou = rou * 10
        count = count + 1
    end
    return x_seq, lambda_seq
end

plot_func()
xguess = [-3; 2]
lambda_guess = 0.0
rou = 1.0
xguess, lambda_guess = iteration(newton_solve, xguess, lambda_guess, rou)
println(xguess)
println(lambda_guess)
last = length(xguess[1, :])
plot(xguess[1, :], xguess[2, :], label="newton", "rx")
plot(xguess[1, last], xguess[2, last], label="endpoint", "gx")
legend()

savefig("inequality_constrains.png")

