
function [new_x_locations] = rigid_step (pausing_time_remaining, old_x_locations)
    if all(pausing_time_remaining==0)
    % if no motors are pausing, go forward one step
        new_x_locations= old_x_locations+1;
    else% otherwise don't move
        new_x_locations= old_x_locations;
    end
endfunction
