#include "sphere.h"

double sphere(vector<double> x){
    double y=x[0];
    
    for (int i=1; i<int(x.size()); i++){
        y*=x[i];
    }

    return y;
}