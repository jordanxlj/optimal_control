using LinearAlgebra
using ForwardDiff
using ControlSystems
using SparseArrays
using OSQP
using Plots
using JLD2

Nx = 6
Nu = 2
Q = sparse(1.0*I(Nx))
R = sparse(0.01*I(Nu))
QN = sparse(1.0*I(Nx))

tf = 10
h = 0.05
Nt = Int(tf/h) + 1
Nh = 20

g = 9.81
m = 1.0
l = 0.3
J = 0.2*m*l*l

u_min = [0.2*m*g; 0.2*m*g]
u_max = [0.6*m*g; 0.6*m*g]

@enum LimitType begin
    no_limit
    u_limit
    angle_limit
end

function quad_dynamics(x, u)
    theta = x[3]
    ddx = 1/m*(u[1]+u[2])*sin(theta)
    ddy = 1/m*(u[1]+u[2])*cos(theta) - g
    ddtheta = 0.5*l/J*(u[2] - u[1])
    return [x[4:6]; ddx; ddy; ddtheta]
end

function quad_dynamics_rk4(x, u)
    f1 = quad_dynamics(x, u)
    f2 = quad_dynamics(x+0.5*h*f1, u)
    f3 = quad_dynamics(x+0.5*h*f2, u)
    f4 = quad_dynamics(x+h*f3, u)
    return x + (h/6)*(f1 + 2*f2 + 2*f3 + f4)
end

x_hover = zeros(Nx)
u_hover = [0.5*m*g; 0.5*m*g]

function ConstructQPProblem(x_hover, u_hover)
    A = ForwardDiff.jacobian(x->quad_dynamics_rk4(x, u_hover), x_hover)
    B = ForwardDiff.jacobian(u->quad_dynamics_rk4(x_hover, u), u_hover)
    K = dlqr(A, B, Array(Q), Array(R))
    P = sparse(dare(A, B, Array(Q), Array(R)))
    return A, B, K, P
end

function ConstructMPCProblem(A, B, lb, ub, limit::LimitType)
    H = blockdiag(R, kron(I(Nh-1), blockdiag(Q, R)), P)
    b = zeros(Nh*(Nx+Nu))

    C = kron(I(Nh), [B -I(Nx)])
    U = kron(I(Nh), [I(Nu) zeros(Nu, Nx)])
    theta = kron(I(Nh), [0 0 0 0 1 0 0 0])
    for k = 1:(Nh-1)
        row = k*Nx
        col = k*(Nu+Nx)-6
        C[row+1:row+Nx, col+1:col+Nx] .= A
    end

    if limit == no_limit
        D = sparse(C)
    elseif limit == u_limit
        D = [sparse(C); U]
    elseif limit == angle_limit
        D = [sparse(C); U; theta]
    end

    problem = OSQP.Model()
    OSQP.setup!(problem; P=H, q=b, A=D, l=lb, u=ub, verbose=true, eps_abs=1e-8, eps_rel=1e-8, polish=1)
    return problem
end

function qp_controller(t, x, K, x_ref)
    return u_hover - K*(x-x_ref)
end

function mpc_controller(t, x, x_ref, problem, lb, ub)
    lb[1:6] .= -A*x
    ub[1:6] .= -A*x

    b = zeros(Nh*(Nx+Nu))
    for j = 1:(Nh-1)
        row = Nu + (Nu+Nx)*(j-1)
        b[row+1:row+Nx] .= -Array(Q)*x_ref
    end

    row = Nu + (Nu+Nx)*(Nh-1)
    b[row+1:row+Nx] .= -Array(P)*x_ref

    OSQP.update!(problem, q=b, l=lb, u=ub)
    results = OSQP.solve!(problem)
    delta_u = results.x[1:Nu]
    return u_hover + delta_u
end

function closed_loop(x0, controller, N)
    x_hist = zeros(length(x0), N)
    x_hist[:, 1] = x0

    u0 = controller(1, x0)
    u_hist = zeros(length(u0), N-1)
    u_hist[:, 1] = u0

    for k = 1:(N-1)
        uk = controller(k, x_hist[:, k])
        u_hist[:, k] = max.(min.(u_max, uk), u_min)
        x_hist[:, k+1] = quad_dynamics_rk4(x_hist[:, k], u_hist[:, k])
    end
    return x_hist, u_hist
end

A, B, K, P = ConstructQPProblem(x_hover, u_hover)
lb = zeros(Nx*Nh)
ub = zeros(Nx*Nh)
mpc_prob = ConstructMPCProblem(A, B, lb, ub, no_limit)

lb_u = [zeros(Nx*Nh); kron(ones(Nh), u_min-u_hover)]
ub_u = [zeros(Nx*Nh); kron(ones(Nh), u_max-u_hover)]
mpc_prob_u_limit = ConstructMPCProblem(A, B, lb_u, ub_u, u_limit)

lb_angle = [zeros(Nx*Nh); kron(ones(Nh), u_min-u_hover); -0.2*ones(Nh)]
ub_angle = [zeros(Nx*Nh); kron(ones(Nh), u_max-u_hover); 0.2*ones(Nh)]
mpc_prob_angle_limit = ConstructMPCProblem(A, B, lb_angle, ub_angle, angle_limit)

x_ref = [0.; 1.0; 0; 0; 0; 0]
x0 = [10.0; 2.0; 0; 0; 0; 0]
x_hist_lqr, u_hist_lqr = closed_loop(x0, (t, x)->qp_controller(t, x, K, x_ref), Nt)
x_hist_mpc, u_hist_mpc = closed_loop(x0, (t, x)->mpc_controller(t, x, x_ref, mpc_prob, lb, ub), Nt)
x_hist_mpc_u, u_hist_mpc_u = closed_loop(x0, (t, x)->mpc_controller(t, x, x_ref, mpc_prob_u_limit, lb_u, ub_u), Nt)
x_hist_mpc_angle, u_hist_mpc_angle = closed_loop(x0, (t, x)->mpc_controller(t, x, x_ref, mpc_prob_angle_limit, lb_angle, ub_angle), Nt)

t_hist = Array(range(0, h*(Nt-1), step=h))
p1 = plot(t_hist[1:Nt-1], x_hist_lqr[1, 1:Nt-1], label="x_LQR")
plot!(t_hist[1:Nt-1], x_hist_mpc[1, 1:Nt-1], label="x_MPC")
plot!(t_hist[1:Nt-1], x_hist_mpc_u[1, 1:Nt-1], label="x_MPC_u")
plot!(t_hist[1:Nt-1], x_hist_mpc_angle[1, 1:Nt-1], label="x_MPC_angle")

p2 = plot(t_hist[1:Nt-1], x_hist_lqr[2, 1:Nt-1], label="y_LQR")
plot!(t_hist[1:Nt-1], x_hist_mpc[2, 1:Nt-1], label="y_MPC")
plot!(t_hist[1:Nt-1], x_hist_mpc_u[2, 1:Nt-1], label="y_MPC_u")
plot!(t_hist[1:Nt-1], x_hist_mpc_angle[2, 1:Nt-1], label="y_MPC_angle")

p3 = plot(t_hist[1:Nt-1], x_hist_lqr[3, 1:Nt-1], label="theta_LQR")
plot!(t_hist[1:Nt-1], x_hist_mpc[3, 1:Nt-1], label="theta_MPC")
plot!(t_hist[1:Nt-1], x_hist_mpc_u[3, 1:Nt-1], label="theta_MPC_u")
plot!(t_hist[1:Nt-1], x_hist_mpc_angle[3, 1:Nt-1], label="theta_MPC_angle")

p4 = plot(t_hist[1:Nt-1], u_hist_lqr[1, 1:Nt-1], label="u1_LQR")
plot!(t_hist[1:Nt-1], u_hist_mpc[1, 1:Nt-1], label="u1_MPC")
plot!(t_hist[1:Nt-1], u_hist_mpc_u[1, 1:Nt-1], label="u1_MPC_u")
plot!(t_hist[1:Nt-1], u_hist_mpc_angle[1, 1:Nt-1], label="u1_MPC_angle")

p5 = plot(t_hist[1:Nt-1], u_hist_lqr[2, 1:Nt-1], label="u2_LQR")
plot!(t_hist[1:Nt-1], u_hist_mpc[2, 1:Nt-1], label="u2_MPC")
plot!(t_hist[1:Nt-1], u_hist_mpc_u[2, 1:Nt-1], label="u2_MPC_u")
plot!(t_hist[1:Nt-1], u_hist_mpc_angle[2, 1:Nt-1], label="u2_MPC_angle")

plot(p1, p2, p3, p4, p5, layout=(2, 3), legend=true)

savefig("doc/planar_quadrator_mpc.png")

println("--------------lqr vs. mpc without limit-------------")
println(maximum(abs.(x_hist_lqr-x_hist_mpc)))
println(maximum(abs.(u_hist_lqr-u_hist_mpc)))
