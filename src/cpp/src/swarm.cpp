#include "swarm.h"

swarm::swarm ( int _n_particles, int _dimensions, double (*func)(vector<double>)){ // constructor
    // input check
    if (_n_particles<=0){
        throw invalid_argument("[ERROR] Invalid n_particles");
    }

    if (_dimensions<=0){
        throw invalid_argument("[ERROR] Invalid dimensions");
    }

    n_particles = _n_particles;
    dimensions = _dimensions;

    x.resize(n_particles, vector<double>(dimensions, 0));
    y.resize(n_particles);
    gbest_x.resize(n_particles, vector<double>(dimensions, 0));
    pbest_x.resize(n_particles, vector<double>(dimensions, 0));
    pbest_y.resize(n_particles);


    // initialize x
    for (int i=0; i<n_particles; i++){
        for (int j=0; j<dimensions; j++){
            x[i][j]=((double) rand() / (RAND_MAX));
        }
    }

    // initialize y
    for (int i=0; i<n_particles; i++){
        y[i]=func(x[i]);
    } 

    // initialize v (to be inplemented later)

    // initialize particle personal best estimate
    pbest_y=y;
    pbest_x=x;
    
    // initialize particle global best
    //gbest_x=
    gbest_y=*min_element(y.begin(), y.end());

};
