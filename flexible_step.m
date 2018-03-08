
function [new_x_locations] = flexible_step (pausing_time_remaining, old_x_locations, number_of_motors, max_distance_between_motors)
    moving_forward = zeros(number_of_motors,1);
    [last_motor_x, last_motor_index] = min(old_x_locations);
    for i=1:number_of_motors
        % find the index of each motor's neighbor(s)
        if (number_of_motors==1)
            neighbors = 1;
        elseif (i == 1)
            neighbors = i+1;
        elseif (i==number_of_motors)
            neighbors = i-1;
        else
            neighbors = [i-1,i+1];
        end
        
        % find the distance between each neighbor
        neighbor_distance = abs(old_x_locations(neighbors)-old_x_locations(i));
        % make sure all neighbors are close enough for the motor to move
        neighbors_are_close_enough = all(neighbor_distance<max_distance_between_motors);
        % check if this is the last motor
        is_last_motor = (i==last_motor_index);
        % check if this motor is pausing
        is_not_pausing = pausing_time_remaining(i)==0;
        
        can_move_forward = (neighbors_are_close_enough || is_last_motor || (number_of_motors==1));
        if (can_move_forward && is_not_pausing)
            moving_forward(i,1) = 1;
        end
    end  
    new_x_locations = old_x_locations+moving_forward;
endfunction
