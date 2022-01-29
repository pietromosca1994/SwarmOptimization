#ifndef TOPOLOGY_CLASS
#define TOPOLOGY_CLASS

#include "common.h"
#include "swarm.h"

// type definitions
struct alg_param_struct{
    double c1;      // personal best position coefficient
    double c2;      // global best position coefficient 
    double w;       // velocity associated parameter
    double lr;      // learning rate
    int n_iter;     // number of iterations
};

// class definition
class topology {
    public:
    int algorithm;

    // constructor
    topology(int _algorithm);

    // methods
    void update_gbest(swarm &swarm);
    void update_pbest(swarm &swarm);
    void update_position(swarm &swarm, alg_param_struct alg_param, double (*func)(vector<double>));
    void update_velocity(swarm &swarm, alg_param_struct alg_param);
    void picknrandom(int n);
};

#endif