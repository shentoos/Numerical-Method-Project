function [out1, out2, out3]=X1(X,Y)
	import ch3.interpolation.*
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
    M(1,:)=X;%s1 -> X
    M(2,:)=Y;%s2 -> Y
    M(3,:)=X.*X;%s3 -> X^2
    M(4,:)=M(3,:).*X;%S4 -> X^3
    M(5,:)=M(4,:).*X;%S5 -> x^4
    M(6,:)=X.*Y;%s6 -> XY
    M(7,:)=X.*M(6,:);%s7 -> X^2Y
    S=sum(M,2);
    disp(S);
    Eq(1)=a(1).*(n+1)+a(2).*S(1)+a(3).*S(3)-S(2);
    Eq(2)=a(1).*S(1)+a(2).*S(3)+a(3).*S(4)-S(6);
    Eq(3)=a(1).*S(3)+a(2).*S(4)+a(3).*S(5)-S(7);
    A=solve(Eq,a(1),a(2),a(3));
    out1=simplify(A.a1+A.a2*xx+A.a3*xx*xx);
    out2=RMS(out1,X,Y);
    M(:,n+1)=S;
    out3=M;
end
