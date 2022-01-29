#include "utils.h"

// function to multiply a vector by a scalar
int mulVectorScalar(vector<double> v1, vector<double> &v2, double k){
    transform(v1.begin(), v1.end(), v2.begin(), [k](double &c){ return c*k; });
    return 0;
}

// function to sum two vectors of the same size
int sumVectors(vector<double> v1, vector<double> v2, vector<double> &v3){
    // check inputs
    if (int(v1.size())==int(v2.size()) && \
        int(v1.size())==int(v3.size())){
        transform(v1.begin(), v1.end(), v2.begin(),
                    v3.begin(), std::plus<double>());
        return 0;
    }else{
        throw invalid_argument("[ERROR] v1 and v2 do not have the same size");
        return 1;
    };
};

// function to substract two vectors of the same size
int subVectors(vector<double> v1, vector<double> v2, vector<double> &v3){
    // check inputs
    if (int(v1.size())==int(v2.size()) && \
        int(v1.size())==int(v3.size())){
        transform(v1.begin(), v1.end(), v2.begin(),
                    v3.begin(), std::minus<double>());
        return 0;
    }else{
        throw invalid_argument("[ERROR] v1 and v2 do not have the same size");
        return 1;
    };
};

int absVector(vector<double> v1, vector<double> &v2){
    for (int i=0; i<int(v1.size()); i++){
        if (v1[i]<0){
            v2[i]=v1[i]*-1;
        }else{
            v2[i]=v1[i];
        };
    };
    return 0;
}