clear all;

addpath('./test_functions');

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
swarm.init(100,2,'Uniform', domain, fun);

% plotting swarm
figure();
swarm.plot()

% topology 
topology=topology;
topology.update_position(swarm, fun);
topology.update_velocity(swarm, param);

% plotting swarm
figure();
swarm.plot()





