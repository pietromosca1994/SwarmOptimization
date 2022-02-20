#include "swarm.h"

swarm::swarm ( int _n_particles, domain_struct _x_domain, double (*func)(vector<double>)): \
    n_particles(_n_particles), \
    x_domain(_x_domain)

    { // constructor
    n_dimensions = _x_domain.hi.size();

    x.resize(n_particles, vector<double>(n_dimensions, 0));
    y.resize(n_particles);
    v.resize(n_particles, vector<double>(n_dimensions, 0));
    gbest_x.resize(n_dimensions);
    pbest_x.resize(n_particles, vector<double>(n_dimensions, 0));
    pbest_y.resize(n_particles);
    v_domain.hi.resize(n_dimensions);
    v_domain.lo.resize(n_dimensions);


    // initialize x
    srand(time(0)); // set the seed for rand()
    for (int i=0; i<n_particles; i++){ // loop through particles 
        for (int j=0; j<n_dimensions; j++){ // loop through dimensions
            x[i][j]=x_domain.lo[j]+((double) rand() / (RAND_MAX))*(x_domain.hi[j]-x_domain.lo[j]); // RAND_MAX is the maximum random number
        }
    }

    // initialize y
    for (int i=0; i<n_particles; i++){
        y[i]=func(x[i]);
    } 

    // initialize v
    subVectors(x_domain.hi, x_domain.lo, v_domain.hi);
    absVector(x_domain.hi, v_domain.hi);
    mulVectorScalar(v_domain.hi, double(-1.0), v_domain.lo);
    
    for (int i=0; i<n_particles; i++){
        for (int j=0; j<n_dimensions; j++){
            v[i][j]=v_domain.lo[j]+((double) rand() / (RAND_MAX))*(v_domain.hi[j]-v_domain.lo[j]); // RAND_MAX is the maximum random number
        };
    };

    // initialize particle personal best estimate
    pbest_y=y;
    pbest_x=x;
    
    // initialize particle global best
    gbest_y=*min_element(y.begin(), y.end());
    gbest_x=x[min_element(y.begin(), y.end()) - y.begin()];
};

void swarm::clipx(){
    for (int i=0; i<n_particles; i++){ // loop through particles
        for (int j=0; j<n_dimensions; j++){ // loop through dimensions
            // hi clip 
            if (x[i][j]>x_domain.hi[j]){
                x[i][j]=x_domain.hi[j];
            }

            // lo clip
            if (x[i][j]<x_domain.lo[j]){
                x[i][j]=x_domain.lo[j];
            }
        };
    };
};

