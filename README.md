The source code of our manuscript submitted to IEEE Transactions on Image Processing:  
# Improving Robust Video Saliency Detection based on Long-term Spatial-Temporal Information   

Chenglizhao Chen#, Guotao Wang#, Xiaowei Zhang, Chong Peng, Hong Qin   

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
Results on Davis, DS, SegTrack, UCF, Visal, FBMS, UVSD and MCL datasets of our method and the **trained model** are availabled from  
baidu cloud: https://pan.baidu.com/s/10_fUPP78_MTioH_TDagWgQ, extraction: razp.  

Results of our method on VOS, DAVSOD(DAVSOD-Difficult-20, DAVSOD-Normal-25, DAVSOD-Easy-35) are availabled from
baidu cloud: https://pan.baidu.com/s/1aQoV045M8eLA-TmtEuDGhA, extraction: jnwl.  

All results on Visal and FBMS datasets of our method are availabled from  
baidu cloud: https://pan.baidu.com/s/1-bd0_mqiRUu7aBjuFYnb7w, extraction: 6fn3.  

# Notice:  
a. Because we have changed the original code of Faste RCNN and Faster RCNN, please replace the relevant files for running.  
b. If you make changes to the accelerated code (CUDA), please recompile the file of CUDA/*.cu .  

-------------------------------------------------------------------------------------------------------------------------

