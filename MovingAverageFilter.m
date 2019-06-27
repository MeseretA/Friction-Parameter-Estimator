function out = MovingAverageFilter(yourInputSignal)
windowWidth = 50; % Whatever you want.
kernel = ones(windowWidth,1) / windowWidth;
out = filter(kernel, 1, yourInputSignal);
end