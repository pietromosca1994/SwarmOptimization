#include "ParticleSwarmOptimizer.h"

vector<double> ParticleSwarmOptimizer(double (*func)(vector<double>), int _n_particles, domain_struct _x_domain, alg_param_struct _alg_param){
    // swarm initialization
    swarm _swarm(_n_particles, _x_domain, func);

    // topology initialization
    topology _topology(1);

    vector<double> gbest_x(_swarm.n_dimensions, 0.0);
    
    for (int i=0; i<_alg_param.n_iter; i++){
        _topology.update_position(_swarm, _alg_param, func);
        _topology.update_velocity(_swarm, _alg_param);
        _topology.update_gbest(_swarm);\
        _topology.update_pbest(_swarm);
    };

    gbest_x=_swarm.gbest_x;

    return gbest_x;

}
