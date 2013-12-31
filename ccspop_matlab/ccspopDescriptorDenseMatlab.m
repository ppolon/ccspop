function feat = ccspopDescriptorDenseMatlab( im, param, verbosity )
% CCS-POP Descriptor
% Ver. 0.1
%
% Written by Jonghyun Choi
% UMIACS, University of Maryland, College Park
%
% Last updated @ 2012.1.4
%
% CCS-POP feature descriptor
%  Usage: d = ccspopDescriptorDenseMatlab( <image[double type]>, <param>, verbosityFlag );
%  <filename>: filename
%  <param>: parameter
%  verbosityFlag: 1: verbose, 0: quite
% Parameter structure:
%     <param>.start_r: starting radius
%     <param>.max_r: maximum (ending) radius
%     <param>.step_r: step 
%     <param>.trun_thr: truncation threshold
%     <param>.auto_thr: computing the threshold by the statistics of the image (sigma factor)
%     <param>.sup_thr: suppression threshold
%     <param>.stride_x: stride of x\n\
%     <param>.stride_y: stride of y\n\
%     <param>.patch_size: patch size (enabled when this value is >0)
%     <param>.binFlag: binary mode flag (for LBP comparison)
%     <param>.ctx: center point location [x-coordinate]
%     <param>.cty: center point location [y-coordinate]

start_r = param.start_r;
step_r = param.step_r;
max_r = param.max_r;
thr = param.trun_thr;
stride_x = param.stride_x;
stride_y = param.stride_y;

mean_val = 0.0;
offset_val = 255.0;


if size( im, 3 ) > 1
    im = rgb2gray( im );
end

ww = size( im, 2 );
hh = size( im, 1 );

cnt = 1;
feat = zeros( (hh/stride_y) * (ww/stride_x) * (max_r - start_r + 1) * 4, 1 ); % *2 is 

for yy = 1:stride_y:hh
    fprintf( 1, 'y:%d(out of %d)\n', yy, hh );
    for xx = 1:stride_x:ww
        for cur_r = start_r:step_r:max_r
            [ feat, cnt ] = computeCCSPOP( im, feat, cnt, xx, yy, cur_r );
        end
    end
end

cnt = cnt - 1;
feat = feat( 1:cnt, 1 );

% thresholding (T_t)
for i = 1:cnt
    val = feat( i );

    if( (val - mean_val) > thr )
        val = mean_val + thr; % truncate the pixel value difference by the threshold
    end
    if( (val - mean_val) < -thr )
        val = mean_val - thr;
    end
    feat( i ) = val + offset_val; % giving offset to prevent negative values (no reason)
end


%----------
function tf = isInImage( xx, yy, ww, hh ) 
if( ( xx > 0 && xx <= ww ) && ( yy > 0 ) && ( yy <= hh ) )
    tf = (1);
else
	tf = (0);
end



%----------
function [ ret_feat, cnt ] = computeCCSPOP( im, ret_feat, cnt, ctx, cty, rr )

ww = size( im, 2 );
hh = size( im, 1 );

dv = sqrt(2.0); % diagonal value

ctx = ctx - 1;
cty = cty - 1;

pts(1,1) = fix( ctx - rr );       pts(1,2) = fix( cty );			% left most
pts(2,1) = fix( ctx - rr/dv);     pts(2,2) = fix( cty - rr/dv ); % left upper
pts(3,1) = fix( ctx );            pts(3,2) = fix( cty - rr );    % center upper
pts(4,1) = fix( ctx + rr/dv );    pts(4,2) = fix( cty - rr/dv ); % right upper
pts(5,1) = fix( ctx + rr );       pts(5,2) = fix( cty );         % right most
pts(6,1) = fix( ctx + rr/dv );    pts(6,2) = fix( cty + rr/dv ); % right down
pts(7,1) = fix( ctx );            pts(7,2) = fix( cty + rr );    % center down
pts(8,1) = fix( ctx - rr/dv );    pts(8,2) = fix( cty + rr/dv ); % left down

pts = pts + 1;

hnp = size(pts,1) / 2; % half of number points
alldiff = 0.0;
pvdiff = 0.0;

cval = im( cty+1, ctx+1 ); % (unsigned char) img->imageData[ (cty * ws) + ctx ];

for i = 1:hnp
%     fprintf( 1, '%d %d\n', pts(i,1), pts(i,2) );
    val1 = 0;
%     if( isInImage( pts(i,1), pts(i,2), ww, hh ) )
    if( pts(i,1) > 0 && pts(i,1) <= ww ) && ( pts(i,2) > 0 && pts(i,2) <= hh )
        %val1 = (unsigned char) img->imageData[ (pts.at(i).y * ws) + pts.at(i).x ];
        val1 = im( pts(i,2), pts(i,1) );
    else
        val1 = cval;
    end
    
%     fprintf( 1, '%d %d\n', pts(i+hnp,1), pts(i+hnp,2) );
    val2 = 0;
%     if( isInImage( pts(i+hnp,1), pts(i+hnp,2), ww, hh ) )
    if( pts(i+hnp,1) > 0 && pts(i+hnp,1) <= ww ) && ( pts(i+hnp,2) > 0 && pts(i+hnp,2) <= hh )
        %val2 = (unsigned char) img->imageData[ (pts.at(i+hnp).y * ws) + pts.at(i+hnp).x ];
        val2 = im( pts(i+hnp,2), pts(i+hnp,1) );
    else
        val2 = cval;
    end
    
%     fprintf(1,'val1: %d, val2:%d\n', val1, val2);
    pvdiff = double(val1) - double(val2);
    
    ret_feat( cnt ) = pvdiff;
    cnt = cnt + 1;
end