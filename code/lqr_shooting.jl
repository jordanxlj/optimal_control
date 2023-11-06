using LinearAlgebra
using PyPlot
using BenchmarkTools

Q = 1.0 * I(2)
R = 0.1
QN = 1.0 * I(2)
h = 0.1
tf = 10
N = Int(tf/h) + 1

function J(x_hist, u_hist)
    cost = 0
    for k = 1:(N-1)
        cost = cost + 0.5*x_hist[:, k]'*Q*x_hist[:, k] + 0.5*u_hist[k]*R*u_hist[k]
    end
    cost = cost + 0.5*x_hist[:, end]'*Q*x_hist[:, end]
end

A = [1 h; 0 1]
B = [1/2*h*h; h]

function rollout(x_hist, u_hist)
    x_new = zeros(size(x_hist))
    x_new[:, 1] = x_hist[:, 1]
    for k = 1:N-1
        x_new[:, k+1] = A*x_new[:, k] + B*u_hist[k]
    end
    return x_new
end

t_hist = Array(range(0, h*(N-1), step=h))

function iteration(x_hist, u_hist, lambda_hist)
    delta_u = ones(N-1)
    b = 1e-2
    iter = 0
    while (maximum(abs.(delta_u)) > 1e-2)
    #while (norm(delta_u) > 1e-2)
        #println("-------------")
        lambda_hist[:, N] = QN*x_hist[:, N]
        #println(lambda_hist[:, N])
        for k = N-1:-1:1
            delta_u[k] = -(u_hist[k] + R\B'*lambda_hist[:, k+1])
            lambda_hist[:, k] = Q*x_hist[:, k] + A'*lambda_hist[:, k+1]
        end
        #println("u_hist, delta_u begin")
        #println(u_hist)
        #println(delta_u)
        #println("u_hist, delta_u end")
        alpha = 1.0
        u_new = u_hist + alpha.*delta_u
        x_new = rollout(x_hist, u_new)
        while J(x_new, u_new) > J(x_hist, u_hist) - b*alpha*delta_u[:]'*delta_u[:]
            alpha = 0.5*alpha
            u_new = u_hist + alpha.*delta_u
            x_new = rollout(x_hist, u_new)
            #println(alpha)
        end
        u_hist = u_new
        x_hist = x_new
        #println("u new, x new begin")
        #println(u_hist)
        #println(x_hist)
        #println("u new, x new end")
        iter += 1
        #println(iter)
    end
    #println(delta_u)
    #println(iter)
    return iter, x_hist, u_hist
end

#initialize
x0 = [1.0; 0]
x_hist = repeat(x0, 1, N)
u_hist = zeros(N-1)
lambda_hist = zeros(2, N)
x_hist = rollout(x_hist, u_hist)
println(J(x_hist, u_hist))
println(x_hist)

iter, x_hist, u_hist = @btime iteration(x_hist, u_hist, lambda_hist)
println(J(x_hist, u_hist))

plot(t_hist, x_hist[1, :], label="position")
plot(t_hist, x_hist[2, :], label="velocity")
plot(t_hist[1:N-1], u_hist, label="input")
xlabel("Time")
legend()
savefig("doc/lqr_shooting.png")
