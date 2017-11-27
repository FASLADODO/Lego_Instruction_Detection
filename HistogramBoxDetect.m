close all


LegoIn = imread('Lego10703-1.jpg');

tic;
Test = RegionPropsBoxCrop(LegoIn);
toc;

RectIllustrCrop = insertShape(LegoIn, 'Rectangle', Test(1,:), 'LineWidth', 5,'color','green');

for k = 1:length(Test(:,1))
    
RectIllustrCrop = insertShape(RectIllustrCrop, 'Rectangle', Test(k,:), 'LineWidth', 5,'color','green');
    
end

figure()
imshow(RectIllustrCrop)


