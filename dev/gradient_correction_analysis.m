addpath(genpath('../'))

z = 0:200;
y = hyperbolic_tan(z, 40, 170, 20, 100); 
t = assign_times(0, z, 15);

tau = 75;

y_corr = correct_oxygen_profile(t, y, tau);

grad = diff(y)./diff(z)
max_grad = max(grad);
max_ix = find(grad == max_grad,1,'first');

delta = abs(y_corr - y);
max_grad_delta = delta(max_ix);

plot(z,y,z,y_corr)

function y = hyperbolic_tan(z,A,b,w,z0)
    y = A*tanh(-(z-z0)/w) + b;
end

function time = assign_times(start,depth,velocity)
    % input variables
    % start: vector of profile start times - dims(t)
    % depth: profile depth - dims(z,t)
    % velocity: profiling speed in cm/s - scalar

    cms_md = 60*60*24/100;

    for ii=1:numel(start)
        time(1,ii) = start(ii);
        for jj=2:size(depth,1)
            prac_vel = cms_md*velocity;
            delta_t  = abs((depth(jj,ii)-depth(jj-1,ii))/prac_vel);
            time(jj,ii) = delta_t + time(jj-1,ii);
        end
    end
end