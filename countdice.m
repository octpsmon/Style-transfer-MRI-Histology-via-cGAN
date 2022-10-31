% % similarity = dice(BW, BW_groundTruth);

clear all;
clc;

F = imread('D:\to_register\to_register\downsample_15\Sub01_1_GFAP_downs_15.tif'); %fixed_dir
M = imread('D:\MATLAB2021a\bin\movingRegisteredAffineWithIC_1.tif'); %movinf_dir
% figure
% imshow(M);
F=im2gray(F);
F=im2bw(F,0.9);
F=imcomplement(F);
% figure
% imshow(F)
M=im2bw(M, 0.1);
% figure
% imshow(M);
% figure
% imshow(F);
F=im2double(F);
M=im2double(M);
similarity=dice(F, M);
disp(similarity);
