%% Test script for the algorithm Particle Swarm Optimizer
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
domain.hi=[2 3, 3, 3];
domain.lo=[-1.5 -0.5, -1, -1];

% for Sphere
% domain.hi=[2,2];
% domain.lo=[1,1];

% Algorithm Parameter Definition
alg_param.algorithm='ParticleSwarm';  % algorithm used for update           
alg_param.n_iter=50;                  % float    number of iterations
alg_param.w=0.1;                      % velocity associated parameter
alg_param.c1=0.5;                     % personal best position coefficient
alg_param.c2=0.2;                     % global best position coefficient
alg_param.lr=1;                       % learning rate

% Swarm Parameters Definition
swarm_param.n_particles=200;
swarm_param.sampling_method='Uniform';

% Swarm Initilaization
swarm=swarm;
swarm.init(swarm_param.n_particles, swarm_param.sampling_method, domain, fun);

% Topology initilization
topology=topology;
topology.init(alg_param.algorithm);

[gbest_x, gbest_y, log]=ParticleSwarmOptimizer(fun, swarm, topology, domain, alg_param, verbose, log_active);
disp(['X_best', num2str(gbest_x)]);
disp(['Y_best', num2str(gbest_y)]);

figure()
plot(log.gbest_y);
xlabel('Steps')
ylabel('Best Cost')
set(gcf,'color','w');