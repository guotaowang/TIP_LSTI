function main()
   clear
   close all;
    warning off 
    dirOutput=dir('.\sequence\');
    fileNames={dirOutput.name}';
    length =  size(fileNames,1);
    for file_i=3:length
        mode = fileNames{file_i}; 
                    path = ['.\sequence\' mode  '\'];
                    createDir;
                    Files = dir([path,'*.bmp']);
                    mode   
                    LengthFiles = size(Files, 1);
                    para.Files = Files;
                    para.LengthFiles = LengthFiles;
                    para.path = path;
                    ImageName = Files(2).name;
                   BatchSize = cell2mat(computeBatchSize(LengthFiles-1,7));
                    if(size(BatchSize,2)==1)
                       BatchSize = cell2mat(computeBatchSize(LengthFiles-1,6));
                    end
                    BatchNum = size(BatchSize,2);
                    para.BatchNum = BatchNum;
                    para.BatchSize = BatchSize;
                    ImagePath = [path ImageName];
                    I = imread(ImagePath);
                    W = size(I,1);H = size(I,2);
                    para.W = W; para.H = H;
                    scale = 2;
                    vote = 2;
                    computeCol = 1;
                                fprintf('Step 1. Optical Flow Computation...\n');
                                ImgIndex = 1;
                                LengthFiles = para.LengthFiles;
                                while(ImgIndex<=LengthFiles-1)
                                  parfor i=1:6
                                      if(i==1)
                                          CImgIndex = ImgIndex;
                                          if(CImgIndex<=LengthFiles-1)
                                              computeOpticalFlow(CImgIndex,para);
                                          end
                                      end
                                      if(i==2)
                                          CImgIndex = ImgIndex+1;
                                          if(CImgIndex<=LengthFiles-1)
                                              computeOpticalFlow(CImgIndex,para);
                                          end
                                      end
                                      if(i==3)
                                          CImgIndex = ImgIndex+2;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeOpticalFlow(CImgIndex,para);
                                          end
                                      end
                                      if(i==4)
                                          CImgIndex = ImgIndex+3;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeOpticalFlow(CImgIndex,para);
                                          end
                                      end
                                      if(i==5)
                                          CImgIndex = ImgIndex+4;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeOpticalFlow(CImgIndex,para);
                                          end
                                      end
                                      if(i==6)
                                          CImgIndex = ImgIndex+5;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeOpticalFlow(CImgIndex,para);
                                          end
                                      end
                                  end
                                   ImgIndex = ImgIndex + 6;
                                end
                                fprintf('done!\n');
                                fprintf('Step 2. Begin SLIC Computation...\n');
                                ImgIndex = 1;
                                while(ImgIndex<=LengthFiles-1)
                                    parfor i=1:6
                                        if(i==1)
                                            CImgIndex = ImgIndex;
                                            if(CImgIndex<=LengthFiles-1)
                                                computeSuperpixelStructure(mode,scale,CImgIndex,para);
                                            end
                                        end
                                        if(i==2)
                                             CImgIndex = ImgIndex+1;
                                             if(CImgIndex<=LengthFiles-1)
                                                computeSuperpixelStructure(mode,scale,CImgIndex,para);
                                             end
                                        end
                                        if(i==3)
                                             CImgIndex = ImgIndex+2;
                                             if(CImgIndex<=LengthFiles-1)
                                                computeSuperpixelStructure(mode,scale,CImgIndex,para);
                                             end
                                         end
                                         if(i==4)
                                              CImgIndex = ImgIndex+3;
                                              if(CImgIndex<=LengthFiles-1)
                                                computeSuperpixelStructure(mode,scale,CImgIndex,para);
                                              end
                                         end
                                         if(i==5)
                                             CImgIndex = ImgIndex+4;
                                             if(CImgIndex<=LengthFiles-1)
                                                computeSuperpixelStructure(mode,scale,CImgIndex,para);
                                             end
                                         end
                                         if(i==6)
                                              CImgIndex = ImgIndex+5;
                                              if(CImgIndex<=LengthFiles-1)
                                                computeSuperpixelStructure(mode,scale,CImgIndex,para);
                                              end
                                         end
                                    end
                                    ImgIndex = ImgIndex + 6;
                                end
                                fprintf('done!\n');
                                fprintf('Step 3. Compute Motion Contrast Saliency...\n');
                                ImgIndex = 1;
                                LengthFiles = para.LengthFiles;
                                while(ImgIndex<=LengthFiles-1)
                                  parfor i=1:6
                                      if(i==1)
                                          CImgIndex = ImgIndex;
                                          if(CImgIndex<=LengthFiles-1)
                                              computeMotionSaliency(mode,CImgIndex,para);
                                          end
                                      end
                                      if(i==2)
                                          CImgIndex = ImgIndex+1;
                                          if(CImgIndex<=LengthFiles-1)
                                                computeMotionSaliency(mode,CImgIndex,para);
                                          end
                                      end
                                      if(i==3)
                                          CImgIndex = ImgIndex+2;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeMotionSaliency(mode,CImgIndex,para);
                                          end
                                      end
                                      if(i==4)
                                          CImgIndex = ImgIndex+3;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeMotionSaliency(mode,CImgIndex,para);
                                          end
                                      end
                                      if(i==5)
                                          CImgIndex = ImgIndex+4;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeMotionSaliency(mode,CImgIndex,para);
                                          end
                                      end
                                      if(i==6)
                                          CImgIndex = ImgIndex+5;
                                          if(CImgIndex<=LengthFiles-1)
                                               computeMotionSaliency(mode,CImgIndex,para);
                                          end
                                      end
                                  end
                                   ImgIndex = ImgIndex + 6;
                                end
                                fprintf('done!\n');
                                persent_all = 0;
                                     for i=1:LengthFiles-1
                                         ImageName = Files(i).name;
                                          persent = load([para.AveragePath ImageName(1:end-4) 'persent.mat']);
                                          persent = persent.persent;
                                          persent_all = persent_all + persent;
                                    end
                                    persent = persent_all/(LengthFiles-1);
                                   if persent < 0.0075
                                       computeCol = 0 ;
                                       break;
                                   end
                                   if computeCol == 1
                                   fprintf('Step 4. Compute Motion Saliency Smooth...\n');
                                    [MotSaliencyM,smooth,SP_all,I,MaxDim,SPnum] = GetSmoothInfo(vote,scale,para,mode);
                                            ring = smooth.ring{1};  SPnum = SPnum(:,1);
                                            ImgIndex = 1;
                                            LengthFiles = para.LengthFiles;
                                            while(ImgIndex<=LengthFiles-1)
                                                    Saliency_smooth(para,ImgIndex,MotSaliencyM,ring,MaxDim,SPnum,SP_all{1},I,LengthFiles-1,mode);
                                                    ImgIndex = ImgIndex + 1;
                                            end
                                            fprintf('done!\n');                                                         
                                             fprintf('Step 5. Compute Color Saliency...\n');
                                                    computeColorContrastSaliency(para,mode,scale);
                                             fprintf('done!\n');
                                   end
                                            fprintf('Step 6. Compute LowLevel Saliency...\n');
                                            ImgIndex = 1;
                                            LengthFiles = para.LengthFiles;
                                            tic
                                            while(ImgIndex<=LengthFiles-1)
                                              parfor i=1:6
                                                  if(i==1)
                                                      CImgIndex = ImgIndex;
                                                      if(CImgIndex<=LengthFiles-1)
                                                          ComputeLowlevelSaliency(computeCol,mode,CImgIndex,para);
                                                      end
                                                  end
                                                  if(i==2)
                                                      CImgIndex = ImgIndex+1;
                                                      if(CImgIndex<=LengthFiles-1)
                                                           ComputeLowlevelSaliency(computeCol,mode,CImgIndex,para);
                                                      end
                                                  end
                                                  if(i==3)
                                                      CImgIndex = ImgIndex+2;
                                                      if(CImgIndex<=LengthFiles-1)
                                                           ComputeLowlevelSaliency(computeCol,mode,CImgIndex,para);
                                                      end
                                                  end
                                                  if(i==4)
                                                      CImgIndex = ImgIndex+3;
                                                      if(CImgIndex<=LengthFiles-1)
                                                          ComputeLowlevelSaliency(computeCol,mode,CImgIndex,para);
                                                      end
                                                  end
                                                  if(i==5)
                                                      CImgIndex = ImgIndex+4;
                                                      if(CImgIndex<=LengthFiles-1)
                                                           ComputeLowlevelSaliency(computeCol,mode,CImgIndex,para);
                                                      end
                                                  end
                                                  if(i==6)
                                                      CImgIndex = ImgIndex+5;
                                                      if(CImgIndex<=LengthFiles-1)
                                                          ComputeLowlevelSaliency(computeCol,mode,CImgIndex,para);
                                                      end
                                                  end
                                              end
                                               ImgIndex = ImgIndex + 6;
                                            end
                                            fprintf('done!\n');
                                    [rpnaverage,average]  = FastQualitAccess(para); 
                                    [opts, proposal_detection_model, rpn_net]=FsterRcnnInit();
                                    FsterRcnnRpn(para, opts, proposal_detection_model, rpn_net, mode, rpnaverage');
                                    fprintf('Step 7. GetRectSPInfo...\n');
                                   ImgIndex = 1;
                                    LengthFiles = para.LengthFiles;
                                    while(ImgIndex<=LengthFiles-1)
                                        parfor i=1:6
                                            if(i==1)
                                                CImgIndex = ImgIndex;
                                                if(CImgIndex<=LengthFiles-1)
                                                    GetBoxesInfo(vote,scale,CImgIndex,para,mode,average)
                                                end
                                            end
                                            if(i==2)
                                                 CImgIndex = ImgIndex+1;
                                                 if(CImgIndex<=LengthFiles-1)
                                                    GetBoxesInfo(vote,scale,CImgIndex,para,mode,average)
                                                 end
                                            end
                                            if(i==3)
                                                 CImgIndex = ImgIndex+2;
                                                 if(CImgIndex<=LengthFiles-1)
                                                    GetBoxesInfo(vote,scale,CImgIndex,para,mode,average)
                                                 end
                                             end
                                             if(i==4)
                                                  CImgIndex = ImgIndex+3;
                                                  if(CImgIndex<=LengthFiles-1)
                                                    GetBoxesInfo(vote,scale,CImgIndex,para,mode,average)
                                                  end
                                             end
                                             if(i==5)
                                                 CImgIndex = ImgIndex+4;
                                                 if(CImgIndex<=LengthFiles-1)
                                                    GetBoxesInfo(vote,scale,CImgIndex,para,mode,average)
                                                 end
                                             end
                                             if(i==6)
                                                  CImgIndex = ImgIndex+5;
                                                  if(CImgIndex<=LengthFiles-1)
                                                    GetBoxesInfo(vote,scale,CImgIndex,para,mode,average)
                                                  end
                                             end
                                        end
                                        ImgIndex = ImgIndex + 6;
                                    end 
                                fprintf('done!\n');
                                    fprintf('Step 8. Siftflow Computation...\n');
                                    ImgIndex = 1;
                                    LengthFiles = para.LengthFiles;
                                    while(ImgIndex<=LengthFiles-1)
                                        parfor i=1:6
                                            if(i==1)
                                                CImgIndex = ImgIndex;
                                                if(CImgIndex<=LengthFiles-1)
                                                    CoarselevelLocalization(vote,scale,CImgIndex,para,mode,average)
                                                end
                                            end
                                            if(i==2)
                                                 CImgIndex = ImgIndex+1;
                                                 if(CImgIndex<=LengthFiles-1)
                                                    CoarselevelLocalization(vote,scale,CImgIndex,para,mode,average)
                                                 end
                                            end
                                            if(i==3)
                                                 CImgIndex = ImgIndex+2;
                                                 if(CImgIndex<=LengthFiles-1)
                                                    CoarselevelLocalization(vote,scale,CImgIndex,para,mode,average)
                                                 end
                                             end
                                             if(i==4)
                                                  CImgIndex = ImgIndex+3;
                                                  if(CImgIndex<=LengthFiles-1)
                                                    CoarselevelLocalization(vote,scale,CImgIndex,para,mode,average)
                                                  end
                                             end
                                             if(i==5)
                                                 CImgIndex = ImgIndex+4;
                                                 if(CImgIndex<=LengthFiles-1)
                                                    CoarselevelLocalization(vote,scale,CImgIndex,para,mode,average)
                                                 end
                                             end
                                             if(i==6)
                                                  CImgIndex = ImgIndex+5;
                                                  if(CImgIndex<=LengthFiles-1)
                                                    CoarselevelLocalization(vote,scale,CImgIndex,para,mode,average)
                                                  end
                                             end
                                        end
                                        ImgIndex = ImgIndex + 6;
                                    end 
                                fprintf('done!\n');
                                fprintf('Step 9. GetRect Computation...\n');
                                ImgIndex = 1;
                                while(ImgIndex<=LengthFiles-1)
                                    parfor i=1:6
                                        if(i==1)
                                            CImgIndex = ImgIndex;
                                            if(CImgIndex<=LengthFiles-1)
                                                  GetBoundingBoxes(vote,scale,CImgIndex,para,mode);
                                            end
                                        end
                                        if(i==2)
                                             CImgIndex = ImgIndex+1;
                                             if(CImgIndex<=LengthFiles-1)
                                                GetBoundingBoxes(vote,scale,CImgIndex,para,mode)
                                             end
                                        end
                                        if(i==3)
                                             CImgIndex = ImgIndex+2;
                                             if(CImgIndex<=LengthFiles-1)
                                                GetBoundingBoxes(vote,scale,CImgIndex,para,mode)
                                             end
                                         end
                                         if(i==4)
                                              CImgIndex = ImgIndex+3;
                                              if(CImgIndex<=LengthFiles-1)
                                                GetBoundingBoxes(vote,scale,CImgIndex,para,mode)
                                              end
                                         end
                                         if(i==5)
                                             CImgIndex = ImgIndex+4;
                                             if(CImgIndex<=LengthFiles-1)
                                                GetBoundingBoxes(vote,scale,CImgIndex,para,mode)
                                             end
                                         end
                                         if(i==6)
                                              CImgIndex = ImgIndex+5;
                                              if(CImgIndex<=LengthFiles-1)
                                                GetBoundingBoxes(vote,scale,CImgIndex,para,mode)
                                              end
                                         end
                                    end
                                         ImgIndex = ImgIndex + 6;
                                end
                                fprintf('done!\n');
                                fprintf('Step 10.GetDeepFeature...\n');
                                      GetDeepFeature(para,mode,scale);
                                fprintf('done!\n');
                                fprintf('Step 11. DeepFeatureComputation ...\n');
                                    ImgIndex = 1; 
                                    LengthFiles = para.LengthFiles;
                                    while(ImgIndex<=LengthFiles-1)
                                      parfor i=1:6
                                          if(i==1)
                                              CImgIndex = ImgIndex;
                                              if(CImgIndex<=LengthFiles-1)
                                                     DeepFeatureComputation(vote,scale,CImgIndex,para,mode)
                                              end
                                          end
                                          if(i==2)
                                              CImgIndex = ImgIndex+1;
                                              if(CImgIndex<=LengthFiles-1)
                                                   DeepFeatureComputation(vote,scale,CImgIndex,para,mode)
                                              end
                                          end
                                          if(i==3)
                                              CImgIndex = ImgIndex+2;
                                              if(CImgIndex<=LengthFiles-1)
                                                   DeepFeatureComputation(vote,scale,CImgIndex,para,mode)
                                              end
                                          end
                                          if(i==4)
                                              CImgIndex = ImgIndex+3;
                                              if(CImgIndex<=LengthFiles-1)
                                                  DeepFeatureComputation(vote,scale,CImgIndex,para,mode)
                                              end
                                          end
                                           if(i==5)
                                              CImgIndex = ImgIndex+4;
                                              if(CImgIndex<=LengthFiles-1)
                                                  DeepFeatureComputation(vote,scale,CImgIndex,para,mode)
                                              end
                                           end
                                           if(i==6)
                                              CImgIndex = ImgIndex+5;
                                              if(CImgIndex<=LengthFiles-1)
                                                  DeepFeatureComputation(vote,scale,CImgIndex,para,mode)
                                              end
                                           end
                                      end
                                       ImgIndex = ImgIndex +6;
                                    end
                                smooth_info = GetSPSmoothInfo(vote,scale,para,mode);
                            fprintf('Step 12. SaliencyPrediction ...\n');
                                   SaliencyPrediction(vote-1,scale,para,mode,smooth_info)
    end
end