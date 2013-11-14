function [out1, out2, out3, out4]=X1(X,Y)
	import ch3.interpolation.*;
	X = X.';
	Y = Y.';
	
    xx = sym('x');
    n=size(X,2);
    for i=1:4
        a(i)= sym(sprintf( 'a%d' , i));
    end
    for i=1:n
        x(i)= sym(sprintf( 'x%d' , i));
    end
    M=zeros(4,n);
    M(1,:)=X;
    M(2,:)=Y;
    M(3,:)=X.*X;
    M(4,:)=X.*Y;
    S=sum(M,2);
    Eq(1)=a(1).*(n+1)+a(2).*S(1)-S(2);
    Eq(2)=a(1).*S(1)+a(2).*S(3)-S(4);
    A=solve(Eq,a(1),a(2))
    if(isempty(A))
        out1=[];
    else
        out1=simplify(A.a1+A.a2*xx);
    end
    out2=RMS(out1,X,Y);
    M(:,n+1)=S;
    out3=M;
    out4=A;
end
