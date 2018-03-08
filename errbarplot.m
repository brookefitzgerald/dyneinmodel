function [barplot] = errbarplot (data, errors)
    % data should be in shape [motor_type (comparison per group), num_motors (group)]
    barplot = bar(data');
    colors = lines(2);
    set(barplot(1), 'facecolor', colors(1,:))
    set(barplot(2), 'facecolor', colors(2,:))
    hold on;
    ngroups = size(data, 2);
    nbars = size(data, 1);
    % Calculating the width for each bar group
    groupwidth = min(0.8, nbars/(nbars + 0.8));
    for i = 1:nbars
        x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
        errorbar(x, data(i,:), errors(i,:), '.k');
    end
    hold off
endfunction
