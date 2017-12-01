function [RectSpecs] = RegionPropsBoxCrop(RGBImage)

%% Image Pre-Process ----------------------------------------------------
GrayScaleImage = rgb2gray(RGBImage);
RGBImage = imgaussfilt(RGBImage, 5);

%Minima = zeros(1,9);

% for Level = 1:9
%     
% BinaryImage = im2bw(RGBImage,Level*0.1);
% 
% BW = imfill(BinaryImage,'holes');
% 
% BinXOR = imcomplement(xor(BinaryImage,BW));
% 
% Boxes = regionprops(BinXOR,'Boundingbox');
% Boxes = struct2table(Boxes);
% Boxes = table2array(Boxes);
% 
% Minima(Level) = length(Boxes(:,1));
% 
% end

% [Minmum,Index] = min(Minima(Minima>1));

Threshold = 0.95

BinaryImage = im2bw(RGBImage,Threshold);
BW = imfill(BinaryImage,'holes');
BinXOR = imcomplement(xor(BinaryImage,BW));

Boxes = regionprops(BinXOR,'Boundingbox');
Boxes = struct2table(Boxes);
Boxes = table2array(Boxes);


imshow(BinXOR)
% -----------------------------------------------------------------------

% Delete Biggest box ----------------------------------------------------
% NOTE: The biggest box is the same size as the loaded picture itself  

ImageFrameSize = size(BinXOR);

   if (ImageFrameSize(2)==Boxes(1,3))&&(ImageFrameSize(1)==Boxes(1,4))
      
       Boxes(1,:) = [];
       
   end
   
% -----------------------------------------------------------------------

% i = length(Boxes(:,1));
% Space = zeros(i,1);
% 
% for i = 1:i
%     
%    Space(i) = Boxes(i,3)*Boxes(i,4);
%     
% end

EdgeImage = edge(BinXOR,'canny');

%% Rectangle detection -------------------------------------------------
% Boxes = regionprops(BinXOR,'Boundingbox');
% Boxes = struct2table(Boxes);
% Boxes = table2array(Boxes);


% RectIllustr = insertShape(GrayScaleImage, 'Rectangle', Boxes(1,:), 'LineWidth', 5,'color','green');
% 
% for k = 1:length(Boxes(:,1))
%     
% RectIllustr = insertShape(RectIllustr, 'Rectangle', Boxes(k,:), 'LineWidth', 5,'color','green');
%     
% end

%% Parameters for the croping process ----------------------------------

  column = 1;
  ratio = 0.9;                    % Crop the round edges of the compnent box
  Coeff = [1 1 ratio ratio];
  
  ContainsDigits = false(1);      % Check if croped image has digits
  ContainsX = false(1);           % Check if croped image has x

  i = length(Boxes(:,1));

  for column = 1:i

  CoorOffset = [Boxes(column,3)*(1-ratio)/2 Boxes(column,4)*(1-ratio)/2 0 0];
  ImCropBox = imcrop(BinXOR,Boxes(column,:).*Coeff+CoorOffset);
  
  Roi = OCR_Crop(ImCropBox);
  ImCropBox4OCR = imcrop(ImCropBox,Roi);
  
  ocrBinXOR = ocr(ImCropBox4OCR);    % Best way to detect characters yet (binary image)
  
  DigitPosition = isstrprop(ocrBinXOR.Text,'digit');
  
  for n = 1:length(ocrBinXOR.Text)
      
      if DigitPosition(n) == true
      
          ContainsDigits = true;
          break
      
      end
      
  end

  
  if (length(ocrBinXOR.Text) ~= 0)%&&((ContainsDigits)&&(length(strfind(ocrBinXOR.Text,'x')) ~= 0))
     
      RectSpecs(column,:)=Boxes(column,:).*Coeff+CoorOffset; % Coordinates, width and height of the box (borders are croped as well)
      ContainsDigits = false;
      disp(ocrBinXOR.Text)
  end
  
  column = column + 1;
  
  end


%% Boxes of croped image -----------------------------------------------

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
% % ImCropChar = imcrop(ImCrop3,[ocrBin.WordBoundingBoxes(1) ocrBin.WordBoundingBoxes(2) length(ImCrop3(1,:))-ocrBin.WordBoundingBoxes(1) length(ImCrop3(:,1))-ocrBin.WordBoundingBoxes(2)]);
% % 
% % figure()
% % imshow(ImCropChar)
% 



end

