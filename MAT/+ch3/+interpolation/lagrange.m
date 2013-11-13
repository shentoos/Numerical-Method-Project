function out = lagrange(X, Y)
%LAGRANGE Finds the best fitted polynomial to a set of points.
%	X: First coordinate of points.
%	Y: Second coordinate of points.
%	Brought to you with love, by Mohammad motiei (AKA, Shentoos)
%	Finds the best fitted polynomial to a set of points, usign Lagrange method.

    xx = sym('x');
    n=size(X,1);
	x = sym(ones(n, 1));
	for i=1:n
        x(i)= sym(sprintf( 'x%d' , i));
	end

    syms k
    L=ones(n,1);
	for i=1:n
        L=L*(xx-x(i));
        M=1;
        for j=1:n
            if i~=j
                M=M*(x(i)-x(j));
            end
        end
        L(i)=L(i)/(M*(xx-x(i)));
	end
    L=subs(L,x,X);
    out=simplify(sym(sum(Y.*L)));
end
