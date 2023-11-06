using LinearAlgebra
using PyPlot
using BenchmarkTools
using ControlSystems

Q = 1.0*I(2)
R = 0.1
QN = 1.0*I(2)

tf = 10
h = 0.1
N = Int(tf/h) + 1

A = [1 h; 0 1]
B = [0.5*h*h; h]

function J(x_hist, u_hist)
    cost = 0.5*x_hist[:, end]'*Q*x_hist[:, end]
    for k = 1:(N-1)
        cost = cost + 0.5*x_hist[:, k]'*Q*x_hist[:, k] + 0.5*u_hist[k]*R*u_hist[k]
    end
    return cost
end

function ricatti(x0)
    P = zeros(2, 2, N)
    K = zeros(1, 2, N)
    P[:, :, N] .= QN
    
    for k=N-1:-1:1
        K[:, :, k] = (R + B'*P[:, :, k+1]*B) \ (B'*P[:, :, k+1]*A)
        P[:, :, k] = Q + A'*P[:, :, k+1]*(A-B*K[:, :, k+1])
    end

    x_hist = zeros(2, N)
    x_hist[:, 1] = x0
    u_hist = zeros(1, N-1)

    for k = 1:(N-1)
        #println(K[:, :, k])
        #println(x_hist[:, k])
        u_hist[:, k] = -K[:, :, k]*x_hist[:, k]
        x_hist[:, k+1] = A*x_hist[:, k] + B*u_hist[k] + 0.01*randn(2)
    end
    return x_hist, u_hist, K
end

function auto_ricatti(x0)
    K = dlqr(A, B, Q, R)

    x_hist = zeros(2, N)
    x_hist[:, 1] = x0
    u_hist = zeros(1, N-1)

    for k = 1:(N-1)
        u_hist[:, k] = -K*x_hist[:, k]
        x_hist[:, k+1] = A*x_hist[:, k] + B*u_hist[k]
    end
    return x_hist, u_hist, K
end

x0 = [1.0; 0]
x_hist, u_hist, K = @btime ricatti(x0)
println(size(x_hist))
println(size(u_hist))
println(J(x_hist,u_hist))

t_hist = Array(range(0, h*(N-1), step=h))
plot(t_hist[1:N-1], x_hist[1, 1:N-1], label="position")
plot(t_hist[1:N-1], x_hist[2, 1:N-1], label="velocity")
plot(t_hist[1:N-1], u_hist[1:N-1], label="input")

plot(t_hist[1:N-1], K[1, 1, 1:N-1], label="K1")
plot(t_hist[1:N-1], K[1, 2, 1:N-1], label="K2")

x_hist, u_hist, K = @btime auto_ricatti(x0)
println(size(x_hist))
println(size(u_hist))
println(J(x_hist,u_hist))
println(K)

t_hist = Array(range(0, h*(N-1), step=h))
plot(t_hist[1:N-1], x_hist[1, 1:N-1], label="auto_position")
plot(t_hist[1:N-1], x_hist[2, 1:N-1], label="auto_velocity")
plot(t_hist[1:N-1], u_hist[1:N-1], label="auto_input")

xlabel("Time")
legend()
savefig("doc/lqr_riccati.png")
