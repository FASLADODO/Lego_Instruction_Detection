function [roi] = OCR_Crop(CropedImage)

InvCropedImage = imcomplement(CropedImage);

x_ones_vctr = ones(1,length(InvCropedImage(1,:)));

ImHeight = length(InvCropedImage(:,1));

Height4ocrText = 0;

Pixle = 5; % To avoide confiuson if there's a Pixel (noise) in the row

for y = ImHeight:-1:1
    
    if dot(x_ones_vctr,InvCropedImage(y,:))>=Pixle
        
        Height4ocrText = Height4ocrText + 1;
        
    end
    
    if (dot(x_ones_vctr,InvCropedImage(y,:))==0)&&(Height4ocrText>=Pixle)
        
        break
        
    end
    
end

roi = [0 y length(InvCropedImage(1,:))  ImHeight-y];

end

