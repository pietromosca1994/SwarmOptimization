#include "topology.h"

topology::topology (int _algorithm){
    algorithm=_algorithm;
};

void topology::update_gbest(swarm &swarm){
    double _gbest_y=*min_element(swarm.y.begin(), swarm.y.end());

    if(_gbest_y<swarm.gbest_y){
        swarm.gbest_y=_gbest_y;
        swarm.gbest_x=swarm.x[min_element(swarm.y.begin(), swarm.y.end()) - swarm.y.begin()];
    }   
};

void topology::update_pbest(swarm &swarm){
    for(int i=0; i<swarm.n_particles; i++){
        if(swarm.y[i]<swarm.pbest_y[i]){
            swarm.pbest_y[i]=swarm.y[i];
            swarm.pbest_x[i]=swarm.x[i];
        };
    };
};

void topology::update_position(swarm &swarm, alg_param_struct alg_param, double (*func)(vector<double>)){
    // update based on velocity
    vector<double> temp_vec(swarm.n_dimensions, 0.0);

    for (int i=0; i<swarm.n_particles; i++){
        mulVectorScalar(swarm.v[i], alg_param.lr, temp_vec);
        sumVectors(swarm.x[i], temp_vec, swarm.x[i]);
    };

    swarm.clipx();

    for(int i=0; i<swarm.n_particles; i++){ // update function
        swarm.y[i]=func(swarm.x[i]);
    };
};

void topology::update_velocity(swarm &swarm, alg_param_struct alg_param){
    
    
    vector<double> temp_vec(swarm.n_dimensions, 0.0);
 

    for (int i=0; i<swarm.n_particles; i++){ // loop through particles

        vector<double> rand_n(swarm.n_dimensions, 0);
        
        mulVectorScalar(swarm.v[i], alg_param.w, swarm.v[i]);
        
        // compute the g_best term
        for (int j=0; j<int(rand_n.size()); j++){ // load a random vector 
            srand(time(0)+j);   
            rand_n[j]=(double) rand()/(RAND_MAX);
        };
        subVectors(swarm.gbest_x, swarm.x[i], temp_vec);
        mulVectors(rand_n, temp_vec, temp_vec);
        mulVectorScalar(temp_vec, alg_param.c1,  temp_vec);
        sumVectors(swarm.v[i], temp_vec, swarm.v[i]);

        // compute the p_best part
        for (int j=0; j<int(rand_n.size()); j++){ // load a random vector 
            srand(time(0)+j);   
            rand_n[j]=(double) rand()/(RAND_MAX);
        };

        subVectors(swarm.pbest_x[i], swarm.x[i], temp_vec);
        mulVectors(rand_n, temp_vec, temp_vec);
        mulVectorScalar(temp_vec, alg_param.c2, temp_vec);
        sumVectors(swarm.v[i], temp_vec, swarm.v[i]);
    };
    
};
