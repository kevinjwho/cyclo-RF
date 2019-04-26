%% pfag main

%% setup, run ONCE
addpath('PFAG','PFAG/util');
clc, clear
%instrreset; disp('reset'); % disconnect and close all instrument objects
p = tuner_initialize_pfag; disp('pfag initialized');

%% make arbitrary sine waveform
clc
numpts = 47;
t = linspace(0,2*pi,numpts);
p.data1 = sin(t);
for theta = 0:5:360 % in degrees
    p.data2 = sin(t+theta*pi/180); % convert to rad
    %fprintf(p.deviceObj,':FUNC2:USER');
    %fprintf(p.deviceObj,':FUNC2 USER');
    str = [':DATA2 VOLATILE, ',pfag_arr2str(p.data2)];
    %fprintf(p.deviceObj,str);
    figure(1), stem(t, p.data1); hold on,
    stem(t, p.data2); hold off;
    grid, legend('OUT1', 'OUT2');
    title(['theta = ' num2str(theta)]), pause(1/10)
end

%% to remove visa connections
instrfindall
delete(instrfindall)

%setprop_pfag(p); disp('sent prop');