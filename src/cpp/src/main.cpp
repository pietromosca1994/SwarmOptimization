#include "swarm.h"
#include "topology.h"
#include "ParticleSwarmOptimizer.h"
#include "sphere.h"
#include "rosenbrock.h"
#include "utils.h"

int main(){
    int n_particles = 100;
    
    domain_struct x_domain;
    x_domain.hi={2, 3, 5};
    x_domain.lo={-1, -1, -1};

    alg_param_struct alg_param;
    alg_param.c1=0.5;
    alg_param.c2=0.2;
    alg_param.w=0.1;    
    alg_param.lr=1;
    alg_param.n_iter=100;

    int n_dimensions=x_domain.hi.size();

    swarm swarm_class(n_particles, x_domain, &rosenbrock);
    topology topology_class(1);

    cout << "n_particles: " << swarm_class.n_particles << "\n";
    cout << "dimensions: " << n_dimensions << "\n";
    cout << "size: " << swarm_class.x.size() << "\n";

    // x
    cout << "x: \n";
    for (int i=0; i<swarm_class.n_particles; i++) {
        cout << "["; 
        for (int j=0; j<n_dimensions; j++) {
            cout << swarm_class.x[i][j] << "; ";
        }
        cout << "]\n";
    }

    // y
    cout << "y: \n";    
    cout << "["; 
    for (int i=0; i<swarm_class.n_particles; i++) {
        cout << swarm_class.y[i] << "; ";
    }
    cout << "]\n";

    // v
    cout << "v: \n";
    for (int i=0; i<swarm_class.n_particles; i++) {
        cout << "["; 
        for (int j=0; j<n_dimensions; j++) {
            cout << swarm_class.v[i][j] << "; ";
        }
        cout << "]\n";
    }

    // y best
    cout << "y_best: \n" << swarm_class.gbest_y << "\n";    

    // x best
    cout << "x_best: \n";
    cout << "["; 
    for (int i=0; i<n_dimensions; i++) {
        cout << swarm_class.gbest_x[i] << "; ";
    }   
    cout << "]\n";
    
    // update
    vector<double> gbest_x(n_dimensions, 0);
    gbest_x=ParticleSwarmOptimizer(&rosenbrock, n_particles, x_domain, alg_param);
    // x best
    cout << "Optimal x_best: \n";
    cout << "["; 
    for (int i=0; i<n_dimensions; i++) {
        cout << gbest_x[i] << "; ";
    }   
    cout << "]\n";

    //swarm_class= new swarm(n_particles, dimensions);
 }
 