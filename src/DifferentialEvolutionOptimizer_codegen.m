%% Test script for the algorithm Particle Swarm Optimizer for code generation
%% Author: Pietro Mosca
%% Email: pietromosca1994@gmail.com
%% Date: 04.02.2021

%% Arguments
% alg_param         struct
%                   with fields     n_iter              float    number of iterations
%                                   CR                  float    Crossover Probability [0,1]
%                                   F                   float    differential weight [0,2]
% swarm_param       struct
%                   with fields     n_particles         float    number of swarm particles 
%                                   n_dimensions        float    number of swarm dimensions
%                                   sampling_method     string   sampling method
%                                   x_domain            struct   swarm defintion domain 

function [X_opt, y_opt]=DifferentialEvolutionOptimizer_codegen(alg_param, swarm_param)  
    
    %% swarm initialization
    % Initialize particle positions
    swarm_n_particles=swarm_param.n_particles;
    swarm_n_dimensions=swarm_param.n_dimensions;
    swarm_x_domain=swarm_param.x_domain;
    
    swarm_x=zeros(swarm_n_particles, swarm_n_dimensions);
    if strcmp(swarm_param.sampling_method, 'Uniform')
        % xi ~ U(blo, bup) where U Uniform Distribution
        for i=1:swarm_n_particles
            swarm_x(i,:)=(swarm_x_domain.hi-swarm_x_domain.lo).*rand(1, swarm_n_dimensions)+swarm_x_domain.lo;
        end
        
    elseif strcmp(swarm_param.sampling_method, 'Normal')
        for i=1:swarm_n_particles
            swarm_x(i,:)=(swarm_x_domain.hi-swarm_x_domain.lo).*randn(1, swarm_n_dimensions)+swarm_x_domain.lo;
        end
    elseif strcmp(swarm_param.sampling_method, 'Cauchy')
        % Generate Cauchy Random Numbers Using Student's (needs
        % Statistics and Machine Learning Toolbox)
        %swarm_x=(domain.hi-domain.lo).*trnd(1,swarm_n_particles, swarm_n_dimensions)+domain.lo;

        % using CDF
        % (https://en.wikipedia.org/wiki/Cauchy_distribution)
        location=0;
        scale=1;
        for i=1:swarm_n_particles
            swarm_x(i,:)=location+scale.*tan(pi.*(rand(1, swarm_n_dimensions)-0.5));
        end 
        % using the property that the ratio of two Normal
        % distributions is Cauchy distributed
        % (https://math.stackexchange.com/questions/484395/how-to-generate-a-cauchy-random-variable)
        %swarm_x=(domain.hi-domain.lo).*randn(swarm_n_particles, swarm_n_dimensions)./randn(swarm_n_particles, swarm_n_dimensions)+domain.lo;
    end

    % Initialize particles costs 
    % possibility of eliminating for loop for improved performance
    % with broadcasting
    swarm_y=zeros(1, swarm_n_particles);
    
    for i=1:swarm_n_particles
        swarm_y(i)=sphere(swarm_x(i,:));
    end    
   
    % Initialize particles personal best positions and cost
    swarm_pbest_x=swarm_x;
    swarm_pbest_y=swarm_y;

    % Initialize global best position and cost
    swarm_gbest_y=min(swarm_y);
    swarm_gbest_x=swarm_x(swarm_y==swarm_gbest_y, :);
    
    %% optimization
    n_iter=1;
    
    while n_iter<alg_param.n_iter
        %topology.update_position(swarm, alg_param, fun);
        %% update position
          n=3; % random of random particles
          
          % initialization
          t_swarm_x=zeros(1,swarm_n_dimensions);
          
          for i=1:swarm_n_particles
            % Update process initialization
            
            swarm_x_cp=swarm_x;
            swarm_x_cp(i, :)=[];
            n_random=swarm_x_cp(randi(swarm_n_particles-1, 1, n),:);
            
            R=randi(swarm_n_dimensions);
            r=rand(1,swarm_n_dimensions);

            update_mask=logical((r<alg_param.CR | (1:swarm_n_dimensions)==R));
            % Update swarm position
            t_swarm_x(update_mask)=n_random(1,update_mask)+alg_param.F*(n_random(2,update_mask)-n_random(3,update_mask)); % temporary swarm x
            t_swarm_x(not(update_mask))=swarm_x(i, not(update_mask));

            % Clip swarm position
            % Hi-bound clipping
            t_swarm_x=min(t_swarm_x, swarm_x_domain.hi);
            % Lo-bound clipping
            t_swarm_x=max(t_swarm_x, swarm_x_domain.lo);
            
            t_swarm_y=sphere(t_swarm_x); % temporary swarm y

            if t_swarm_y<swarm_y(i) % in case the function evaluation is lower than original
              % Update swarm personal cost 
              % possibility of eliminating for loop for improved performance
              swarm_y(i)=t_swarm_y;
              % update personal best y
              swarm_pbest_y(i)=t_swarm_y;
              % Update swarm personal position
              swarm_x(i,:)=t_swarm_x;
              % update personal best y
              swarm_pbest_x(i, :)=t_swarm_x;   
            end

          end
        
        
        %% update_gbest
        opt=min(swarm_y);
        if opt<swarm_gbest_y
            swarm_gbest_y=opt;
            % in case multiple points are in an optimal, select one
            % randomly
            x_opt=swarm_x(swarm_y==opt,:);
            swarm_gbest_x=x_opt(randi(size(x_opt,1)),:);
        end
        
        %% update iteration
        n_iter=n_iter+1;
    end

X_opt=swarm_gbest_x;
y_opt=swarm_gbest_y;

end       