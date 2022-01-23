%% Topology Class
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

classdef topology<handle
    properties
        algorithm;
    end % end of properties
    
    methods
        %% Initilization function
        % algorithm 
        function [obj]=init(obj, algorithm)
            obj.algorithm=algorithm;
        end
               
        %% Update global best
        % swarm: swarm object
        function update_gbest(obj, swarm)
            opt=min(swarm.y);
            if opt<swarm.gbest_y
                swarm.gbest_y=opt;
                % in case multiple points are in an optimal, select one
                % randomly
                x_opt=swarm.x(swarm.y==opt,:);
                swarm.gbest_x=x_opt(randi(size(x_opt,1)),:);
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
        function update_position(obj, swarm, alg_param, fun)
            
            %% ParticleSwarm update 
            if strcmp(obj.algorithm, 'ParticleSwarm')
              % Update swarm position based on velocity
              swarm.x=swarm.x+alg_param.lr*swarm.v;
              % Update swarm personal cost
              % possibility of eliminating for loop for improved performance
             
              % Clip swarm position
              % Hi-bound clipping
              swarm.x=min(swarm.x, swarm.x_domain.hi);
              % Lo-bound clipping
              swarm.x=max(swarm.x, swarm.x_domain.lo);
              
              for i=1:swarm.n_particles
                  swarm.y(i)=fun(swarm.x(i,:));
              end
            end
            
            %% DifferentialEvolution update
            if strcmp(obj.algorithm, 'DifferentialEvolution')
              n=3; % random of random particles
              for i=1:swarm.n_particles
                % Update process initialization
                n_random=obj.picknrandom(swarm, i, n);
                R=randi(swarm.n_dimensions);
                r=rand(1,swarm.n_dimensions);
                
                update_mask=logical((r<alg_param.CR | (1:swarm.n_dimensions)==R));
                % Update swarm position
                t_swarm_x(update_mask)=n_random(1,update_mask)+alg_param.F*(n_random(2,update_mask)-n_random(3,update_mask)); % temporary swarm x
                t_swarm_x(not(update_mask))=swarm.x(i, not(update_mask));
                
                % Clip swarm position
                % Hi-bound clipping
                t_swarm_x=min(t_swarm_x, swarm.x_domain.hi);
                % Lo-bound clipping
                t_swarm_x=max(t_swarm_x, swarm.x_domain.lo);
                
                t_swarm_y=fun(t_swarm_x); % temporary swarm y
                
                if t_swarm_y<swarm.y(i) % in case the function evaluation is lower than original
                  % Update swarm personal cost 
                  % possibility of eliminating for loop for improved performance
                  swarm.y(i)=t_swarm_y;
                  % update personal best y
                  swarm.pbest_y(i)=t_swarm_y;
                  % Update swarm personal position
                  swarm.x(i,:)=t_swarm_x;
                  % update personal best y
                  swarm.pbest_x(i, :)=t_swarm_x;   
                end
          
              end
              
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
                    alg_param.c1*rand(swarm.n_particles, swarm.n_dimensions).*(swarm.pbest_x-swarm.x)+...
                    alg_param.c2*rand(swarm.n_particles, swarm.n_dimensions).*(swarm.gbest_x-swarm.x);
        end
        
        %% Pick n random particles different from the i-th particle
        % swarm       swarm object          
        % i           float                 index of selected particle 
        % n           float                 number of random particles
        function [n_random]=picknrandom(obj, swarm, i, n)
         
          t_swarm_x=swarm.x;
          t_swarm_x(i, :)=[];
          n_random=t_swarm_x(randi(swarm.n_particles-1, 1, n),:);

        end
        
        %% Function to keep the particles in the optimization domain
        % swarm       swarm object          
        function SwarmXClip(obj, swarm)
            % Hi-bound clipping
            swarm.x=min(swarm.x, swarm.x_domain.hi);
            % Lo-bound clipping
            swarm.x=max(swarm.x, swarm.x_domain.lo);
        end
        
        
    end % end of methods
   
end % end of claasdef
