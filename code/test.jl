function controller(t, x)
    println(t)
    println(x)
end

function loop(x0, controller, N)
    for k = 1:(N-1)
        controller()
    end
end

x0 = randn(6)
#loop(x0, (t, x)->controller(t, x), 10)

u_hover = [0.5*1*9.81; 0.5*1*9.81]
K = randn(2, 6)

function lqr_controller(t,x,K,xref)
    println("-------lqr controller--------")
    println(x)
    println(t)
    println(K)
    println(xref)
    return u_hover - K*(x-xref)
end

function closed_loop(x0,controller,N)
    xhist = zeros(length(x0),N)
    u0 = controller(1,x0)
    uhist = zeros(length(u0),N-1)
    uhist[:,1] .= u0
    xhist[:,1] .= x0
    for k = 1:(N-1)
        println("============closed loop===============")
        println(k)
        uk = controller(k,xhist[:,k])
    end
    return xhist, uhist
end

x_ref = [0.0; 1.0; 0; 0; 0; 0]
x0 = [10.0; 2.0; 0.0; 0; 0; 0]
xhist1, uhist1 = closed_loop(x0, (t,x)->lqr_controller(t,x,K,x_ref), 200);
