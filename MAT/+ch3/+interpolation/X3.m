function [out1, out2, out3]=X3(X,Y)
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
    M(1,:)=X;           %S1 -> X
    M(2,:)=Y;           %S2 -> Y
    M(3,:)=X.*X;        %S3 -> X^2
    M(4,:)=M(3,:).*X;   %S4 -> X^3
    M(5,:)=M(4,:).*X;   %S5 -> x^4
    M(6,:)=M(5,:).*X;   %S6 -> X^5
    M(7,:)=M(6,:).*X;   %S7 -> X^6
    M(8,:)=X.*Y;        %S8 -> XY
    M(9,:)=X.*M(8,:);   %S9 -> X^2Y
    M(10,:)=X.*M(9,:);   %S10 -> X^3Y
    S=sum(M,2);
    Eq(1)=a(1).*(n+1)+a(2).*S(1)+a(3).*S(3)+a(4).*S(4)-S(2);
    Eq(2)=a(1).*S(1)+a(2).*S(3)+a(3).*S(4)+a(4).*S(5)-S(8);
    Eq(3)=a(1).*S(3)+a(2).*S(4)+a(3).*S(5)+a(4).*S(6)-S(9);
    Eq(4)=a(1).*S(4)+a(2).*S(5)+a(3).*S(6)+a(4).*S(7)-S(10);
    A=solve(Eq,a(1),a(2),a(3),a(4));
    out1=simplify(A.a1+A.a2*xx+A.a3*xx^2+A.a4*xx^3);
    out2=RMS(out1,X,Y);
    M(:,n+1)=S;
    out3=M;
end
