#include "sphere.h"

double sphere(vector<double> x){
    double y=0;
    
    for (int i=0; i<int(x.size()); i++){
        y+=x[i]*x[i];
    }

    return y;
}