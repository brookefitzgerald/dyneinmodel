%% constantssteps_per_second = 17;distance_per_step = 8; %nanometersrun_length = 1000; %nanometersseconds_to_simulate = 100;n_steps = steps_per_second*seconds_to_simulate;%% parameters - change thesepause_rate = 0.01; % fraction of time a motor pausespause_duration = 3; % how many steps pausemax_distance_between_motors = 3; % nanometers% initialize variablespossible_motors = [1; 2; 4; 7];n_motors = size(possible_motors);n_simulations = 25;steps_reached_per_motor_per_simulation = zeros(2,n_motors, n_simulations, n_steps);for j=1:n_motors    for sim=1:n_simulations        %% initializing variables        number_of_motors = possible_motors(j);        rigid_x_list = zeros(number_of_motors, n_steps);        rigid_x_list(:,1) = (1:number_of_motors)*(max_distance_between_motors-1);                flexible_x_list = zeros(number_of_motors, n_steps);        flexible_x_list(:,1) = (1:number_of_motors)*(max_distance_between_motors-1);        pausing_time_remaining = zeros(1,number_of_motors);        % starting simulation        for t=2:n_steps            % loop through every motor            for i=1:number_of_motors                % if motor i has been pausing, decrease the number of pausing steps remaining                if pausing_time_remaining(i)>0                    pausing_time_remaining(i) = pausing_time_remaining(i)-1;                elseif rand <=pause_rate                % if motor i is not pausing then randomly start pausing                    pausing_time_remaining(i) = pause_duration;                end            end            % take rigid steps            rigid_x_list(:,t) = rigid_step(pausing_time_remaining, rigid_x_list(:,t-1));            % take flexible steps            flexible_x_list(:,t) = flexible_step(pausing_time_remaining, flexible_x_list(:,t-1), number_of_motors, max_distance_between_motors);        end                % get the average x value at every time step between all motors        average_rigid_x_list = mean(rigid_x_list,1);        average_flexible_x_list = mean(flexible_x_list,1);                % store the average values        steps_per_motor_per_sim(1,j,sim,:) = average_rigid_x_list;        steps_per_motor_per_sim(2,j,sim,:) = average_flexible_x_list;    endend% convert # steps to nmdistance_per_motor_per_sim = distance_per_step*steps_per_motor_per_sim;% get the final distances reached by every motorfinal_distances = distance_per_motor_per_sim(:,:,:,end);% convert nm to velocityfinal_velocities = final_distances/seconds_to_simulate;% plot the average velocity each number of motors reached at the last time step and SEmean_velocity = mean(final_velocities, 3);velocity_standard_deviations = std(final_velocities,0,3);velocity_standard_errors = velocity_standard_deviations/sqrt(n_simulations);plt = errbarplot(mean_velocity,velocity_standard_errors);legend(plt, {'rigid','flexible'});set(gca,'xticklabel',possible_motors);xlabel('Number of Motors')ylabel('Overall Motor Speed (nm/s)')title("Velocity Reached per Number of Motors")axis tightfigure% plot the average distance each number of motors reached at the last time step and SEmean_distances = mean(final_distances, 3);distance_standard_deviations = std(final_distances,0,3);distance_standard_errors = distance_standard_deviations/sqrt(n_simulations);plt = errbarplot(mean_distances,distance_standard_errors);legend(plt, {'rigid','flexible'});set(gca,'xticklabel',possible_motors);xlabel('Number of Motors')ylabel('Overall Motor Distance (nm)')title("Distance Reached per Number of Motors")axis tight