#ifndef UTILS
#define UTILS

#include "common.h"

// vector operations 
int mulVectorScalar(vector<double> v1, double k, vector<double> &v2);
int sumVectors(vector<double> v1, vector<double> v2, vector<double> &v3);
int subVectors(vector<double> v1, vector<double> v2, vector<double> &v3);
int mulVectors(vector<double> v1, vector<double> v2, vector<double> &v3);
int absVector(vector<double> v1, vector<double> &v2);

// print
int printVector(vector<double> v1);

#endif
