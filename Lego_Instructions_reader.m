close all


LegoIn1 = imread('Lego10703.jpg');
LegoIn2 = imread('Lego10703-2.jpg');
LegoIn3 = imread('Lego10703-3.jpg');

%% Gray scale image ---------------------------------------------

LegoInGray = rgb2gray(LegoIn3);

% LegoIn1 = imadjust(LegoInGray,[0.1 0.9],[]);

%% Binary image -------------------------------------------------

Level = 0.8;
LegoInBin = im2bw(LegoIn3,Level);

BW = imfill(LegoInBin,'holes');

Test = imcomplement(xor(LegoInBin,BW));

% figure()

% subplot(1,3,1)
% imshow(LegoInBin)
% title(['Binary Threshold = ',num2str(Level)])
% 
% subplot(1,3,2)
% imshow(BW)
% title('Binary hole fill')
% 
% subplot(1,3,3)
% imshow(Test)
% title('XOR')

%% Edge detection -----------------------------------------------

LegoInEdge = edge(Test,'canny');

%% Box Recognition ----------------------------------------------

% h = fspecial('motion', 50, 45);
% BoxColor = [190 214 226];
% 
% x_LegoIn = length(LegoIn(1,:,1));
% y_LegoIn = length(LegoIn(:,1,1));
% 
% 
% for x = 1:x_LegoIn
%     for y = 1:y_LegoInfran

%      
%        if (LegoIn(y_LegoIn,x_LegoIn,1)~=BoxColor(1) && ...
%           LegoIn(y_LegoIn,x_LegoIn,2)~=BoxColor(2)) && ...
%           LegoIn(y_LegoIn,x_LegoIn,3)~=BoxColor(3)
%           
%             LegoIn(y_LegoIn,x_LegoIn,1) = 255;
%             LegoIn(y_LegoIn,x_LegoIn,2) = 255;
%             LegoIn(y_LegoIn,x_LegoIn,3) = 255;
%        end
%        
%     end
% end

%% Hough transform for rectangle detection ----------------------

% [H,T,R] = hough(LegoInEdge);
% 
% imshow(H,[],'XData', T, 'YData', R, 'InitialMagnification','fit');
% xlabel('\theta'),ylabel('\rho');
% axis on, axis normal, hold on;
% 
% P = houghpeaks(H,5,'threshold',ceil(.3*max(H(:))));
% x = T(P(:,2));
% y = R(P(:,2));
% plot(x,y,'s','color','white');
% 
% %Find lines and plot them
% lines = houghlines(LegoInEdge,T,R,P,'FillGap',5,'MinLength',7);
% figure()
% imshow(LegoInGray) 
% hold on
% max_len = 0;
% 
% for k = 1:length(lines)
%     xy = [lines(k).point1; lines(k).point2];
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%     
%     %plot beginnings and ends of lines
%     plot(xy(1,1),xy(1,2),'LineWidth',2,'Color','yellow');
%     plot(xy(2,1),xy(2,2),'LineWidth',2,'Color','red');    
%     
%     %determine the endpoints of the longest line segment
%     len = norm(lines(k).point1 - lines(k).point2);
%     if len > max_len
%         max_len = len;
%         xy_long = xy;
%     end
% end

%% Corner detection --------------------------------------------

% Points = detectHarrisFeatures(LegoInGray);
% 
% imshow(LegoInGray)
% hold on
% plot(Points.Location(1),Points.Location(2),'x')

%% Region props box -------------------------------------------
% 
Boxes = regionprops(Test,'Boundingbox');
Boxes = struct2table(Boxes);
Boxes = table2array(Boxes);

RectIllustr = insertShape(LegoInGray, 'Rectangle', Boxes(1,:), 'LineWidth', 5,'color','green');


for k = 1:length(Boxes(:,1))
    
RectIllustr = insertShape(RectIllustr, 'Rectangle', Boxes(k,:), 'LineWidth', 5,'color','green');
    
end

figure()

subplot(2,2,4)
imshow(RectIllustr)
title('Rectangle detection')

subplot(2,2,1)
imshow(LegoInGray)
title('Gray scale')

subplot(2,2,2)
imshow(LegoInBin)
title('Binary')

subplot(2,2,3)
imshow(LegoInEdge)
title('Edge detection')

% figure()
% 
% 
% % Parameters for the croping process --------------------------
% cloumn = 2;
% ratio = 0.9;
% CoorOffset = [Boxes(cloumn,3)*(1-ratio)/2 Boxes(cloumn,4)*(1-ratio)/2 0 0];
% Coeff = [1 1 ratio ratio];
% 
% ImCrop1 = imcrop(LegoIn,Boxes(cloumn,:).*Coeff+CoorOffset);
% ImCrop2 = imcrop(LegoInGray,Boxes(cloumn,:).*Coeff+CoorOffset);
% ImCrop3 = imcrop(LegoInBin,Boxes(cloumn,:).*Coeff+CoorOffset);
% ImCrop4 = imcrop(LegoInEdge,Boxes(cloumn,:).*Coeff+CoorOffset);
% 
% roi = [260 130 50 40];          % Define one or more rectangular regions of interest within image
% 
% ocrRGB = ocr(ImCrop1);
% ocrGray = ocr(ImCrop2);
% ocrBin = ocr(ImCrop3);          % Best way to detect characters yet (binary image)
% ocrEdge = ocr(ImCrop4);
% 
% 
% subplot(2,2,1)
% imshow(ImCrop1)
% title('RGB')
% 
% subplot(2,2,2)
% imshow(ImCrop2)
% title('Gray scale')
% 
% subplot(2,2,3)
% imshow(ImCrop3)
% title('Binary')
% 
% subplot(2,2,4)
% imshow(ImCrop4)
% title('Edge detection')
% 
% 
% % Boxes of croped image --------------------------------------
% 
% Parts = regionprops(ImCrop3,'BoundingBox');
% Parts = struct2table(Parts);
% Parts = table2array(Parts);
% 
% RectIllustrCrop = insertShape(ImCrop2, 'Rectangle', Parts(1,:), 'LineWidth', 5,'color','green');
% 
% for k = 1:length(Parts(:,1))
%     
% RectIllustrCrop = insertShape(RectIllustrCrop, 'Rectangle', Parts(k,:), 'LineWidth', 5,'color','green');
%     
% end
% 
% figure()
% imshow(RectIllustrCrop)
% 
% ImCropChar = imcrop(ImCrop3,[ocrBin.WordBoundingBoxes(1) ocrBin.WordBoundingBoxes(2) length(ImCrop3(1,:))-ocrBin.WordBoundingBoxes(1) length(ImCrop3(:,1))-ocrBin.WordBoundingBoxes(2)]);
% 
% imshow(ImCropChar)
% 
% 
% n = length(Boxes(:,1));
% Space = zeros(n,1);
% 
% for n = 1:n
%     
%    Space(n) = Boxes(n,3)*Boxes(n,4);
%     
% end

%% Rectangle detection test ------------------------------------


% [H1 R1 Im1] = RegionPropsBoxCrop(LegoIn1);
% [H2 R2 Im2] = RegionPropsBoxCrop(LegoIn2);
% [H3 R3 Im3] = RegionPropsBoxCrop(LegoIn3);
% 
% subplot(2,3,1)
% imshow(Im1)
% subplot(2,3,4)
% histogram(H1,5)
% 
% subplot(2,3,2)
% imshow(Im2)
% subplot(2,3,5)
% histogram(H2,5)
% 
% subplot(2,3,3)
% imshow(Im3)
% subplot(2,3,6)
% histogram(H3,5)
% 
% 
% % Area of rectangles sorted --------------------------------------------
% 
% figure()
% subplot(1,3,1)
% plot(sort(H1))
% grid on
% 
% subplot(1,3,2)
% plot(sort(H2))
% grid on
% 
% subplot(1,3,3)
% plot(sort(H3))
% grid on