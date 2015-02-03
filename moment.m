function total = moment(img, p, q)

    [rows , cols] = size(img);
    
    temp = double(img);
    
    total = 0;
    
    for x = 1:cols
       for y = 1:rows
          
          step = (x^p) * (y^q) * temp(y,x);
          
          total = total + step;
           
       end
    end
end