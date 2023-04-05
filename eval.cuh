#pragma once
#include "assert.h"
#include "stdio.h"
#include <algorithm>
#include <cuda.h>
#include <cuda_runtime.h>

#include "utils/logger.cuh"
#include "utils/rng.cuh"
#include "utils/timer.h"
#include "student.cuh"

/*! \brief File containing evaluation and grading code

This file contains evaluation and grading code.
automatic grading and students should not modify it.
*/

static void generate_data(float *x, const size_t n)
{
  const auto rng_state = rng_new_state();

  for (size_t ii = 0; ii < n; ++ii)
  {
    x[ii] = rng_float(rng_state);
  }

  delete rng_state;
}

bool verify(const float *A, const float *B, const float *C, size_t m, size_t k,
            size_t n)
{

  for (size_t row = 0; row < m; ++row)
  {
    for (size_t col = 0; col < n; ++col)
    {
      float sum = 0;
      for (size_t i = 0; i < k; ++i)
      {
        sum += A[row * k + i] * B[i * n + col];
      }
      float relativeError = (sum - C[row * n + col]) / sum;
      if (std::abs(relativeError) > 1e-6)
      {
        Log(critical, "the results were not close enough at C[%lu, %lu], expected %f got %f", row, col, sum, C[row + col * m]);
        return false;
      }
    }
  }
  return true;
}

int eval(const size_t matArow, const size_t matAcol, const size_t matBcol)
{

  const size_t matBrow = matAcol;

  // Generate model
  Log(info, "Running BasicGMM[<%lu, %lu> x <%lu, %lu>]", matArow, matAcol, matBrow, matBcol);

  const size_t aSz = matArow * matAcol;
  const size_t bSz = matBrow * matBcol;
  const size_t cSz = matArow * matBcol;

  // generate input data
  Log(debug, "Generating test data");
  Timer t;

  float *hostA = new float[aSz];
  float *hostB = new float[bSz];
  float *hostC = new float[cSz];

  generate_data(hostA, aSz);
  generate_data(hostB, bSz);
  auto seconds = t.elapsed();
  Log(debug, "done... %f sec\n\n", seconds);

  BasicGMM(matArow, matAcol, matBrow, matBcol, hostA, hostB, hostC);

  // verify with provided implementation
  // timer_start("Verifying results");
  Log(debug, "Verifying Results");
  if (verify(hostA, hostB, hostC, matArow, matAcol, matBcol))
  {
    Log(info, "Passed!\n\n");
  }
  else
    Log(critical, "Failed!\n\n");

  delete[] hostA;
  delete[] hostB;
  delete[] hostC;
  return 0;
}