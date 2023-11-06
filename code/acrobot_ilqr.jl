using LinearAlgebra
using ForwardDiff
using Plots
using RobotDynamics
using RobotZoo
using Printf

rob = RobotZoo.Acrobot()
h = 0.05

function dynamics_rk4(x, u)
    f1 = RobotDynamics.dynamics(rob, x, u)
    f2 = RobotDynamics.dynamics(rob, x+0.5*h*f1, u)
    f3 = RobotDynamics.dynamics(rob, x+0.5*h*f2, u)
    f4 = RobotDynamics.dynamics(rob, x+h*f3, u)
    return x + (h/6)*(f1 + 2*f2 + 2*f3 + f4)
end

function dfdx(x, u)
    ForwardDiff.jacobian(dx->dynamics_rk4(dx, u), x)
end

function dfdu(x, u)
    ForwardDiff.derivative(du->dynamics_rk4(x, du), u)
end

tf = 10
Nt = Int(tf/h) + 1

Nx = 4
Nu = 1
Q = Diagonal([1.0*ones(2); 0.1*ones(2)])
QN = 100.0*I(Nx)
R = 0.01

x0 = [-pi/2; 0; 0; 0]
x_goal = [pi/2; 0; 0; 0]

function J(x_traj, u_traj)
    cost = 0.5*(x_traj[:, Nt]-x_goal)'*QN*(x_traj[:, Nt]-x_goal)
    for k = 1:(Nt-1)
        cost = cost + 0.5*(x_traj[:, k]-x_goal)'*Q*(x_traj[:, k]-x_goal) + 0.5*u_traj[k]*R*u_traj[k]
    end
    return cost
end

function rollout(x_traj, u_traj)
    for k = 1:(Nt-1)
        x_traj[:, k+1] .= dynamics_rk4(x_traj[:, k], u_traj[k])
    end
end

function backward(x_traj, u_traj, p, P, d, K)
    p[:, Nt] = QN*(x_traj[:, Nt] - x_goal)
    P[:, :, Nt] = QN
    delta_J = 0.0
    for k = (Nt-1):-1:1
        delta_x = x_traj[:, k] - x_goal
        delta_u = u_traj[k]
        A = dfdx(x_traj[:, k], u_traj[k])
        B = dfdu(x_traj[:, k], u_traj[k])

        gx = Q*delta_x + A'*p[:, k+1]
        gu = R*delta_u + B'*p[:, k+1]
        Gxx = Q + A'*P[:, :, k+1]*A
        Guu = R + B'*P[:, :, k+1]*B
        Gxu = A'*P[:, :, k+1]*B
        Gux = B'*P[:, :, k+1]*A

        d[k] = Guu\gu
        K[:, :, k] = Guu\Gux

        p[:, k] = gx - K[:, :, k]'*gu + K[:, :, k]'*Guu*d[k] - Gxu*d[k]
        P[:, :, k] = Gxx + K[:, :, k]'*Guu*K[:, :, k] - Gxu*K[:, :, k] - K[:, :, k]'*Gux
        delta_J = delta_J + gu'*d[k]
    end
    return delta_J
end

function forward(x_traj, u_traj, x_n, u_n, d, K, alpha)
    x_n[:, 1] = x_traj[:, 1]

    for k = 1:(Nt-1)
        u_n[k] = u_traj[k] - alpha*d[k] - dot(K[:, :, k], x_n[:, k]-x_traj[:, k])
        x_n[:, k+1] = dynamics_rk4(x_n[:, k], u_n[k])
    end
end

function iteration(x_traj, u_traj, x_n, u_n, g, H, d, K, cost)
    delta_cost = backward(x_traj, u_traj, g, H, d, K)

    alpha = 1.0
    forward(x_traj, u_traj, x_n, u_n, d, K, alpha)
    new_cost = J(x_n, u_n)

    b = 1e-2
    while isnan(new_cost) || new_cost > (cost - b*alpha*delta_cost)
        alpha = 0.5*alpha
        forward(x_traj, u_traj, x_n, u_n, d, K, alpha)
        new_cost = J(x_n, u_n)
    end
    x_traj .= x_n
    u_traj .= u_n
    return new_cost, x_traj, u_traj, d
end

function ilqr(x0)
    x_traj = kron(ones(1, Nt), x0)
    u_traj = zeros(Nt-1)
    x_n = zeros(Nx, Nt)
    u_n = zeros(Nt-1)

    g = zeros(Nx, Nt)
    H = zeros(Nx, Nx, Nt)
    d = ones(Nt-1)
    K = zeros(Nu, Nx, Nt-1)

    rollout(x_traj, u_traj)
    cost = J(x_traj, u_traj)
    println(cost)

    iter = 0
    while true
        cost, x_traj, u_traj, d = iteration(x_traj, u_traj, x_n, u_n, g, H, d, K, cost)
        if (maximum(abs.(d[:])) < 1e-3)
            println("d is under condition")
            break
        else
            iter += 1
        end
    end
    return x_traj, u_traj
end

x_traj, u_traj = ilqr(x0)
t_hist = Array(range(0, h*(Nt-1), step=h))
plot(t_hist[1:Nt-1], x_traj[1, 1:Nt-1], label="x1")
plot!(t_hist[1:Nt-1], x_traj[2, 1:Nt-1], label="x2")
savefig("doc/acrobot_ilqr.png")
