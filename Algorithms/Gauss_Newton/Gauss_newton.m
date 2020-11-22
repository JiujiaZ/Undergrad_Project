function [theta,Duration,Iteration,Residual,Termination,Inter_res] = Gauss_newton(...
    t,y0,x,Tcell,newpars,max_time,max_iter,max_res) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gauss Newton Iteration which will call function 'god_of_fit' for updating
% variables at each iteration i+1                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Input:                                                                %
%       for internal function god_of_fit:                                 %
%           newpars: Parameters at GN iteration i (previous)              %
%           t, y0:  time span, initial condition for ode solver           %
%           x: fake data on y axis                                        %
%           Tcell: fake data on x aixs corresponding to sim_data          %
%       for current function Gauss_newton:                                %
%           Stopping creterion: max_time,max_iter,max_res                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Output:                                                               %
%       theta: parameters                                                 %
%       Duration: Run time of the GN iteration                            %
%       Iteration: the number of iteration when GN terminated             %
%       Residual: MSE for each species when DN terminated                 %
%       Termination: reasons that algorithm terminated                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% initialisation:
    res=300*ones(4,73);
    GN_time=tic;
    i=0; %itreration

    
% GN iteration, will terminate if any of the three creterion is met:
    while (sum(sum(res))<=max_res) | (toc(GN_time)<=max_time) | (i<=max_iter)
        i=i+1;
        % residual, simulated data using newpars at each iteration
        [res,x_hat,t_hat]=god_of_fit(newpars,t,y0,x,Tcell);
        Inter_res(1,i)=sum(sum(res));
       
        % Jacobian evaluated at each iteration (newpars) using simulated data 
        J = zeros(length(t_hat),length(newpars)); % [73,9] [data points numbers, parameter number]
    
        J(:,1) = x_hat(:,1);
        J(:,2) = -2*x_hat(:,1).*x_hat(:,4);
        J(:,3) = x_hat(:,1);
        J(:,4) = -x_hat(:,2);
        J(:,5) = x_hat(:,1);
        J(:,6) = -x_hat(:,3);
        J(:,7) = x_hat(:,2);
        J(:,8) = x_hat(:,3);
        J(:,9) = -x_hat(:,4);

        if ischar(res)| (sum(sum(isnan(J)))>0)
            
             display('Ode is in unsolvable region Or Jacobian is non invertable')
             Duration=toc(GN_time);
             Iteration = i;  
             theta=newpars;
             Residual=res;
             Termination.below_max_res=0;
             Termination.exceed_max_time=0;
             Termination.exceed_max_iter=0;
             return;
        end     
     
        % next descending step 
        delta=pinv(J)*sum(res,1)';
        % new parameters
        newpars=newpars-delta';
    end
    
% output termination reasons    
    if (sum(sum(res))<max_res) 
        Termination.below_max_res=1;
    else 
        Termination.below_max_res=0;
    end
    
    if (toc(GN_time)>max_time) 
        Termination.exceed_max_time=1;
    else 
        Termination.exceed_max_time=0;
    end
    
    if (toc(GN_time)>max_time) 
        Termination.exceed_max_time=1;
    else 
        Termination.exceed_max_time=0;
    end
    
    if (i>max_iter) 
        Termination.exceed_max_iter=1;
    else 
        Termination.exceed_max_iter=0;
    end
    
% numerical outputs:    
    Duration=toc(GN_time);
    Iteration = i;  
    theta=newpars;
    Residual=res;
    
end