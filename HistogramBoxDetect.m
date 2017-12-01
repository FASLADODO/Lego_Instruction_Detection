close all
clear 

LegoIn = imread(fullfile('Lego-Project','Scripts','Images','Lego_2.jpg'));
tic;
Test = Segmentation(LegoIn);
toc;
close all
% tic;
% Test = RegionPropsBoxCrop(LegoIn);
% toc;
% 
%RectIllustrCrop = insertShape(LegoIn, 'Rectangle', Test(1,:), 'LineWidth', 5,'color','green');

figure(); imshow(LegoIn)
n = size(Test);
n = n(1);

for k = 1:n
    
RectIllustrCrop = rectangle('Position',Test(k).BoundingBox,'LineWidth',2);
 set(RectIllustrCrop,'EdgeColor',[.75 0 0]);   
hold on
end





