%% Test script for the algorithm Particle Swarm Optimizer
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

clear all;
clc;

addpath('../benchmark_functions');
addpath('../');

% domain definition
% for Rosenbrock
domain.hi=[5, 5, 5];
domain.lo=[-5, -5, -5];

% for Sphere
% domain.hi=[2,2];
% domain.lo=[1,1];

% Algorithm Parameter Definition
alg_param.n_iter=200;                          % float    number of iterations
alg_param.CR=0.9;                             % float    Crossover Probability [0,1]
alg_param.F=0.8;                              % float    differential weight [0,2]

% Swarm Parameters Definition
swarm_param.n_particles=50;                   % float    number of swarm particles 
swarm_param.sampling_method='Uniform';        % string   sampling method
swarm_param.x_domain=domain;                  % struct   swarm defintion domain 

fun_arg=[];

% optimization
[X_opt, y_opt]=DifferentialEvolutionOptimizer_codegen(alg_param, swarm_param, fun_arg);

disp(['X_opt: ', num2str(X_opt)]);
disp(['y_opt: ', num2str(y_opt)]);