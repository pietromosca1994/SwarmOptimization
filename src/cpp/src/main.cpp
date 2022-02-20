#include "swarm.h"
#include "topology.h"
#include "ParticleSwarmOptimizer.h"
#include "sphere.h"
#include "rosenbrock.h"
#include "utils.h"
#include <chrono>

int main(){
    int n_particles = 100;
    
    domain_struct x_domain;
    x_domain.hi={2.0, 3.0};
    x_domain.lo={-1.0, -1.0};

    alg_param_struct alg_param;
    alg_param.c1=0.5;
    alg_param.c2=0.2;
    alg_param.w=0.1;    
    alg_param.lr=1;
    alg_param.n_iter=100;

    // update
    vector<double> gbest_x(int(x_domain.hi.size()), 0);
   
    auto t_start = chrono::high_resolution_clock::now(); // start stopwatch
    gbest_x=ParticleSwarmOptimizer(&rosenbrock, n_particles, x_domain, alg_param);
    auto t_end = std::chrono::high_resolution_clock::now(); // stop stopwatch
    double elapsed_time_ms = chrono::duration<double, milli>(t_end-t_start).count();
    // x best
    cout << "Optimal x_best: \n";
    printVector(gbest_x);
    cout<< "Elapsed time: " << elapsed_time_ms << " ms \n";
 };
 