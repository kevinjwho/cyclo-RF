%% pfag main

%% setup, run ONCE
addpath('PFAG','PFAG/util','scope','auto-tuner');
clc, clear
%instrreset; disp('reset'); % disconnect and close all instrument objects
p = tuner_initialize_pfag; disp('pfag initialized');
s = initialize_scope; disp('scope initialized');

%% MANUALLY ADJUST SCOPE
% * turn off ch. 2 (phase detector)
% * autoset on the sine waves
% * turn on ch. 2 (phase detector)


%% make arbitrary sine waveform and take readings
clc
numpts = 49;
t = linspace(0,2*pi,numpts);
p.data1 = sin(t);
theta = 0:5:360; % in degrees
Vout = zeros(size(theta)); % initialize Vout measured by oscilloscope
fig1 = figure(1); jFrame = get(handle(fig1), 'JaveFrame');
jFrame.setMaximized(1);
for k = 1:length(theta) % in degrees
    p.data2 = sin(t+theta(k)*pi/180); % convert to rad
    fprintf(p.deviceObj,':FUNC2:USER'); % declare function
    fprintf(p.deviceObj,':FUNC2 USER'); % ouput function
    str = [':DATA2 VOLATILE, ',pfag_arr2str(p.data2)]; % make data string
    fprintf(p.deviceObj,str); % send data to ch2

    % -- read data from channel 2
    [s.yData2,s.xData2,s.yUnits2,s.xUnits2] = ...
        invoke(s.waveformObj2, 'readwaveform', s.channelObj2.name)
    Vout(k) = mean(s.yData2); % take mean and store
    
    % -- graph data sent, live
    subplot(2,2,1), stem(t, p.data1); hold on,
    stem(t, p.data2); hold off;
    grid, legend('OUT1', 'OUT2');
    title(['waveform sent to function gen; theta = ' num2str(theta(k))]),
    
    % -- graph phase detector readings, live
    subplot(2,2,2), stem(theta, Vout); grid on;
    axis([min(theta) max(theta) -1.5 1.5]);
    xlabel('phase diff (deg)'); ylabel('voltage')
    title('raw voltage v phase diff');
    
    pause(1/3)
end

%% determine level shift parameters
% definitions
Vref = 9; Voutfs = 5; Voutzs = 0; % in V
R1 = 22000; Rf = 22000; % in Ohm

% measurements
Vinfs = max(Vout), Vinzs = min(Vout)

% calculations
[m, b, R2, Rg] = level_shift(Vinfs, Vinzs, Voutfs, Voutzs, Vref, R1, Rf)

% -- graph level shifted curve 
Vshift = m*Vout + b;
subplot(2,2,3), stem(theta, Vshift); grid on;
xlabel('phase diff (deg)'); ylabel('voltage');
title('shifted voltage v phase diff');

% -- graph corresponding voltages that arduino should read
Varduino = Vshift * 1023/5;
subplot(2,2,4), stem(theta, Varduino); grid on;
xlabel('phase diff (deg)'); ylabel('voltage');
title('arduino shifted voltage v phase diff');
%% to remove visa connections
%instrfindall
delete(instrfindall), clear, clc

%% invoke example
close all
[s.yData2,s.xData2,s.yUnits2,s.xUnits2] = invoke(s.waveformObj2, 'readwaveform', s.channelObj2.name)
[s.yData4,s.xData4,s.yUnits4,s.xUnits4] = invoke(s.waveformObj4, 'readwaveform', s.channelObj4.name)
figure(2), plot(s.xData2, s.yData2)
mean(s.yData2)
%figure(4), plot(s.xData4, s.yData4)