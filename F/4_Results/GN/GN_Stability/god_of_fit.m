function [res,x_hat,t_hat] = god_of_fit(newpars,t,y0,sim_data,latent_time)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Internal function which will be called by 'Gauss_newton'          %
    %  function calculate simulated data for Gauss Newton iteration i+1 %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Let previous iteration number denote as i for Gauss Newton      %
    %   the algorithm is aiming to output variables for Gauss Newton i+1%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Input:                                                          %
    %       newpars: Parameters at GN iteration i (previous)            %
    %       t, y0:  time span, initial condition for ode solver         %
    %       sim_data: fake data on y axis                               %
    %       latent_time: fake data latent data x axis for               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Output: (All for the next GN iteration)                         %
    %       res: residuals at each time point [73*4]                    %
    %       x_hat: simulated data using newpars  [73*4]                 %
    %       t_hat: time span for simulated data  [73*1]                 %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Others:                                                         %
    %       the ode solver is gated for 2 second                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tstart=tic; 
    TerminateFcn = @(t, y) MyEventFunction(t, y, tstart);
    opts = odeset('NonNegative',1,'Events',TerminateFcn);
    [t_hat,x_hat,te,ye,ie] = ode45(@(t,y)FModelode(t,y,newpars),t,y0,opts);
    
if (length(t_hat)==length(t))
    % fill unavliable time point experimental data for matrix algebra:
    for i =1:1:4
        if i==1 % Fungal species only has data at t=0;
            filled_data{i}=[sim_data{i};x_hat(2:end,i)];
        elseif i==2
            filled_data{i}=[sim_data{i}(1);x_hat(2:5,i);sim_data{i}(2:end)'];
        elseif i==3
            filled_data{i}=[sim_data{i}(1);x_hat(2:4,i);sim_data{i}(2);x_hat(6,i);sim_data{i}(3:end)'];
        else
            filled_data{i}=[sim_data{i}(1:4)';x_hat(5,i);sim_data{i}(5:end)'];  
        end
    end
    for i = 1:1:4
        y_hat(i,:) = (1/2)*(x_hat(:,i)-filled_data{i}).^2';
    end
    
else
    y_hat = 'NA'; % ode not solved within limited time
end
    
    res=y_hat; % residual function 73*4 or 'NA'
end
