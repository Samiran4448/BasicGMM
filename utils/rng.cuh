#pragma once
#include <algorithm>
#include <chrono>
// #include <random>

/*********************************************************************/
/* Random number generator                                           */
/* https://en.wikipedia.org/wiki/Xorshift                            */
/* xorshift32                                                        */
/*********************************************************************/

static uint_fast32_t rng_uint32(uint_fast32_t *rng_state)
{
  uint_fast32_t local = *rng_state;
  local ^= local << 13; // a
  local ^= local >> 17; // b
  local ^= local << 5;  // c
  *rng_state = local;
  return local;
}

static uint_fast32_t *rng_new_state(uint_fast32_t seed)
{
  uint64_t *rng_state = new uint64_t;
  *rng_state = seed;
  return rng_state;
}

static uint_fast32_t *rng_new_state()
{
  return rng_new_state(88172645463325252LL);
}

static float rng_float(uint_fast32_t *state)
{
  uint_fast32_t rnd = rng_uint32(state);
  const auto r = static_cast<float>(rnd) / static_cast<float>(UINT_FAST32_MAX);
  if (std::isfinite(r))
  {
    return r;
  }
  return rng_float(state);
}
