function Boxes = Segmentation(legoPage)


%% Image enhancement, filtering, edge detection

legoPageGrey = rgb2gray(legoPage);
streched_truecolor = decorrstretch(legoPage, 'Tol', 0.01);

legoFiltered = imgaussfilt(legoPageGrey, 15);

% legoEdge = edge(legoPageGrey, 'canny');
% 
% figure;
% imshow(legoEdge);
% title('legoEdge');


%% Lego image: Threashold, Complement Image and Fill in holes

levelr = 250/255;
BW = im2bw(legoFiltered, levelr);
legoComplement = imcomplement(BW);
legoFilled = imfill(legoComplement, 'holes');


%% Lego image: Extract features

legoRegions = regionprops(legoFilled, 'BoundingBox');
[labeled, numObjects] = bwlabel(legoFilled, 4);


%% Lego image: show bounding boxes

% hold on;
% for idx = 1 : length(legoRegions)
%         h = rectangle('Position',legoRegions(idx).BoundingBox,'LineWidth',2);
%         set(h,'EdgeColor',[.75 0 0]);
%         hold on;
% end
% title(['There are ', num2str(numObjects), ' objects in the image!']);
% hold off;

Boxes = legoRegions;

%% Component box
% 
% xIndex = round(legoRegions(1).BoundingBox(1)) : round(legoRegions(1).BoundingBox(1)) + ...
%     legoRegions(1).BoundingBox(3);
% yIndex = round(legoRegions(1).BoundingBox(2)) : round(legoRegions(1).BoundingBox(2)) + ...
%     legoRegions(1).BoundingBox(4);
% legoComponentBox = legoFiltered(yIndex, xIndex);
% 
% 
% %% Component box: Threashold, Complement Image
% 
% levelr = 185/255;
% BW = im2bw(legoComponentBox, levelr);
% legoComplement = imcomplement(BW);
% % legoFilled = imfill(legoComplement, 'holes');
% 
% % figure, imshow(legoComplement);
% 
% 
% %% Component box: Extract features
% 
% legoComponentRegions = regionprops(legoComplement, 'BoundingBox');
% [labeled, numObjects] = bwlabel(legoComplement, 4);
% 
% %% Construction box
% 
% xIndex = round(legoRegions(5).BoundingBox(1)) : round(legoRegions(5).BoundingBox(1)) + ...
%     legoRegions(5).BoundingBox(3);
% yIndex = round(legoRegions(5).BoundingBox(2)) : round(legoRegions(5).BoundingBox(2)) + ...
%     legoRegions(5).BoundingBox(4);
% legoConstructionBox = legoFiltered(yIndex, xIndex);
% 
% 
% %% Construction box: Threashold, Complement Image
% 
% levelr = 230/255;
% BW = im2bw(legoConstructionBox, levelr);
% legoComplement = imcomplement(BW);
% % legoFilled = imfill(legoComplement, 'holes');
% 
% % figure, imshow(legoComplement);
% 
% 
% %% Construction box: Extract features
% 
% legoComponentRegions = regionprops(legoComplement, 'BoundingBox');
% [labeled, numObjects] = bwlabel(legoComplement, 4);



end

