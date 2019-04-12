function [xyt_stack, img_size1, img_size2, num_images] = fun_importCSVstack(filenames, pathname)
%FUN_IMPORTCSVSTACK Summary of this function goes here
%   Detailed explanation goes here
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 12, 2019
%   Copyright: University of Notre Dame, 2019

if iscell(filenames)
    num_images = length(filenames);
    first_image = flipud(csvread([pathname, char(filenames(1))]));
    [img_size1, img_size2] = size(first_image);
    xyt_stack=zeros(img_size1, img_size2, num_images);

    for k = 1:num_images
        data_name = char(filenames(k));
        xyt_stack(:,:,k) = flipud(csvread([pathname,data_name]));
    end
else
    num_images = 1;
    xyt_stack = flipud(csvread([pathname,filenames]));
    [img_size1, img_size2] = size(xyt_stack);
end