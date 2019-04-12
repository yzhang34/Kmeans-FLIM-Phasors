function [xyt_stack, img_size1, img_size2, num_images] = fun_importTIFstack(filenames, pathname)
%FUN_IMPORTTIFSTACK Summary of this function goes here
%   Detailed explanation goes here
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 12, 2019
%   Copyright: University of Notre Dame, 2019
    
fullname = [pathname filenames];

info = imfinfo(fullname);

[img_size1, img_size2, img_size3]=size(imread(fullname, 1, 'Info', info));

depth = info(1).BitDepth;
if depth == 32
    img_type = 'single';
elseif depth == 64
    img_type = 'double';
else
    img_type=['uint' num2str(depth)];
end

num_images = numel(info);

xyt_stack=zeros([img_size1 img_size2 num_images img_size3], img_type);

for k = 1:num_images
    A = imread(fullname, k, 'Info', info);
    for ch=1:size(A,3)
        xyt_stack(:,:,k,ch)=A(:,:,ch);
    end
end

xyt_stack = double(xyt_stack);
    
    