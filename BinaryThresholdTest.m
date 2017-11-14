close all

LegoIn1 = imread('Lego10703-3.jpg');

LegoInGray = rgb2gray(LegoIn1);



%Minima = zeros(1,9);

for Level = 1:9
    
LegoInBin = im2bw(LegoIn1,Level*0.1);

BW = imfill(LegoInBin,'holes');

Test = imcomplement(xor(LegoInBin,BW));


Boxes = regionprops(Test,'Boundingbox');
Boxes = struct2table(Boxes);
Boxes = table2array(Boxes);

Minima(Level) = length(Boxes(:,1));

end

[M,I] = min(Minima(Minima>1));

LegoInBin = im2bw(LegoIn1,I*0.1);

BW = imfill(LegoInBin,'holes');

Test = imcomplement(xor(LegoInBin,BW));

Boxes = regionprops(Test,'Boundingbox');
Boxes = struct2table(Boxes);
Boxes = table2array(Boxes);

RectIllustr = insertShape(LegoInGray, 'Rectangle', Boxes(1,:), 'LineWidth', 5,'color','green');

for k = 1:length(Boxes(:,1))
    
RectIllustr = insertShape(RectIllustr, 'Rectangle', Boxes(k,:), 'LineWidth', 5,'color','green');
    
end

imshow(RectIllustr)


