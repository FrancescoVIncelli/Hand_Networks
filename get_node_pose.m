%% Read Node Points from an image 
%%% Written by: Akshay Dhonthi, 2020

pts = readPoints('electrode_pos.JPG', 21);

function pts = readPoints(image, n)
    % @params
    %     image:            Input Image
    %         n:            Number of points to obtain
    %
    % @return
    %       pts:            2 x n array of pixel points

    imshow(image);     % Show Image
    ind = 0;             
    hold on;           % Show image unit the loop is complete
    
    while 1
        [xi, yi, ~] = ginput(1);      % Get one point
        ind = ind + 1;
        pts(1,ind) = xi;
        pts(2,ind) = yi;
        plot(xi, yi, 'go');           % Plot the point on image
        if ind == n
            break
        end
    end
    hold off
    if ind < size(pts,2)
        pts = pts(:, 1:ind);
    end

end