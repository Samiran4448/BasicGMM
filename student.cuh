#pragma once
#include "assert.h"
#include "stdio.h"
#include <algorithm>
#include <cuda.h>
#include <cuda_runtime.h>

#include "utils/logger.cuh"
#include "utils/rng.cuh"
#include "utils/timer.h"

/*! \brief File containing student code

students should only modify this file
*/

//  You can use this kernel defination
/*
__global__ void GMM(float *A, float *B, float *C, size_t Arow, size_t Acol, size_t Bcol){

}
*/

// Define cuda kernel here
// Define cuda kernel here
// Define cuda kernel here
// Define cuda kernel here

// Do NOT modify the function Image
void BasicGMM(size_t matArow, size_t matAcol, size_t matBrow, size_t matBcol, float *hostA, float *hostB, float *hostC)
{
  if (matAcol != matBrow)
  {
    Log(critical, "Incorrect matrix configuration");
    return;
  }
  // device memory pointers
  float *deviceA = nullptr, *deviceB = nullptr, *deviceC = nullptr;
  size_t cSz = matArow * matBcol;

  //////////////////////////////////////////
  // Allocate GPU Memory
  //////////////////////////////////////////
  Timer t;
  Log(debug, "Allocating GPU memory");
  // Fill this part
  // Fill this part
  // Fill this part
  // Fill this part
  // Fill this part
  double seconds = t.elapsed();
  Log(debug, "done... %f sec\n\n", seconds);

  //////////////////////////////////////////
  // Copy Host Data to GPU
  //////////////////////////////////////////
  Log(debug, "Copying host memory to the GPU");
  t.reset();
  // Fill this part
  // Fill this part
  // Fill this part
  // Fill this part
  // Fill this part
  seconds = t.elapsed();
  Log(debug, "done... %f sec\n\n", seconds);

  //////////////////////////////////////////
  // GPU M-M multiplication computation
  //////////////////////////////////////////
  Log(debug, "Performing GPU Matrix-Multiplication");
  t.reset();

  // Fill this part; call the kernel here (Remember: <<< >>>)
  // Fill this part; call the kernel here (Remember: <<< >>>)
  // Fill this part; call the kernel here (Remember: <<< >>>)
  // Fill this part; call the kernel here (Remember: <<< >>>)
  // Fill this part; call the kernel here (Remember: <<< >>>)

  CUDA_RUNTIME(cudaDeviceSynchronize());
  seconds = t.elapsed();
  Log(debug, "done... %f sec\n\n", seconds);

  //////////////////////////////////////////
  // Copy GPU Data to Host
  //////////////////////////////////////////
  Log(debug, "Copying GPU memory to the host");
  t.reset();
  // Let me do this part for you
  CUDA_RUNTIME(cudaMemcpy(hostC, deviceC, cSz * sizeof(float), cudaMemcpyDeviceToHost));
  seconds = t.elapsed();
  Log(debug, "done... %f sec\n\n", seconds);

  //////////////////////////////////////////
  // Delete GPU memory
  //////////////////////////////////////////
  Log(debug, "Deleting GPU memory");
  t.reset();
  // Let me do this part for you
  CUDA_RUNTIME(cudaFree(deviceA));
  CUDA_RUNTIME(cudaFree(deviceB));
  CUDA_RUNTIME(cudaFree(deviceC));
  seconds = t.elapsed();
  Log(debug, "done... %f sec\n\n", seconds);
}