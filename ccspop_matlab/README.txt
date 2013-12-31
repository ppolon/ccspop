
Circular Center Symmetric-Pairs of Pixel feature descriptor for Matlab
Ver 0.1

(C) Jonghyun Choi
UMIACS
University of Maryland, College Park


License
=======

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:



CONTENTS
========
1. CCS-POP Dense
2. CCS-POP Point


CCS-POP Dense
=============

Extracting CCS-POP features on the points in the images with given pixel stride


USAGE
=====
 Usage: d = ccspopDescriptorDenseMatlab( <image[double type]>, <param>, verbosityFlag );
 <filename>: filename
 <param>: parameter
 verbosityFlag: 1: verbose, 0: quite

Parameter structure:
    <param>.start_r: starting radius
    <param>.max_r: maximum (ending) radius
    <param>.step_r: step
    <param>.trun_thr: truncation threshold
    <param>.auto_thr: computing the threshold by the statistics of the image (sigma factor)
    <param>.stride_x: stride of x
    <param>.stride_y: stride of y
    <param>.colorsp: color space name (rgb, maxrgb)
    <param>.sup_thr: suppression threshold
    <param>.ratio: ratio mode enabled (>0)
    <param>.patch_size: patch size (enabled when this value is >0)
    <param>.binFlag: binary mode flag (for LBP comparison)



CCS-POP Point
=============

Extracting CCS-POP features on the specified points

USAGE
=====
 Usage: d = ccspopDescriptorPointMatlab( <image[double type]>, <param>, verbosityFlag );
 <filename>: filename
 <param>: parameter
 verbosityFlag: 1: verbose, 0: quite

Parameter structure:
    <param>.start_r: starting radius
    <param>.max_r: maximum (ending) radius
    <param>.step_r: step
    <param>.trun_thr: truncation threshold
    <param>.auto_thr: computing the threshold by the statistics of the image (sigma factor)
    <param>.colorsp: color space name (rgb, maxrgb)
    <param>.sup_thr: suppression threshold
    <param>.ratio: ratio mode enabled (>0)
    <param>.patch_size: patch size (enabled when this value is >0)
    <param>.binFlag: binary mode flag (for LBP comparison)
    <param>.ctx: center point location [x-coordinate]
    <param>.cty: center point location [y-coordinate]



Citation Information
====================

Please cite it as

Jonghyun Choi, William Robson Schwartz, Huimin Guo and Larry S. Davis, "A Complementary Local Feature Descriptor for Face Identification", IEEE Workshops on the Applications of Computer Vision, 2012



CONTACT
=======

If you have a question or a suggestion, please contact me via the following email:

jhchoi@umd.edu
