function [out1, out2, out3] = CF(X,Y)
	import ch3.interpolation.*;
    
    [f(1), rms(1), A]=X1(X,Y);
    [f(2), rms(2), B]=X2(X,Y);
    [f(3), rms(3), T]=X3(X,Y);
    [f(4), rms(4), D]=EXPO(X,Y);
    [f(5), rms(5), E]=LGN(X,Y);
    [f(6), rms(6), G]=DV(X,Y);
    [f(7), rms(7), H]=DVT(X,Y);
    [C, I]=min(rms);
    out1=f(I);
    out2=C;
    switch I
        case 1
            out3=A;
        case 2
            out3=B;
        case 3
            out3=T;
        case 4
            out3=D;
        case 5
            out3=E;
        case 6
            out3=G;
        case 7
            out3=H;
    end
end
