function [ ] = assign_pso_tasks(nps,verbose)
%ASSIGN_PSO_TASKS Submits sbatch calls, each of which will run the model and then run the
%subroutine 'do_pso_task()' to process it's output and report back.
%   Detailed explanation goes here

%----------------------------------------------------------------------------------------------%
% Set a each other particle running.
%----------------------------------------------------------------------------------------------%
for i = 1:nps
   dir    = ['particle_' num2str(i)];                             % Set particle directory
   obj_name = './particle_obj.mat';
   out_name = './particle_out.mat';
   cd(dir)
   if exist(obj_name,'file')
      delete(obj_name)                                            % Delete old particle data
      vdisp(['file removed: ' obj_name],1,verbose)
   end
   if exist(out_name,'file')
      delete(out_name)                                            % Delete old particle data
      vdisp(['file removed: ' out_name],1,verbose)
   end
   setenv('PARTICLE_NUM',num2str(i))
   
   if verbose >= 1
      !sbatch ./run_particle.sh $PARTICLE_NUM
   else
      !sbatch ./run_particle.sh $PARTICLE_NUM 1>/dev/null
   end
   
   cd('../')
end
vdisp(['Particles 1 through ' num2str(nps) ' submitted...'],0,verbose)

%----------------------------------------------------------------------------------------------%
% Run particle 1 on this node.
%----------------------------------------------------------------------------------------------%
% dir = 'particle_1';                                               % Set particle directory
% cd(dir)
% if exist(fname,'file')
%    delete(fname)                                                   % Delete old particle data
% end
% setenv('PARTICLE_NUM',num2str(1))
% !./run_particle.sh $PARTICLE_NUM
% cd('../')

end
