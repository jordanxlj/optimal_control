using LinearAlgebra
using ForwardDiff
using Plots

function pendulum(x)
    l = 1.0
    g = 9.81
    theta = x[1]
    theta_diff = x[2]
    theta_diff_2 = -g/l * sin(theta)
    return [theta_diff; theta_diff_2]
end

function backward_euler_fixed_point(func, x0, h)
    xk = x0
    e = [norm(x0 + h.*func(xk) - xk)]
    count = 0
    while e[end] > 1e-8 && count < 10
        xk = x0 + h.*func(xk)
        e = norm(x0 + h.*func(xk) - xk)
        count += 1
    end
    return xk, e
end

function fixed_point(func, x0, tf, h)
    t = Array(range(0, tf, step=h))
    x_hist = zeros(length(x0), length(t))
    x_hist[:, 1] .= x0

    error = zeros(length(t))
    error[1] = 0.

    for k = 1:length(t)-1
        x_hist[:, k+1], error[k+1] = backward_euler_fixed_point(func, x_hist[:, k], h)
    end
    return t, x_hist, error
end

function backward_euler_newton(func, x0, h)
    xk = x0
    r = x0 + h.*func(xk) - xk
    #println(x0)
    e = [norm(r)]
    while e[end] > 1e-8
        deriv_f = ForwardDiff.jacobian(x -> x0 + h.*func(x) - x, xk)
        #println(deriv_f)
        xk = xk - deriv_f \ r
        r = x0 + h.*func(xk) - xk
        e = [e; norm(r)]
    end
    return xk, e[end] 
end

function newton(func, x0, tf, h)
    t = Array(range(0, tf, step=h))
    x_hist = zeros(length(x0), length(t))
    x_hist[:, 1] .= x0

    error = zeros(length(t))
    error[1] = 0.

    for k = 1:length(t)-1
        x_hist[:, k+1], error[k+1] = backward_euler_newton(func, x_hist[:, k], h)
    end
    return t, x_hist, error
end

x0 = [0.1; 0]
#h_list = [0.01; 0.1; 0.3; 0.5; 1]
h_list = [1.0]
for h in h_list
    t_hist, x_hist, error = fixed_point(pendulum, x0, 10, h)
    label = "fixed_point step " * string(h)
    plot!(t_hist, x_hist[1, :], label=label)
    label = "fixed_point step " * string(h) * " error"
    plot!(t_hist, error, label=label)

    t_hist, x_hist, error = newton(pendulum, x0, 10, h)
    label = "newton step " * string(h)
    plot!(t_hist, x_hist[1, :], label=label)
    label = "newton step " * string(h) * " error"
    plot!(t_hist, error, label=label)
end

savefig("fixed_point_newton.png")
