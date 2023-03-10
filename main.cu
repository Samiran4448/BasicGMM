/*! \brief File containing evaluation and grading code

This file contains evaluation and grading code.
automatic grading and students should not modify it.
*/

#include "eval.cuh"

int main()
{
  eval(32, 32, 32);
  eval(30, 30, 30);
  eval(29, 29, 29);
  eval(31, 31, 31);
  eval(128, 128, 13);
  eval(13, 128, 128);
  eval(128, 13, 128);
  eval(1, 1, 1);
  eval(512, 512, 64);
  eval(256, 256, 256);

  // eval(409,409,409);
  return 0;
}