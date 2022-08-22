%% Test script for the classes swarm and topology
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

clear all;

addpath('../benchmark_functions');
addpath('../')

fun=@sphere;

% domain defintion
domain.hi=[1,1];
domain.lo=[-1,-1];

% parameter definition
param.w=1;
param.c1=1;
param.c2=1;

% swarm initialization
swarm=swarm;
swarm.init(1000, 'Normal', domain, fun);

% plotting swarm
figure();
swarm.plot(fun, domain)

% topology 
topology=topology;
topology.update_position(swarm, fun);
topology.update_velocity(swarm, param);

% plotting swarm
figure();
swarm.plot(fun, domain)





