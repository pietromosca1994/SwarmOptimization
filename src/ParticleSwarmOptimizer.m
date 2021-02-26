%% Implementation of the Particle Swarm Optimization Algorithm
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021
%% Reference: Kennedy, J.; Eberhart, R. (1995). "Particle Swarm Optimization". Proceedings of IEEE International Conference on Neural Networks. IV. pp. 1942–1948.

% Arguments
% fun:     function handle
% n_iter   int          iterations limit
% domain   struct(fields: hi, lo)   search domain
% swarm_param   struct(fields: n_particles, dimensions, sampling_method)
% alg_param     struct(fields: w, c1, c2)

function [gbest_x, gbest_y, log]=ParticleSwarmOptimizer(fun, swarm, topology, n_iter, domain, alg_param, verbose, log_active) 
    i=1;
    
    % Algorithm
    while i<n_iter

        topology.update_position(swarm, alg_param, fun);
        topology.update_velocity(swarm, alg_param);
        topology.update_best(swarm);
        
        if verbose>0
            if rem(i, verbose)==0
                figure('Name', ['Step', num2str(i)]);
                swarm.plot(fun, domain);
            end
        end
        
        if log_active==true
            log.gbest_x(i, :)=swarm.gbest_x;
            log.gbest_y(i)=swarm.gbest_y;
        end
        i=i+1;
    end
    
    gbest_x=swarm.gbest_x;
    gbest_y=swarm.gbest_y;
    
end
