
function [new_x_locations] = flexible_step (pausing_time_remaining, old_x_locations, number_of_motors, max_distance_between_motors)
    moving_forward = zeros(number_of_motors,1);
    [last_motor_x, last_motor_index] = min(old_x_locations);
    for i=1:number_of_motors
        % if distance between neighbors is less than max_distance_between_motors
        % or if the motor is at the back and is not pausing go forward one step
        if (i == 1)
            neighbors = i+1;
        elseif (i==number_of_motors)
            neighbors = i-1;
        else
            neighbors = [i-1,i+1];
        end
        neighbor_distance = abs(old_x_locations(neighbors)-old_x_locations(i));
        neighbors_are_close_enough = all(neighbor_distance<max_distance_between_motors);
        is_last_motor = (i==last_motor_index);
        is_not_pausing = pausing_time_remaining(i)==0;
        if ((neighbors_are_close_enough || is_last_motor) && is_not_pausing)
            moving_forward(i,1) = 1;
        end
    end  
    new_x_locations = old_x_locations+moving_forward;
endfunction
