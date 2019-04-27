%% pfag main

%% setup, run ONCE
addpath('PFAG','PFAG/util','scope','auto-tuner');
clc, clear
ph_det_ch = 2;
%instrreset; disp('reset'); % disconnect and close all instrument objects
p = tuner_initialize_pfag; disp('pfag initialized');
s = initialize_scope; disp('scope initialized');

%% make arbitrary sine waveform and take readings
clc
numpts = 49;
t = linspace(0,2*pi,numpts);
p.data1 = sin(t);
theta = 0:5:360; % in degrees
Vout = zeros(size(theta)); % initialize Vout measured by oscilloscope
for k = 1:length(theta) % in degrees
    p.data2 = sin(t+theta(k)*pi/180); % convert to rad
    fprintf(p.deviceObj,':FUNC2:USER'); % declare function
    fprintf(p.deviceObj,':FUNC2 USER'); % ouput function
    str = [':DATA2 VOLATILE, ',pfag_arr2str(p.data2)]; % make data string
    fprintf(p.deviceObj,str); % send data to ch2
    
    [s.yData2,s.xData2,s.yUnits2,s.xUnits2] = ... 
        invoke(s.waveformObj2, 'readwaveform', s.channelObj2.name)
    % read data from channel 2
    Vout(k) = mean(s.yData2); % take mean and store
    
    
    figure(1), stem(t, p.data1); hold on,
    stem(t, p.data2); hold off;
    grid, legend('OUT1', 'OUT2');
    title(['theta = ' num2str(theta(k))]), pause(1/10)
end
figure(2), plot(theta, Vout); 
xlabel('phase diff (deg)'); ylabel('voltage')
title('voltage v phase diff');

%% determine level shift parameters
% definitions
Vref = 9; Voutfs = 5; Voutzs = 0; % in V
R1 = 22000; Rf = 22000; % in Ohm

% measurements
Vinfs = max(Vout); Vinzs = min(Vout);

% calculations
[m, b, R2, Rg] = level_shift(Vinfs, Vinzs, Voutfs, Voutzs, Vref, R1, Rf);


%%
clc
addpath('scope')
s = initialize_scope; disp('scope init');

%%
close all
[s.yData2,s.xData2,s.yUnits2,s.xUnits2] = invoke(s.waveformObj2, 'readwaveform', s.channelObj2.name)
[s.yData4,s.xData4,s.yUnits4,s.xUnits4] = invoke(s.waveformObj4, 'readwaveform', s.channelObj4.name)
figure(2), plot(s.xData2, s.yData2)
mean(s.yData2)
%figure(4), plot(s.xData4, s.yData4)
%% to remove visa connections
instrfindall
delete(instrfindall)
clear
clc
%setprop_pfag(p); disp('sent prop');