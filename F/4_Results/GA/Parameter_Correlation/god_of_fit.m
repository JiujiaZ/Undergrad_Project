function y = god_of_fit(newpars,t,y0,x,Tcell)
    tstart=tic;
    TerminateFcn = @(t, y) MyEventFunction(t, y, tstart);
    opts = odeset('NonNegative',1,'Events',TerminateFcn);
    [t,x_hat,te,ye,ie] = ode45(@(t,y)FModelode(t,y,newpars),t,y0,opts);
    if length(t)==73
        for i = 1:1:4
            y_hat(i,1) = (sum(sum((x_hat(Tcell{1,i}+1,i)'-x{1,i}).^2)))/abs(mean(x{1,i}));
        end
        y=sum(y_hat);
    else 
        y=3E5; %penalise parameters that takes longer than 1s to solve
    end
end
