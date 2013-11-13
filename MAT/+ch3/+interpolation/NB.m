function out = NB(X, Y)
%NB Finds the best fitted polynomial to a set of points.
%	X: First coordinate of points.
%	Y: Second coordinate of points.
%	Finds the best fitted polynomial to a set of points, usign Newton backwards
%	differences method.
%	Brought to you with love, by Mohammad motiei (AKA, Shentoos)

    xx = sym('x');
    n=size(X,1);
	x=sym(ones(n, 1));
    for i=1:n
        x(i)= sym(sprintf( 'x%d' , i));
    end
    
    h=X(2)-X(1);
    rvalue=(xx-X(n))/h;
    R=sym('1');
    syms k r
    for i=2:n
        R(1,i)=R(1,i-1).*subs((r+k),k,(i-2));
    end
    fac=factorial(0:n-1);
    R=R./fac;
    M=zeros(n,n+1);
    M(:,1)=X;
    M(:,2)=Y;
    a=ones(1,n);
    a(1)=M(n,2);
    for j=3:n+1
        for i=j-1:n
            M(i,j)=(M(i,j-1)-M(i-1,j-1));
        end
        a(j-1)=M(n,j);
    end
    out=simplify(sym(subs(sum(R.*a),r,rvalue)));
end
