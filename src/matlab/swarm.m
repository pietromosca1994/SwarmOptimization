%% Class Swarm
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

classdef swarm<handle
    properties
        x;              % array(n_particles, n_dimensions)                  position-matrix at a single timestep  
        v;              % array(n_particles, n_dimensions)                  velocity-matrix at a single timestep
        n_particles;    % int                                               number of particles in the population
        n_dimensions;   % int                                               number of n_dimensions
        options;        % struct                                            options that govern the swarm behaviour
        pbest_x;        % array(n_particles, n_dimensions)                  personal best positions of each particle
        gbest_x;        % array(n_dimensions, particles)(for star topology) (n_dimensions,) for other topologies  best position found by the swarm
        pbest_y;        % array(n_particles, n_dimensions)                  personal best cost of each of the particles   
        gbest_y;        % float                                             best cost found by the swarm
        y;              % array(n_particles)                                current cost found by the swarm
        x_domain        % struct                                            generation domain
                        % with fields:     hi array(1, n_dimensions)
                        %                  lo array(1, n_dimensions)
    end
    
    methods
        %% Initialization function
        % Arguments:
        % n_particles:      int
        % sampling method   str (acceptable parameters are 'Uniform',
        % 'Normal', 'Cauchy'
        % domain:           struct with fields hi, lo
        % 
        
        function init(obj, n_particles, sampling_method, x_domain, fun)
            
            % Initialize particle positions
            obj.n_particles=n_particles;
            obj.x_domain=x_domain;
            if numel(obj.x_domain.hi)==numel(obj.x_domain.lo)
                obj.n_dimensions=numel(obj.x_domain.hi);
            else
                error('[ERROR] Size of domain.hi must be same as size of domain.lo');
            end
                        
            if strcmp(sampling_method, 'Uniform')
                % xi ~ U(blo, bup) where U Uniform Distribution
                random=rand(obj.n_particles, obj.n_dimensions);
                obj.x=(obj.x_domain.hi-obj.x_domain.lo).*random+obj.x_domain.lo;
            elseif strcmp(sampling_method, 'Normal')
                random=randn(obj.n_particles, obj.n_dimensions); % Gaussian distribution of random numbers 
                random=random./max(random); % reduce the Gaussian distribution between 0 and 1
                obj.x=(obj.x_domain.hi+obj.x_domain.lo)./2+random.*(obj.x_domain.hi-obj.x_domain.lo);
                %obj.x=(obj.x_domain.hi-obj.x_domain.lo).*random+obj.x_domain.lo;
            elseif strcmp(sampling_method, 'Cauchy')
                % Generate Cauchy Random Numbers Using Student's (needs
                % Statistics and Machine Learning Toolbox)
                %obj.x=(domain.hi-domain.lo).*trnd(1,obj.n_particles, obj.n_dimensions)+domain.lo;
                
                % using CDF
                % (https://en.wikipedia.org/wiki/Cauchy_distribution)
                location=0;
                scale=1;
                obj.x=location+scale.*tan(pi.*(rand(obj.n_particles, obj.n_dimensions)-0.5));
                
                % using the property that the ratio of two Normal
                % distributions is Cauchy distributed
                % (https://math.stackexchange.com/questions/484395/how-to-generate-a-cauchy-random-variable)
                %obj.x=(domain.hi-domain.lo).*randn(obj.n_particles, obj.n_dimensions)./randn(obj.n_particles, obj.n_dimensions)+domain.lo;
            end
            
            % Initialize particles costs 
            % possibility of eliminating for loop for improved performance
            % with broadcasting
            obj.y=zeros(1, obj.n_particles);
            for i=1:obj.n_particles
                obj.y(i)=fun(obj.x(i,:));
            end    
            
            % Initialize velocity
            % vi ~ U(-|bup-blo|, |bup-blo|) where U uniform distribution
            v_domain.hi=abs(obj.x_domain.hi-obj.x_domain.lo);
            v_domain.lo=-v_domain.hi;
            obj.v=(v_domain.hi-v_domain.lo).*rand(obj.n_particles, obj.n_dimensions)+v_domain.lo;
            
            % Initialize particles personal best positions and cost
            obj.pbest_x=obj.x;
            obj.pbest_y=obj.y;
            
            % Initialize global best position and cost
            obj.gbest_y=min(obj.y);
            obj.gbest_x=obj.x(obj.y==obj.gbest_y, :);
                     
        end
        
        %% plot current particle scatter distribution
        % obj
        function plot(obj, fun, domain)
            res=50; % grid resolution

            %% 2D optimization plot
            if size(obj.x, 2)==1
                % surface computation
                x_axis=linspace(domain.lo(1), domain.hi(1), res);
                
                for i=1:res
                    Z(i)=fun(x_axis(i));
                end
                
                plot(x_axis, Z);
                hold on;
                scatter(obj.x, obj.y, 'filled', 'MarkerFaceColor', '#D95319');
                
                xlabel('x');
                ylabel('y');
            
            %% 3D optimization plot
            elseif size(obj.x, 2)==2
            
            x_axis=linspace(domain.lo(1), domain.hi(1), res);
            y_axis=linspace(domain.lo(2), domain.hi(2), res);
            
            Z=zeros(res);
            for i=1:res
                for j=1:res
                    Z(i,j)=fun([x_axis(i), y_axis(j)]);
                end 
            end
            
                
            % 2D particle visualization
            subplot(1,2,1);
            
            contourf(x_axis, y_axis, Z');
            hold on
            scatter(obj.x(:, 1), obj.x(:, 2), 'filled', 'MarkerFaceColor', 'r');  

            xlabel('x_1');
            ylabel('x_2');
%             xlim([domain.lo(1)-domain.lo(1)*0.1, domain.hi(1)+domain.hi(1)*0.1]);
%             ylim([domain.lo(2)-domain.lo(2)*0.1, domain.hi(2)+domain.hi(2)*0.1]);
            xlim([domain.lo(1), domain.hi(1)]);
            ylim([domain.lo(2), domain.hi(2)]);

            hold on;
            
            % plot velocity vector field
            quiver(obj.x(:, 1), obj.x(:, 2), obj.v(:,1), obj.v(:,2));
            
            % 3D particle visualization
            subplot(1,2,2)
            % plot particle position
            
            % surface computation 
            %x_axis=linspace(min(obj.x(:,1)), max(obj.x(:,1)), res);
            %y_axis=linspace(min(obj.x(:,2)), max(obj.x(:,2)), res);          

            surf(x_axis, y_axis, Z', 'FaceAlpha',0.5);
            % contourf(x_axis, y_axis, Z')
            hold on;
            scatter3(obj.x(:, 1), obj.x(:, 2), obj.y, 'filled', 'MarkerFaceColor', 'r');
            % scatter(obj.x(:, 1), obj.x(:, 2));
            % plot velocity vector field
            % quiver(obj.x(:, 1), obj.x(:, 2), obj.v(:,1), obj.v(:,2));
           
            xlabel('x_1');
            ylabel('x_2');
            xlim([domain.lo(1)-domain.lo(1)*0.1, domain.hi(1)+domain.hi(1)*0.1]);
            ylim([domain.lo(2)-domain.lo(2)*0.1, domain.hi(2)+domain.hi(2)*0.1]);
            zlabel('y');
            set(gcf,'color','w');
            
            else
            %% n-D optimization plot
                for dim=1:size(obj.x, 2)
                    subplot(1, size(obj.x, 2), dim)
                    x_axis=linspace(domain.lo(dim), domain.hi(dim), res);


                    for j=1:size(obj.x, 2)
                        input(j)=obj.gbest_x(:,j);
                    end

                    % compute the function
                    for i=1:res
                        input(dim)=x_axis(i);
                        Z(i)=fun(input);
                    end

                    plot(x_axis, Z);
                    hold on;
                    scatter(obj.x(:, dim), obj.y, 'filled', 'MarkerFaceColor', 'r'); 
                    xlabel(['x_' num2str(dim)]);
                    ylabel('y');

                end
           end
    
         end
    end
         
end
