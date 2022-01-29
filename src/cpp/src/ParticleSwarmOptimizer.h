#ifndef PARTICLESWARMOPTIMIZER
#define PARTICLESWARMOPTIMIZER

#include "common.h"
#include "swarm.h"
#include "topology.h"

vector<double> ParticleSwarmOptimizer(double (*func)(vector<double>), int _n_particles, domain_struct _x_domain, alg_param_struct _alg_param);

#endif


