function out = NDD(X, Y)
%NDD Finds the best fitted polynomial to a set of points.
%	X: First coordinate of points.
%	Y: Second coordinate of points.
%	Finds the best fitted polynomial to a set of points, usign Newton divided
%	differences method.
%	Brought to you with love, by Mohammad motiei (AKA, Shentoos)

    xx = sym('x');
    n=size(X,1);
	x=sym(ones(n, 1));
	for i=1:n
        x(i)= sym(sprintf( 'x%d' , i));
	end
    M=zeros(n,n+1);
    M(:,1)=X;
    M(:,2)=Y;
    a=ones(1,n);
    a(1)=M(1,2);
    for j=3:n+1
        for i=j-1:n
            M(i,j)=(M(i,j-1)-M(i-1,j-1))/(M(i,1)-M(i-j+2,1));
        end
        a(j-1)=M(j-1,j);
    end
    D=sym('1');
    syms k
    for i=2:n
        D(1,i)=D(1,i-1).*subs((xx-k),k,X(i-1));
    end
    out=simplify(sym(sum(D.*a)));
end
