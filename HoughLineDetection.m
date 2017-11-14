+function [lines] = HoughLineDetection(I)
 +
 +EdgeIm = edge(im2bw(I),'canny');
 +
 +[H,T,R] = hough(EdgeIm);
 +
 +imshow(H,[],'XData', T, 'YData', R, 'InitialMagnification','fit');
 +xlabel('\theta'),ylabel('\rho');
 +axis on, axis normal, hold on;
 +
 +P = houghpeaks(H,5,'threshold',ceil(.3*max(H(:))));
 +x = T(P(:,2));
 +y = R(P(:,2));
 +plot(x,y,'s','color','white');
 +
 +%Find lines and plot them
 +lines = houghlines(EdgeIm,T,R,P,'FillGap',5,'MinLength',7);
 +figure()
 +imshow(I) 
 +hold on
 +max_len = 0;
 +
 +for k = 1:length(lines)
 +    xy = [lines(k).point1; lines(k).point2];
 +    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
 +    
 +    %plot beginnings and ends of lines
 +    plot(xy(1,1),xy(1,2),'LineWidth',2,'Color','yellow');
 +    plot(xy(2,1),xy(2,2),'LineWidth',2,'Color','red');    
 +    
 +    %determine the endpoints of the longest line segment
 +    len = norm(lines(k).point1 - lines(k).point2);
 +    if len > max_len
 +        max_len = len;
 +        xy_long = xy;
 +    end
 +end
 +end
 +