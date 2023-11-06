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

function newton_step(x0, lambda0)
    H = ddf(x0) + ForwardDiff.jacobian(x -> dc(x)'*lambda0, x0)
    #beta = 1.0
    #while !isposdef(H)
    #    H = H + beta.*I
    #end
    C = dc(x0)
    delta_z = [H C'; C 0] \ [-df(x0)-C'*lambda0; -c(x0)]
    delta_x = delta_z[1:2]
    delta_lambda = delta_z[3]
    return x0+delta_x, lambda0+delta_lambda
end

function regularized_newton_step(x, λ)
    β = 1.0
    H = ddf(x) + ForwardDiff.jacobian(xn -> dc(xn)'*λ, x)
    C = dc(x)
    K = [H C'; C 0]
    e = eigvals(K)
    while !(sum(e .> 0) == length(x) && sum(e .< 0) == length(λ))
        K = K + Diagonal([β*ones(length(x)); -β*ones(length(λ))])
        e = eigvals(K)
    end
    Δz = K\[-df(x)-C'*λ; -c(x)]
    Δx = Δz[1:2]
    Δλ = Δz[3]
    return x+Δx, λ+Δλ
end

function gauss_newton_step(x0, lambda0)
    H = ddf(x0)
    C = dc(x0)
    delta_z = [H C'; C 0] \ [-df(x0)-C'*lambda0; -c(x0)]
    delta_x = delta_z[1:2]
    delta_lambda = delta_z[3]
    return x0+delta_x, lambda0+delta_lambda
end

function iteration(func, x0, lambda_0) 
    x_k, lambda_k = func(x0, lambda_0)
    r = norm(x_k - x0)
    x_seq = x0
    lambda_seq = [lambda_0]
    count = 0
    while abs(r) > 1e-8 && count < 20
        x_seq = [x_seq x_k]
        lambda_seq = [lambda_seq lambda_k]
        x_k1, lambda_k1 = func(x_k, lambda_k)
        r = norm(x_k1 - x_k)
        x_k = x_k1
        lambda_k = lambda_k1
        count = count + 1
    end
    return x_seq, lambda_seq
end

plot_func()
x0 = [-3; 2]
lambda0 = [0.0]
xguess_newton, lambda_guess_newton = iteration(newton_step, x0, lambda0[end])

#scatter!(xguess[1, :], xguess[2, :], series_annotations=text.(1:length(xguess)))
plot(xguess_newton[1, :], xguess_newton[2, :], label="newton", "rx")
println("----------newton--------------")
println(xguess_newton[1, :])
println(xguess_newton[2, :])
println(length(xguess_newton[1, :]))

xguess_regularized, lambda_guess_regularized = iteration(regularized_newton_step, x0, lambda0[end])
plot(xguess_regularized[1, :], xguess_regularized[2, :], label="regularized_newton", "gx")
println("----------regularized newton--------------")
println(xguess_regularized[1, :])
println(xguess_regularized[2, :])
println(length(xguess_regularized[1, :]))

xguess_gauss, lambda_guess_gauss = iteration(gauss_newton_step, x0, lambda0[end])
plot(xguess_gauss[1, :], xguess_gauss[2, :], label="gauss_newton", "bx")
legend()
println("----------gauss newton--------------")
println(xguess_gauss[1, :])
println(xguess_gauss[2, :])
println(length(xguess_gauss[1, :]))


#println(xguess_newton[1, :] .- xguess_gauss[1, :])
#println(xguess_newton[2, :] .- xguess_gauss[2, :])
savefig("equality_constraints.png")
