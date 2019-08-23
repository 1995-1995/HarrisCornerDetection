%%
% CLAB2 Task-1: Harris Corner Detector
% Hong Li (u6214478)
%
function Corners = harris(bw,NO)                           %bw is a image, NO is the number of corners users want
if nargin ==1                                                         % set a default NO of corners
    NO = 300;                                                   
end
bw = double(bw);
sigma = 2; thresh = 0.01;                                      % Parameters, add more if needed
% Derivative masks
dx = [-1 0 1;-1 0 1; -1 0 1];                                     %horizontal gradient kernel
dy = dx';                                                               % dx is the transpose matrix of dy
% compute x and y derivatives of image
Ix = conv2(bw,dx,'same');                                      %comput horizontal gradient
Iy = conv2(bw,dy,'same');                                      %comput vertical gradient
%Using gaussian filter to decrease the noise of images 
g = fspecial('gaussian',max(1,fix(3*sigma)*2+1),sigma);   %making a gaussian kerner                     
Ix2 = conv2(Ix.^2,g,'same');                                    % x and x
Iy2 = conv2(Iy.^2,g,'same');                                    % y and y
Ixy = conv2(Ix.*Iy,g,'same');                                    % x and y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task: Compute the Harris Cornerness                 
[height, width] = size(bw);                                      %find the number of rows and columns of image
R = zeros(height,width);                                         %make a matrix to store Rs
for i = 1:height                                                      %count R iteratively(row)
    for j = 1:width                                                   %count R iteratively(column)
        M = [Ix2(i,j) , Ixy(i,j) ;Ixy(i,j), Iy2(i,j)];              %M is a 2*2 Matrix equal to [Ix2,Ixy,Ixy,Iy2]
        K = det(M);                                                  %Find Det of M
        H = trace(M);                                                %Find Trace of M
        R(i,j) = K - thresh*H^2;                                  %Using harris algorithm to count R, R= det(M)-K*Trace(M)^2
        if (R(i,j)<0)                                                    %Find if R<0
            R(i,j) = 0;                                                  %Eliminate Edge values(R<0)
        end
    end
end
MaxR = max(max(R));                                           %find max values in R
FlatThresh = 0.001*MaxR;                                      %set a Thresh to find flat area
T = find(R<FlatThresh);                                         %find The location of flat area
for i = 1:size(T,1)                                                  %Assign value to R iteratively
    R(T(i)) =0;                                                        % Assign value of 0 to flat area
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task: Perform non-maximum suppression and             
%       thresholding, return the N corner points        
%       as an Nx2 matrix of x and y coordinates         
result = zeros(height,width);                                   % Use a matrix to store NMS result;
countNMS = 0;                                                     %count NMS values
for i = 2:height-1                                                   % Using a 3*3 window to slide all area in matrix R
    for j = 2:width-1                                                %Compare elements in R iteratively
        window = R(i-1:i+1,j-1:j+1);                            % Find R(i,j) and its 3*3 neibors
        Rmax = max(max(window));                          % Find Max values of R(i,j) and its neibors
        if R(i,j)==Rmax&&Rmax~=0                                             %Make sure if R(i,j) is the largest(valid) points
            result(i,j) = 1;                                            % if R(i,j) is a valid points assign value 1 to the corresponding place in result 
            countNMS=countNMS+1;                          % count the number of valid corners.
        end
    end
end
findGoodR = zeros(countNMS,1);
[locx, locy] = find(result==1);                                 %find NMS results location
for  i =1:countNMS                                               %Assign appropriate R value
    findGoodR(i) = R(locx(i),locy(i));                         %for the aim of choosing values according to NO
end
[findGoodR, ix] = sort(findGoodR,1);                       %Sort appropriate R values in ascend order, ix is the location before sorting
findGoodR = flipud(findGoodR);                              % flip vector(end to start, start to end), make it to descend order
ix = flipud(ix);                                                       %Make ix corresponding to flipped findGoodR 
if NO>countNMS                                                  %Make sure NO not exceed the total number of harris corner
    NO = countNMS;                                              % if NO exceed total number, output all harris corner
end
loc_x = zeros(NO,1);                                             %make container to store sorted row values 1:NO 
loc_y =  zeros(NO,1);                                            %make container to store sorted row values 1:NO
for i = 1:NO                                                          %Assign values to containers
    loc_y(i) = locy(ix(i));                                          %find row values from all the NMS location
    loc_x(i) = locx(ix(i));                                          %find column values from all the NMS location
end
Corners = zeros(NO,2);                                         %Make a container to store chosing values
Corners(:,1)=loc_y;                                               %Make a container to store chosing row values
Corners(:,2)=loc_x;                                               %%Make a container to store chosing column values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end













