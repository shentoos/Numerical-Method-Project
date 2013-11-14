function [out1, out2, out3]=LGN(X,Y)
	import ch3.interpolation.*;
	X = X.';
	Y = Y.';
	
    n=size(X,2);
    xx = sym('x');
    [ff, rms, J, A]=X1(log(X).',Y.');
    if(isempty(A))
        out1=[];
    else
        out1=simplify(A.a1*log(xx)+A.a2);
    end
    out2=RMS(out1,X,Y);
    MX(1,:)=X;
    MX(1,n+1)=sum(X);
    MY(1,:)=Y;
    MY(1,n+1)=sum(Y);
    out3(1,:)=MX;
    out3(2,:)=J(1,:);
    out3(3,:)=MY;
    out3(4,:)=J(2,:);
    out3(5,:)=J(3,:);
    out3(6,:)=J(4,:);
end
