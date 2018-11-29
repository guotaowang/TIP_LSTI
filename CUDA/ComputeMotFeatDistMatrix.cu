#include "mex.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\include\cuda_runtime.h"
 #include "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\include\device_launch_parameters.h"
#include <stdio.h>
#include <algorithm>


__global__ void FeatDist_kernel(double *Result,double* MiddlePoint,double *spnum)
{
   int K=(int)(*spnum);
	int j =  threadIdx.x;
	if (threadIdx.x >= K)
		return;

	int k;
	double LlocationVx,LlocationVy;
	double RlocationVx,RlocationVy;
    double LDist=0;

    LlocationVx = MiddlePoint[j],LlocationVy = MiddlePoint[K+j];
	for (k=0;k<K;k++)
	{
		RlocationVx = MiddlePoint[k],RlocationVy = MiddlePoint[K+k];
		LDist=abs(LlocationVx-RlocationVx)+abs(LlocationVy-RlocationVy);
	    Result[j * K + k] = LDist;
	}

	return;

}
extern void ComputeMotFeatDistMatrix(double *Result, double* MiddlePoint,double *spnum);
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *MiddlePoint;
	double *Result;
    double *spnum;
	MiddlePoint=mxGetPr(prhs[0]);
    spnum=mxGetPr(prhs[1]);
    int K=(int)(*spnum);
	plhs[0]=mxCreateDoubleMatrix( K, K,mxREAL);
	Result=mxGetPr(plhs[0]);
	ComputeMotFeatDistMatrix(Result,MiddlePoint, spnum);
}
void ComputeMotFeatDistMatrix(double *Result, double* MiddlePoint,double *spnum)
{
	double * dev_Result;
	double *dev_mid;
    double *dev_spnum;
    int K=(int)(*spnum);
	cudaMalloc((void **)&dev_mid, sizeof(double)* K *2);
	cudaMalloc((void **)&dev_Result, sizeof(double)*K*K);
    cudaMalloc((void **)&dev_spnum, sizeof(double));

	cudaMemcpy(dev_mid, MiddlePoint, sizeof(double)* K*2, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_spnum, spnum, sizeof(double), cudaMemcpyHostToDevice);

	dim3 threads(K);
	FeatDist_kernel << <1, threads >> >(dev_Result,dev_mid,dev_spnum);
    cudaMemcpy(Result, dev_Result, sizeof(double)*K*K, cudaMemcpyDeviceToHost);

	cudaFree(dev_mid);
    cudaFree(dev_Result);
    cudaFree(dev_spnum);

}	




