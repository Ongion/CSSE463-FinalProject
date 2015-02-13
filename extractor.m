img = imread('base_num.png');
img = 255-img;
img = img(:,:,1)+img(:,:,2)+img(:,:,3);
%imwrite(img,'wat2.png');
img = img>0;
%imwrite(img,'wat.png');
limg = bwlabel(img);
N = max(max(limg));
%imtool(limg)
for k = 1:N
    working = limg == k;
    [r,c] = find(working==1);
    %imtool(working)
    maxr = max(r)+2;
    minr = min(r)-2;
    maxc = max(c)+2;
    minc = min(c)-2;
    while true
        dr = maxr-minr;
        dc = maxc-minc;
        if mod(dr,2) == 1
            maxr = maxr - 1;
        end
        if mod(dc,2) == 1
            maxc = maxc - 1;
        end
        if dc > dr
            maxr = maxr + 1;
            minr = minr - 1;
        elseif dr > dc
            maxc = maxc + 1;
            minc = minc - 1;
        else
            break
        end
    end
    subimg = working(minr:maxr,minc:maxc);
    imwrite(subimg,strcat('output\',int2str(k),'.png'));
end