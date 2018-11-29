#include "mex.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\include\cuda_runtime.h"
 #include "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\include\device_launch_parameters.h"
#include <stdio.h>
#include <algorithm>


__global__ void smooth_kernel(double *Result, double* midP,double* Ind,double *K1,double *SaA,double *SaA0,double *SaA2,double *N1,double *P1,double *P2,double *spnum)
{
	int j =  threadIdx.x;
    int K=(int)(*K1),i=(int)(*Ind), N=(int)(*N1);
	if (threadIdx.x >= K)
		return;

	int k;
	double Lcolor1,Lcolor2,Lcolor3,Lcolor4,Lcolor5,Llocation1,Llocation2;
	double Rcolor1,Rcolor2,Rcolor3,Rcolor4,Rcolor5,Rlocation1,Rlocation2;
	double Tweight=0,weight1=0;
	double MSS=0;
	double CDist=0,LDist=0;
    Llocation1 = midP[(K)*7*i+j],Llocation2 = midP[(K)*7*i+(K)*1+j],Lcolor1 = midP[(K)*7*i+(K)*2+j], Lcolor2 = midP[(K)*7*i+(K)*3+j],Lcolor3 = midP[(K)*7*i+(K)*4+j],Lcolor4 = midP[(K)*7*i+(K)*5+j],Lcolor5 = midP[(K)*7*i+(K)*6+j];
	for (k=0;k<spnum[i];k++)
	{
		Rlocation1 = midP[(K)*7*i+k],Rlocation2 = midP[(K)*7*i+(K)*1+k],Rcolor1 = midP[(K)*7*i+(K)*2+k], Rcolor2 = midP[(K)*7*i+(K)*3+k],Rcolor3 = midP[(K)*7*i+(K)*4+k],Rcolor4 = midP[(K)*7*i+(K)*5+k],Rcolor5 = midP[(K)*7*i+(K)*6+k];
		LDist=abs(Llocation1-Rlocation1)+abs(Llocation2-Rlocation2);
		CDist=sqrt((Lcolor1-Rcolor1)*(Lcolor1-Rcolor1)+(Lcolor3-Rcolor3)*(Lcolor3-Rcolor3)+(Lcolor2-Rcolor2)*(Lcolor2-Rcolor2)+(Lcolor4-Rcolor4)*(Lcolor4-Rcolor4)+(Lcolor5-Rcolor5)*(Lcolor5-Rcolor5));
		if (LDist<(*P1))
		{
			weight1=exp(-CDist*(*P2));
			Tweight+=weight1;
			MSS=MSS+SaA[k]*weight1;
		}
	}
    if(i<N-1)
    for ( k=0;k<spnum[i+1];k++)
	{
		Rlocation1 = midP[(K)*7*(i+1)+k],Rlocation2 = midP[(K)*7*(i+1)+(K)*1+k],Rcolor1 = midP[(K)*7*(i+1)+(K)*2+k], Rcolor2 = midP[(K)*7*(i+1)+(K)*3+k],Rcolor3 = midP[(K)*7*(i+1)+(K)*4+k],Rcolor4 = midP[(K)*7*(i+1)+(K)*5+k],Rcolor5 = midP[(K)*7*(i+1)+(K)*6+k];
		LDist=abs(Llocation1-Rlocation1)+abs(Llocation2-Rlocation2);
		CDist=sqrt((Lcolor1-Rcolor1)*(Lcolor1-Rcolor1)+(Lcolor3-Rcolor3)*(Lcolor3-Rcolor3)+(Lcolor2-Rcolor2)*(Lcolor2-Rcolor2)+(Lcolor4-Rcolor4)*(Lcolor4-Rcolor4)+(Lcolor5-Rcolor5)*(Lcolor5-Rcolor5));
		if (LDist<(*P1))
		{
			weight1=exp(-CDist*(*P2));
			Tweight+=weight1;
			MSS=MSS+SaA2[k]*weight1;
		}
	}
    if (i>0)
    for (k=0;k<spnum[i-1];k++)
	{
		Rlocation1 = midP[(K)*7*(i-1)+k],Rlocation2 = midP[(K)*7*(i-1)+(K)*1+k],Rcolor1 = midP[(K)*7*(i-1)+(K)*2+k], Rcolor2 = midP[(K)*7*(i-1)+(K)*3+k],Rcolor3 = midP[(K)*7*(i-1)+(K)*4+k],Rcolor4 = midP[(K)*7*(i-1)+(K)*5+k],Rcolor5 = midP[(K)*7*(i-1)+(K)*6+k];
		LDist=abs(Llocation1-Rlocation1)+abs(Llocation2-Rlocation2);
		CDist=sqrt((Lcolor1-Rcolor1)*(Lcolor1-Rcolor1)+(Lcolor3-Rcolor3)*(Lcolor3-Rcolor3)+(Lcolor2-Rcolor2)*(Lcolor2-Rcolor2)+(Lcolor4-Rcolor4)*(Lcolor4-Rcolor4)+(Lcolor5-Rcolor5)*(Lcolor5-Rcolor5));
		if (LDist<(*P1))
		{
			weight1=exp(-CDist*(*P2));
			Tweight+=weight1;
			MSS=MSS+SaA0[k]*weight1;
		}
	}
    Result[j]=MSS/Tweight;
	return;

}
extern void colorsm2(double *Result, double* midP,double* Ind,double *K1,double *SaA,double *SaA0,double *SaA2,double *N1,double *Par1,double *Par2,double *spnum);
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *midP;
    double *SaA,*SaA0,*SaA2;
	double *Result;
    double *K1,*Ind,*N1;
    double * Par1,*Par2,*spnum;
	midP=mxGetPr(prhs[0]);
    Ind=mxGetPr(prhs[1]);
    K1=mxGetPr(prhs[2]);
    SaA=mxGetPr(prhs[3]);
    SaA0=mxGetPr(prhs[4]);
    SaA2=mxGetPr(prhs[5]);
    N1=mxGetPr(prhs[6]);
    Par1=mxGetPr(prhs[7]);
    Par2=mxGetPr(prhs[8]);
    spnum=mxGetPr(prhs[9]);
    int K=(int)(*K1);
	plhs[0]=mxCreateDoubleMatrix(K,1,mxREAL);
	Result=mxGetPr(plhs[0]);
	colorsm2(Result,midP,Ind,K1,SaA,SaA0,SaA2,N1,Par1,Par2,spnum);
}
void colorsm2(double *Result, double* midP,double* Ind,double *K1,double *SaA,double *SaA0,double *SaA2,double *N1,double *Par1,double *Par2,double *spnum)
{
	double * dev_Result;
	double *dev_mid;
    double *dev_SaA,*dev_SaA0,*dev_SaA2;
    double *dev_K1,*dev_Ind,*dev_N1;
    double *dev_P1,*dev_P2,*dev_spnum;
    int K=(int)(*K1);
    int N=(int)(*N1);

	cudaMalloc((void **)&dev_mid, sizeof(double)* (K) * 7 * N);
	cudaMalloc((void **)&dev_SaA, sizeof(double)* K );
	cudaMalloc((void **)&dev_SaA0, sizeof(double)* K );
	cudaMalloc((void **)&dev_SaA2, sizeof(double)* K );
    cudaMalloc((void **)&dev_K1, sizeof(double));
    cudaMalloc((void **)&dev_N1, sizeof(double));
    cudaMalloc((void **)&dev_Ind, sizeof(double));
	cudaMalloc((void **)&dev_Result, sizeof(double)* K );
    cudaMalloc((void **)&dev_P1, sizeof(double));
    cudaMalloc((void **)&dev_P2, sizeof(double));
    cudaMalloc((void **)&dev_spnum, sizeof(double)*N);

	cudaMemcpy(dev_K1, K1, sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_N1, N1, sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_Ind, Ind, sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_mid, midP, sizeof(double)* (K)*7*N, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_SaA, SaA, sizeof(double)* K, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_SaA0, SaA0, sizeof(double)* K, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_SaA2, SaA2, sizeof(double)* K, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_P1, Par1, sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_P2, Par2, sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_spnum, spnum, sizeof(double)*N, cudaMemcpyHostToDevice);

	dim3 threads(K);
	smooth_kernel << <1, threads >> >(dev_Result,dev_mid,dev_Ind,dev_K1,dev_SaA,dev_SaA0,dev_SaA2,dev_N1,dev_P1,dev_P2,dev_spnum);

    cudaMemcpy(Result, dev_Result, sizeof(double)*K, cudaMemcpyDeviceToHost);

	cudaFree(dev_mid);
    cudaFree(dev_K1);
    cudaFree(dev_SaA);
    cudaFree(dev_Ind);
    cudaFree(dev_Result);
    cudaFree(dev_P1);
    cudaFree(dev_P2);
    cudaFree(dev_SaA0);
    cudaFree(dev_SaA2);
    cudaFree(dev_N1);
    cudaFree(dev_spnum);

}	




