close all


LegoIn1 = imread('Lego10703-1.jpg');
LegoIn2 = imread('Lego10703-2.jpg');
LegoIn3 = imread('Lego10703-3.jpg');

tic;
Test = RegionPropsBoxCrop(LegoIn2);
toc;

RectIllustrCrop = insertShape(LegoIn2, 'Rectangle', Test(1,:), 'LineWidth', 5,'color','green');

for k = 1:length(Test(:,1))
    
RectIllustrCrop = insertShape(RectIllustrCrop, 'Rectangle', Test(k,:), 'LineWidth', 5,'color','green');
    
end

figure()
imshow(RectIllustrCrop)