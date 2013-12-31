% Demo Code for ccspopDescriptorPointMatlab
%
% Written by Jonghyun Choi
% University of Maryland, College Park
%
% Created @ 2011.6.9
% Last updated @ 2012.1.4

param.start_r = 2;
param.max_r = 3;
param.step_r = 1;
param.trun_thr = 5;
param.auto_thr = 0.0;
param.stride_x = 2;
param.stride_y = 2;
param.colorsp = 'rgb';
param.sup_thr = 0.0;
param.ratio = 0;
param.patch_size = 1;
param.toffset = 0;
param.binFlag = 0;
param.ctx = 3;
param.cty = 1;

verbosity = 1;
im = imread( 'Desert.jpg' );
im = rgb2gray( im );
% d = ccspopDescriptorDenseMatlab( im, param, verbosity );

d = ccspopDescriptorDenseMatlab( im, param, verbosity );
