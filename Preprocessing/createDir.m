ResultsDataPath = ['.\results\' mode '\'];
SiftFlowPath = ['.\results\' mode '\SiftFlowCompute\'];
AveragePath = ['.\results\' mode '\Average\'];
SuperPixelStructurePath = ['.\results\' mode '\SuperPixelStructures\'];
OpticalFlowPath = ['.\results\' mode '\OpticalFlowResults\'];
 AllScaleFeatPath = ['.\results\' mode '\AllScaleFeat\'];
MotionSaliencyPath = ['.\results\' mode '\MotionSaliencyResults\'];
RawColorSaliencyPath = ['.\results\' mode '\RawColorSaliencyResults\'];
SmoothedMotionSaliencyPath = ['.\results\' mode '\SmoothedMotionSaliencyResults\'];
ImageRectPath = ['.\results\' mode '\ImageRect\'];
LowlevelSaliencyPath = ['.\results\' mode '\LowlevelSaliency\'];
FinalImagePath = ['.\results\' mode '\FinalImage\'];

RectSPInfo = ['.\results\' mode '\RectSPInfoPath\'];
RPNBoxPath = ['.\results\' mode '\RPNBox\'];
LOMPath = ['.\results\' mode '\LOM\'];
NosmoothPath = ['.\results\' mode '\NoSmooth\'];
% WeightFanPath = ['.\results\' mode '\WeightFan\'];

s=strcat('mkdir ',AveragePath);system(s);
s=strcat('mkdir ',ResultsDataPath);system(s);
s=strcat('mkdir ',SuperPixelStructurePath);system(s);
s=strcat('mkdir ',OpticalFlowPath);system(s);
s=strcat('mkdir ',SmoothedMotionSaliencyPath);system(s);
s=strcat('mkdir ',SiftFlowPath);system(s);
s=strcat('mkdir ',RawColorSaliencyPath);system(s);
s=strcat('mkdir ',MotionSaliencyPath);system(s);
s=strcat('mkdir ',AllScaleFeatPath);system(s);
s=strcat('mkdir ',ImageRectPath);system(s);
s=strcat('mkdir ',LowlevelSaliencyPath);system(s);
s=strcat('mkdir ',FinalImagePath);system(s);

s=strcat('mkdir ',RectSPInfo);system(s);
s=strcat('mkdir ',RPNBoxPath);system(s);
s=strcat('mkdir ',LOMPath);system(s);
s=strcat('mkdir ',NosmoothPath);system(s);
% s=strcat('mkdir ',WeightFanPath);system(s);

para.AveragePath = AveragePath;
para.SuperPixelStructurePath = SuperPixelStructurePath;
para.OpticalFlowPath = OpticalFlowPath;
para.SiftFlowPath = SiftFlowPath;
para.MotionSaliencyPath = MotionSaliencyPath;
para.SmoothedMotionSaliencyPath = SmoothedMotionSaliencyPath;
para.AllScaleFeatPath = AllScaleFeatPath;
para.ImageRectPath = ImageRectPath;
para.RawColorSaliencyPath = RawColorSaliencyPath;
para.LowlevelSaliencyPath = LowlevelSaliencyPath;
para.FinalImagePath = FinalImagePath;

para.RectSPInfoPath = RectSPInfo;
para.RPNBoxPath = RPNBoxPath;
para.LOMPath = LOMPath;
para.NosmoothPath = NosmoothPath;
% para.WeightFanPath = WeightFanPath;
clc;
