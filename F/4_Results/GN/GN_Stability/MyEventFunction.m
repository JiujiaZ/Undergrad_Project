function [value, isterminal, direction] = MyEventFunction(t, y,tstart)
%%The event function stops the intergration is VALUE == 0 and
%%ISTERMINAL==1
TimeOut = 1;
value = toc(tstart)<TimeOut;
isterminal = 1;
direction = 0;
end
