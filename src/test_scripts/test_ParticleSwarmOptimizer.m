%% Test script for the algorithm Particle Swarm Optimizer
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

clear all;

addpath('../benchmark_functions');
addpath('../');

%% Input definition
n_iter=50;
verbose=10;
log_active=true;

% Objective Function
fun=@rosenbrock;

% domain defintion
domain.hi=[1,1];
domain.lo=[-1,-1];

% Algorithm Parameter Definition
alg_param.w=0.1;
alg_param.c1=0.5;
alg_param.c2=0.2;

% Swarm Parameters Definition
swarm_param.n_particles=100;
swarm_param.dimensions=2;
swarm_param.sampling_method='Uniform';

% Swarm Initilaization
swarm=swarm;
swarm.init(swarm_param.n_particles, swarm_param.dimensions, swarm_param.sampling_method, domain, fun);

% Topology initilization
topology=topology;

[gbest_x, gbest_y, log]=ParticleSwarmOptimizer(fun, swarm, topology, n_iter, domain, alg_param, verbose, log_active);
disp(['X_best', num2str(gbest_x)]);
disp(['Y_best', num2str(gbest_y)]);

figure()
plot(log.gbest_y);