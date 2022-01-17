#include "swarm.h"
#include "sphere.h"
#include "rosenbrock.h"

int main(){
    int n_particles = 10;
    int dimensions = 3;

    swarm swarm_class(n_particles, dimensions, &rosenbrock);

    cout << "n_particles: " << swarm_class.n_particles << "\n";
    cout << "dimensions: " << swarm_class.dimensions << "\n";
    cout << "size: " << swarm_class.x.size();

    cout << "x: \n";
    for (int i=0; i<swarm_class.n_particles; i++) {
        cout << "["; 
        for (int j=0; j<swarm_class.dimensions; j++) {
            cout << swarm_class.x[i][j] << "; ";
        }
        cout << "]\n";
    }

    cout << "y: \n";    
    cout << "["; 
    for (int i=0; i<swarm_class.n_particles; i++) {
        cout << swarm_class.y[i] << "; ";
    }
    cout << "]\n";





    return 0;
    //swarm_class= new swarm(n_particles, dimensions);
 }
 