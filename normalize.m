
digit = imread('testDigitInv.png');

H1 = 60;
W1 = 60;

[H2, W2] = size(digit);

alpha = sqrt(W2/W1);
beta = sqrt(H2/H1);

xc = moment(digit, 1, 0)/moment(digit, 0, 0);
yc = moment(digit, 0, 1)/moment(digit, 0, 0);

xcprime = W2/2;
ycprime = H2/2;

norm = zeros(H1, W1);

for x=1:W2
   for y=1:H2
      
       xprime = round(alpha * (x - xc) + xcprime);
       
       yprime = round(beta * (y -yc) + ycprime);
       
       if(xprime >= 1 && yprime >=1)
            norm(yprime,xprime) = digit(y,x);
       end
   end
end



imtool(norm)

