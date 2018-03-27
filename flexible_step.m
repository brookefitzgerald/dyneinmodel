
function [new_x_locations] = flexible_step (pausing_time_remaining, old_x_locations, number_of_motors, max_distance_between_motors)
    % initializing variable to store how much each motor will move forward
    moving_forward = zeros(number_of_motors,1);
    % find the motor that is the furthest behind
    [last_motor_x, last_motor_index] = min(old_x_locations);
    for i=1:number_of_motors
        % find the index of each motor's neighbors
        if (i == 1)
            neighbors = i+1;
        elseif (i==number_of_motors)
            neighbors = i-1;
        else
            neighbors = [i-1,i+1];
        end
        % figure out if this motor's neighbors are holding it back
        if (number_of_motors==1)
            %if there is only one motor it has no neighbors, so neighbors aren't holding it back
            neighbors_are_close_enough=1;
        else 
            % find the distance between each neighbor
            neighbor_distance = abs(old_x_locations(neighbors)-old_x_locations(i));
            % make sure all neighbors are close enough for the motor to move
            neighbors_are_close_enough = all(neighbor_distance<max_distance_between_motors);
        end
        % check if this is the last motor
        is_last_motor = (i==last_motor_index);
        % check if this motor is pausing
        is_not_pausing = pausing_time_remaining(i)==0;
        
        %%%%%%%%%%%%%% PUT IN YOUR CODE HERE %%%%%%%%%%%%%%%%%%%%%
        % some ideas for extending the model
        
        % compute if the current motor's neighbors are at the maximum distance 
        % in front of the current motor
        
        % compute if the neighbors have been pulling at the maximum distance
        % for long enough to stop pausing (conduct simulations to see how long that should be)
        
        % if the motor is no longer pausing, create a variable called 
        % `has_enough_force` to stop pausing and change the variable `no_longer_pausing`
        % below to depend on `has_enough_force`
        
        % if the motor has been pulled forward, make sure the motor is no longer pausing 
        
        % if this motor is being pulled forward, does it pull its neighboring 
        % motors backwards like a spring?
                
        % what else can you think of that would affect whether or not a motor will step? 
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % if the motor can move forward and is not pausing go forward one step
        can_move_forward = (neighbors_are_close_enough || is_last_motor || (number_of_motors==1));
        no_longer_pausing = is_not_pausing;
        if (can_move_forward && no_longer_pausing)
            moving_forward(i,1) = 1;
        end
    end  
    new_x_locations = old_x_locations+moving_forward;
endfunction
