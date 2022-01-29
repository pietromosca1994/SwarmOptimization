#ifndef SWARM_CLASS
#define SWARM_CLASS

#include "common.h"
#include "utils.h"

// type definitions
struct domain_struct{
        vector<double> hi;      // hi domain boundaries
        vector<double> lo;      // lo domain boundaries
};

// class definition
class swarm {
        public: 
        // properties 
        int n_particles;
        int n_dimensions;
        domain_struct x_domain;
        domain_struct v_domain;
        vector<vector<double>> x;
        vector<double> y;
        vector<vector<double>> v;
        vector<vector<double>> pbest_x;
        vector<double> pbest_y;
        vector<double> gbest_x;
        double gbest_y;
        
        // constructor
        swarm (int _n_particles, domain_struct _x_domain, double (*func)(vector<double>)); // constructor
        
        // methods
        void clipx();
};

#endif
