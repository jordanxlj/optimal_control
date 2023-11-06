using LinearAlgebra
using ForwardDiff
using PyPlot

Q = Diagonal([0.5; 1])

function f(x)
    return 0.5*(x-[1.0; 0])'*Q*(x-[1.0; 0])
end

function df(x)
    return Q*(x-[1.0; 0])
end

function ddf(x)
    return Q
end

function c(x)
    return x[1]^2 + 2*x[1] - x[2]
end

function dc(x)
    return [2*x[1]+2 -1]
end

function plot_func()
    sample_num = 20
    x = kron(ones(sample_num), LinRange(-4.0, 4.0, sample_num)')
    y = kron(ones(sample_num)', LinRange(-4.0, 4.0, sample_num))
    z = zeros(sample_num, sample_num)
    for i = 1:sample_num
        for j = 1:sample_num
            z[i, j] = f([x[i, j], y[i, j]])
        end
    end
    contour(x, y, z)
    xc = LinRange(-3.2, 1.2, sample_num)
    plot(xc, xc.^2+2.0.*xc, c=:yellow)
end

function gauss_newton_step(x0, lambda0)
    H = ddf(x0)
    C = dc(x0)
    delta_z = [H C'; C 0]\[-df(x0)-C'*lambda0; -c(x0)]
    delta_x = delta_z[1:2]
    delta_lambda = delta_z[3]
    return delta_x, delta_lambda
end

function merit_func_gradL(x, lambda, rou)
    grad_L = [-df(x)-dc(x)'*lambda; -c(x)]
    return 0.5*dot(grad_L, grad_L)
end

function merit_func_dgradL(x, lambda, rou)
    H = ddf(x) + ForwardDiff.jacobian(xn -> dc(xn)'*lambda, x)
    return [H dc(x)'; dc(x) 0] * [-df(x)-dc(x)'*lambda; -c(x)]
end

function merit_func_norm1(x, lambda, rou)
    return f(x) + rou*norm(c(x), 1)
end

function merit_func_dnorm1(x, lambda, rou)
    return [df(x) + rou*dc(x)'*sign.(c(x)); zeros(length(lambda))]
end

function merit_func_pen(x, lambda, rou)
    return f(x) + lambda'*c(x) + 0.5*rou*dot(c(x), c(x))
end

function merit_func_dpen(x, lambda, rou)
    return [df(x) + dc(x)'*(lambda + rou*c(x)); c(x)]
end

#println("--------------------------------------")
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 1), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 10), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 100), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 1000), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 10000), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 100000), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println(0.01*dot(merit_func_dnorm1([0.5, 0.25], 0.25, 1000000), [[-0.368421052631579, -0.10526315789473686]; -0.10526315789473686]))
#println("--------------------------------------")

function armijo(func, dfunc, x, delta_x, lambda, delta_lambda, rou)
    alpha = 1.0
    while func(x+alpha*delta_x, lambda+alpha*delta_lambda, rou) > func(x, lambda, rou) + 0.01*alpha*dot(dfunc(x, lambda, rou), [delta_x; delta_lambda])
        alpha = 0.5*alpha
    end
    return alpha
end

function iteration(func, merit_func, merit_dfunc, x0, lambda_0) 
    rou = 1.0
    delta_x, delta_lambda = func(x0, lambda_0)
    alpha = armijo(merit_func, merit_dfunc, x0, delta_x, lambda_0, delta_lambda, rou)
    r = norm(delta_x*alpha)
    x_seq = x0
    lambda_seq = [lambda_0]
    alpha_seq = [alpha]
    count = 0
    while abs(r) > 1e-8 && count < 20
        x_seq = [x_seq x_seq[:, end]+alpha*delta_x]
        lambda_seq = [lambda_seq lambda_seq[end]+alpha*delta_lambda]
        delta_x, delta_lambda = func(x_seq[:, end], lambda_seq[end])
        #println("++++++++++++++")
        #println(x_seq[:, end])
        #println(lambda_seq[end])
        #println(delta_x)
        #println(delta_lambda)
        #println("++++++++++++++")
        rou = rou * 10
        alpha = armijo(merit_func, merit_dfunc, x_seq[:, end], delta_x, lambda_seq[end], delta_lambda, rou)
        alpha_seq = [alpha_seq alpha]
        r = norm(delta_x*alpha)
        count = count + 1
    end
    return x_seq, lambda_seq, alpha_seq
end

plot_func()

rou = 1.0
x0 = [-1.0; -1.0]
lambda0 = [0.0]
#xguess_grad, lambda_guess_grad, alpha_guess_grad = iteration(gauss_newton_step, merit_func_gradL, merit_func_dgradL, x0, lambda0[end])
#plot(xguess_grad[1, :], xguess_grad[2, :], label="merit_grad", "rx")
#
#println("----------merit grad--------------")
#println(xguess_grad[1, :])
#println(xguess_grad[2, :])
#println(length(xguess_grad[1, :]))
#println(alpha_guess_grad)

xguess_norm1, lambda_guess_norm1, alpha_guess_norm1 = iteration(gauss_newton_step, merit_func_norm1, merit_func_dnorm1, x0, lambda0[end])
plot(xguess_norm1[1, :], xguess_norm1[2, :], label="merit_norm1", "gx")
println("----------merit norm1--------------")
println(xguess_norm1[1, :])
println(xguess_norm1[2, :])
println(length(xguess_norm1[1, :]))
println(lambda_guess_norm1)
println(alpha_guess_norm1)

xguess_pen, lambda_guess_pen, alpha_guess_pen = iteration(gauss_newton_step, merit_func_pen, merit_func_dpen, x0, lambda0[end])
plot(xguess_pen[1, :], xguess_pen[2, :], label="merit_pen", "bx")
println("----------merit penalty--------------")
println(xguess_pen[1, :])
println(xguess_pen[2, :])
println(length(xguess_pen[1, :]))
println(lambda_guess_pen)
println(alpha_guess_pen)
legend()

savefig("doc/merit_func.png")
