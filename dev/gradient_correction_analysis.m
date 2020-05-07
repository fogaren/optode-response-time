addpath(genpath('../'))

z = 0:200;
t = assign_times(0, z, 15);
tau = 75;

w = 10:40;

max_grad = nan(size(w));
max_grad_delta = nan(size(w));

fid = fopen('gradient_correction_data.csv', 'w');
fprintf(fid, 'max_gradient, correction_delta');

for ii = 1:numel(w)
    y = hyperbolic_tan(z, 40, 170, w(ii), 100); 
    y_corr = correct_oxygen_profile(t, y, tau);

    grad = diff(y)./diff(z);
    max_grad(ii) = max(abs(grad));
    max_ix = find(abs(grad) == max_grad(ii),1,'first');

    delta = abs(y_corr - y);
    max_grad_delta(ii) = delta(max_ix+1);
    
    fprintf(fid, '\n%.5f, %.5f', max_grad(ii), max_grad_delta(ii));
    
end

fclose(fid);

scatter(max_grad, max_grad_delta)

function y = hyperbolic_tan(z,A,b,w,z0)
    y = A*tanh(-(z-z0)/w) + b;
end

function time = assign_times(start,depth,velocity)
    % input variables
    % start: vector of profile start times - dims(t)
    % depth: profile depth - dims(z,t)
    % velocity: profiling speed in cm/s - scalar

    cms_md = 60*60*24/100;
    time = nan(size(depth));
    time(1) = start;
    for jj=2:numel(depth)
        prac_vel = cms_md*velocity;
        delta_t  = abs((depth(jj)-depth(jj-1))/prac_vel);
        time(jj) = delta_t + time(jj-1);
    end
end