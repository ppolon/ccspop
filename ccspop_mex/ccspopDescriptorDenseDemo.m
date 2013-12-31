% Test for seeing CCS-POP C code is compiled or not
%
% Jonghyun Choi @ ARL
%
% Created @ 2011.6.9
% Last updated @ 2011.6.28

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

verbosity = 1;
im = double( imread( 'Desert.jpg' ) );
d = ccspopDescriptorDense( im, param, verbosity );
