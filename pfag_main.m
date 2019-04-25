%% pfag main

%% setup, run ONCE
addpath('PFAG','PFAG/util');
clc, clear
%instrreset; disp('reset'); % disconnect and close all instrument objects
p = tuner_initialize_pfag; disp('pfag initialized');

%% make arbitrary sine waveform
clc
for theta = 0:5:360 % in degrees
    p.data = sin(linspace(0,2*pi,47)+theta*pi/180); % convert to rad
    %fprintf(p.deviceObj,':FUNC:USER');
    %fprintf(p.deviceObj,':FUNC USER');
    str = [':DATA VOLATILE, ',pfag_arr2str(p.data)];
    %fprintf(p.deviceObj,str);
    figure(1), stem(p.data), 
    title(['theta = ' num2str(theta)]), pause(1/10)
end

%% to remove visa connections
instrfindall
delete(instrfindall)

%setprop_pfag(p); disp('sent prop');