#pragma OPENCL EXTENSION cl_amd_printf : enable
__kernel  void image_togrey(	__global uchar * src_data, __global uchar * dest_data,	//Data in global memory
	                                            int W,    int H,								//Image Dimensions
	                                           float sinTheta, float cosTheta )					// Parameters
{    
	//Thread gets its index within index space
	const int ix = get_global_id(0); 
	const int iy = get_global_id(1);    
	
	//int t = W*H*4;
	int temp=0;
	for(int i=0;i<W*H;i++)
	{
		temp=((int)src_data[4*i+0]+(int)src_data[4*i+1]+(int)src_data[4*i+2])/3 ; 
		dest_data[i+0]=(uchar)temp;
	}

	
}

