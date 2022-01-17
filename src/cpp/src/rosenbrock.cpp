#include "rosenbrock.h"

double rosenbrock(vector<double> x){
    double y=0;

    for(int i=0; i<int(x.size())-1; i++){
        y+=100*pow((x[i+1]-pow(x[i], 2)), 2)+pow((x[i]-1), 2);
    }
    return y;
}