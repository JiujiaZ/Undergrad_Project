function dx = FModelode(t,x,newpars)
    dx = [newpars(1)*x(1)-newpars(2)*x(4)*x(1);
          newpars(3)*x(1)- newpars(4)*x(2);
          newpars(5)*x(1)- newpars(6)*x(3);
          newpars(7)*x(2)+newpars(8)*x(3)-newpars(2)*x(4)*x(1)-newpars(9)*x(4); 
          ];
end

