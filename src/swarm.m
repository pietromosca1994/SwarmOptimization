%% Class Swarm
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

classdef swarm<handle
    properties
        x;              % array(n_particles, dimensions)    position-matrix at a single timestep  
        v;              % array(n_particles, dimensions)    velocity-matrix at a single timestep
        n_particles;    % int                               number of particles in the population
        dimensions;     % int                               number of dimensions
        options;        % struct                            options that govern the swarm behaviour
        pbest_x;        % array(n_particles, dimensions)    personal best positions of each particle
        gbest_x;         % array(dimensions, particles)(for star topology) (dimensions,) for other topologies  best position found by the swarm
        pbest_y;        % array(n_particles, dimensions)    personal best cost of each of the particles   
        gbest_y;        % float                             best cost found by the swarm
        y;              % array(n_particles, dimensions)    current cost found by the swarm
    end
    
    methods
        %% Initialization function
        % Arguments:
        % n_particles:      int
        % sampling method   str (acceptable parameters are 'Uniform',
        % 'Normal', 'Cauchy'
        % domain:           struct with fields hi, lo
        % 
        
        function init(obj, n_particles, dimensions, sampling_method, x_domain, fun)
            
            % Initialize particle positions
            obj.n_particles=n_particles;
            obj.dimensions=dimensions;
                        
            if strcmp(sampling_method, 'Uniform')
                % xi ~ U(blo, bup) where U Uniform Distribution
                obj.x=(x_domain.hi-x_domain.lo).*rand(obj.n_particles, obj.dimensions)+x_domain.lo;
            elseif strcmp(sampling_method, 'Normal')
                obj.x=(x_domain.hi-x_domain.lo).*randn(obj.n_particles, obj.dimensions)+x_domain.lo;
            elseif strcmp(sampling_method, 'Cauchy')
                % Generate Cauchy Random Numbers Using Student's (needs
                % Statistics and Machine Learning Toolbox)
                %obj.x=(domain.hi-domain.lo).*trnd(1,obj.n_particles, obj.dimensions)+domain.lo;
                
                % using CDF
                % (https://en.wikipedia.org/wiki/Cauchy_distribution)
                location=0;
                scale=1;
                obj.x=location+scale.*tan(pi.*(rand(obj.n_particles, obj.dimensions)-0.5));
                
                % using the property that the ratio of two Normal
                % distributions is Cauchy distributed
                % (https://math.stackexchange.com/questions/484395/how-to-generate-a-cauchy-random-variable)
                %obj.x=(domain.hi-domain.lo).*randn(obj.n_particles, obj.dimensions)./randn(obj.n_particles, obj.dimensions)+domain.lo;
            end
            
            % Initialize particles costs 
            % possibility of eliminating for loop for improved performance
            % with broadcasting
            for i=1:n_particles
                obj.y(i)=fun(obj.x(i,:));
            end    
            
            % Initilize velocity
            % vi ~ U(-|bup-blo|, |bup-blo|) where U uniform distribution
            v_domain.hi=abs(x_domain.hi-x_domain.lo);
            v_domain.lo=-v_domain.hi;
            obj.v=(v_domain.hi-v_domain.lo).*rand(obj.n_particles, obj.dimensions)+v_domain.lo;
            
            % Initialize particles personal best positions and cost
            obj.pbest_x=obj.x;
            obj.pbest_y=obj.y;
            
            % Initialize global best position and cost
            obj.gbest_y=min(obj.y);
            obj.gbest_x=obj.x(obj.y==obj.gbest_y, :);
                     
        end
        
        %% plot current particle scatter distribution
        % obj
        function plot(obj, domain)
            % 2D particle visualization
            subplot(1,2,1);

            scatter(obj.x(:, 1), obj.x(:, 2));  
            
            xlabel('x_1');
            ylabel('x_2');
            xlim([domain.lo(1)+domain.lo(1)*0.1, domain.hi(1)+domain.hi(1)*0.1]);
            ylim([domain.lo(2)+domain.lo(2)*0.1, domain.hi(2)+domain.hi(2)*0.1]);
            
            hold on;
            
            % plot velocity vector field
            quiver(obj.x(:, 1), obj.x(:, 2), obj.v(:,1), obj.v(:,2));
            
            % 3D particle visualization
            subplot(1,2,2)
            % plot particle position
            
            scatter3(obj.x(:, 1), obj.x(:, 2), obj.y);
            
            xlabel('x_1');
            ylabel('x_2');
            xlim([domain.lo(1)+domain.lo(1)*0.1, domain.hi(1)+domain.hi(1)*0.1]);
            ylim([domain.lo(2)+domain.lo(2)*0.1, domain.hi(2)+domain.hi(2)*0.1]);
            zlabel('y');
           
         end
    end
         
end
