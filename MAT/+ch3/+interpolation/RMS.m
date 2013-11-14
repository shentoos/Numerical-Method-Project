function out=RMS(F,X,Y)
    if(isempty(F))
        out=[];
    else
        xx = sym('x');
        n = size(X,2);
        NY=subs(F,xx,X);
        out=sqrt(1./n.*sum((Y-NY).^2));
    end
end