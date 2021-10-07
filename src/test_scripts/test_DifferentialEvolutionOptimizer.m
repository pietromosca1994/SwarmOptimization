%% Test script for the algorithm Differential Swarm Optimizer
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

clear all;

addpath('../benchmark_functions');
addpath('../');
    
%% Input definition
verbose=10;
log_active=true;

% Objective Function
fun=@rosenbrock;

% domain definition
% for Rosenbrock
% domain.hi=[2, 3];
% domain.lo=[-1.5, -0.5];

domain.hi=[2, 3, 3];
domain.lo=[-1.5, -0.5, -1.5];

% for Sphere
% domain.hi=[2,2];
% domain.lo=[1,1];

% Algorithm Parameter Definition
alg_param.algorithm='DifferentialEvolution';  % algorithm used for update
alg_param.n_iter=100;                          % float    number of iterations
alg_param.CR=0.9;                             % float    Crossover Probability [0,1]
alg_param.F=0.8;                              % float    differential weight [0,2]

% Swarm Parameters Definition
swarm_param.n_particles=20;
swarm_param.dimensions=3;
swarm_param.sampling_method='Uniform';

% Swarm Initilaization
swarm=swarm;
swarm.init(swarm_param.n_particles, swarm_param.dimensions, swarm_param.sampling_method, domain, fun);

% Topology initilization
topology=topology;
topology.init(alg_param.algorithm);

[gbest_x, gbest_y, log]=DifferentialEvolutionOptimizer(fun, swarm, topology, domain, alg_param, verbose, log_active);
disp(['X_best:    ', num2str(gbest_x)]);
disp(['Y_best     ', num2str(gbest_y)]);

figure()
plot(log.gbest_y);




