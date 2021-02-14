%% Topology Class
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

classdef topology<handle
    properties
        algorithm;
    end
    
    methods
        %% Initilization function
        % algorithm 
        function [obj]=init(obj, algorithm)
            obj.algorith=algorithm;
        end
        
        %% Update best (both global and personal
        % swarm: swarm object
        function update_best(obj, swarm)
            obj.update_gbest(swarm);
            obj.update_pbest(swarm);
        end
        
        %% Update global best
        % swarm: swarm object
        function update_gbest(obj, swarm)
            opt=min(swarm.y);
            if opt<swarm.gbest_y
                swarm.gbest_y=opt;
                swarm.gbest_x=swarm.x(swarm.y==opt,:);
            end
        end
        
        %% Update personal best
        % swarm: swarm object
        function update_pbest(obj, swarm)
                mask=swarm.y<swarm.pbest_y;
                swarm.pbest_y(mask)=swarm.y(mask);
                swarm.pbest_x(mask, :)=swarm.x(mask, :);
        end
        
        %% Update position
        % swarm: swarm object
        function update_position(obj, swarm, fun)
            % Update swarm position based on velocity
            swarm.x=swarm.x+swarm.v;
            % Update swarm personal cost
            % possibility of eliminating for loop for improved performance
            for i=1:swarm.n_particles
                swarm.y(i)=fun(swarm.x(i,:));
            end
        end
        
        %% Update Velocity
        % swarm:    swarm object
        % param:    struct
        %               fields:     w: velocity associated parameter
        %                           c1: personal best position coefficient
        %                           c2: global best position coefficient 
        function update_velocity(obj, swarm, alg_param)
            swarm.v=alg_param.w*swarm.v+...
                    rand(1)*alg_param.c1*(swarm.pbest_x-swarm.x)+...
                    rand(1)*alg_param.c2*(swarm.gbest_x-swarm.x);
        end
    end
   
end
