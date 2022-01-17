#ifndef SWARM_CLASS
#define SWARM_CLASS

#include <iostream>
#include <vector>
#include <algorithm>
#include <stdlib.h> // rand 
using namespace std;

class swarm {
        public: // properties 
        int n_particles;
        int dimensions;
        vector<vector<double>> x;
        vector<double> y;
        vector<vector<double>> v;
        vector<vector<double>> pbest_x;
        vector<vector<double>> gbest_x;
        vector<double> pbest_y;
        double gbest_y;
        
        swarm ( int _n_particles, int _dimensions, double (*func)(vector<double>));
};

#endif
