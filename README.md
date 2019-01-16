The source code of our manuscript submitted to IEEE Transactions on Image Processing: 
# Improving Robust Video Saliency Detection based on Long-term Spatial-Temporal Information  

Chenglizhao Chen1, Guotao Wang1, Xiaowei Zhang*, Chong Peng*, Hong Qin  

------------------------------------------------------------------------------------------------------------------------
# Prerequisites:
1.Visual Studio 2015 x64 enviroument  
2.CUDA v8.0, cudnn v7.0  
3.Matlab 2016b  
4.GPU: NVIDIA GeForce GTX 1080 Ti  
5.Video sequences should be added to the '.\sequences' directory accordingly.  

-----------------------------------------------------------------------------------------------------------------------
# Usage:  
a. Please first compline Caffe of Faster Rcnn and Faste Rcnn for Matlab.  
b. Please download the Model of LSTI and other results on Davis, DS, SegTrack and UCF datasets from  
baidu cloud: https://pan.baidu.com/s/13_E3jPnDD-kbTqJfqOabhg.  
d. Please put the model LSTI under folder \caffe\model\.  
e. Run TestSaliency.m  
f. Results can be found in \Resutls\  

# Notice:
a. Because we have changed the original code of Faster RCNN and Faste RCNN, please replace the relevant files for run.  
b. If you make changes to the accelerated code (CUDA), please recompile the file of CUDA/*.cu .  

-------------------------------------------------------------------------------------------------------------------------

