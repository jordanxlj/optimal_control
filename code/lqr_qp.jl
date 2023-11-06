using LinearAlgebra
using SparseArrays
using PyPlot
using BenchmarkTools

Q = sparse(I(2))
R = 0.1.*sparse(I(1))
QN = sparse(I(2))

tf = 10
h = 0.1
N = Int(tf/h) + 1

A = [1 h; 0 1]
B = [0.5*h*h; h]

function J(x_hist, u_hist)
    cost = 0.5*x_hist[:, end]*Q*x_hist[:, end]
    for k = 1:(N-1)
        cost = cost + 0.5*x_hist[:, k]'*Q*x_hist[:, k] + 0.5*u_hist[k]*R*u_hist[k]
    end
    return cost
end

function ConstructProblem(x0)
    H = blockdiag(R, kron(I(N-2), blockdiag(Q, R)), QN)
    C = kron(I(N-1), [B -I(2)])
    for k = 1:(N-2)
        row = k*2+1
        col = k*3-1
        C[row:row+1, col:col+1] .= A
    end
    d = [-A*x0; zeros(size(C, 1)-2)]
    return H, C, d
end

x0 = [1.0; 0]
H, C, d = ConstructProblem(x0)
println("+++++++++++size+++++++++++++")
println(size(H))
println(size(C))
println(size(d))
y = @btime [H C'; C zeros(size(C, 1), size(C, 1))] \ [zeros(size(H,1)); d]
println(size(y))

z = y[1:size(H,1)]
Z = reshape(z, 3, N-1)
println(size(Z))
u_hist = Z[1, :]
x_hist = [x0 Z[2:3, :]]

t_hist = Array(range(0, h*(N-1), step=h))
plot(t_hist, x_hist[1, :], label="position")
plot(t_hist, x_hist[2, :], label="velocity")
plot(t_hist[1:N-1], u_hist, label="input")

xlabel("Time")
legend()
savefig("doc/lqr_qp.png")
