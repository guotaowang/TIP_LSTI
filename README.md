The source code of our manuscript submitted to IEEE Transactions on Image Processing:  
# Improving Robust Video Saliency Detection based on Long-term Spatial-Temporal Information   

Chenglizhao Chen#, Guotao Wang#, Xiaowei Zhang*, Chong Peng*, Hong Qin   

------------------------------------------------------------------------------------------------------------------------
# Prerequisites:
1.Visual Studio 2015 x64 enviroument  
2.CUDA v8.0, cudnn v7.0  
3.Matlab 2016b  
4.GPU: NVIDIA GeForce GTX 1080 Ti  
5.Video sequences should be added to the '.\sequences' directory accordingly.  

------------------------------------------------------------------------------------------------------------------------
# Default path:   
1. The default installation path of CUDA is: "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\lib\x64\",  
2. The default installation path of VisualStudio is: "C:\Program Files\Microsoft Visual Studio 14.0\VC\bin".  
3. The readers should change the CUDA path and VisualStudio path in '.\cuda\compile.m' file accordingly.  
4. The matlab path of '.\cuda\*.cu' files should also be changed accordingly  
(e.g., the default matlab path is "C:\Program Files\MATLAB\R2016b\extern\include\mex.h").   

-----------------------------------------------------------------------------------------------------------------------
# Usage:   
a. Please first compline Caffe of Faster Rcnn and Faste Rcnn for Matlab.  
b. Please download the Model of LSTI.  
d. Please put the model LSTI under folder \caffe\model\.  
e. Run TestSaliency.m  
f. Results can be found in \Resutls\  

-----------------------------------------------------------------------------------------------------------------------
# Downloads:  
Results on Davis, DS, SegTrack and UCF datasets from  
baidu cloud: https://pan.baidu.com/s/13_E3jPnDD-kbTqJfqOabhg.  

# Notice:  
a. Because we have changed the original code of Faster RCNN and Faste RCNN, please replace the relevant files for run.  
b. If you make changes to the accelerated code (CUDA), please recompile the file of CUDA/*.cu .  

-------------------------------------------------------------------------------------------------------------------------

