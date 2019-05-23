function [scope_data]=get_scope(bpm_number,scope,mode_flag)
%##################################################################
% Returns scope data at given bpm.
%
% INPUT:
%   bpm_number - which bpm number to switch to.
%   scope - scope object (see getad) - optional
%   mode_flag (optional) - mode flag for the scope
%       options:
%           1 (default) - 4 turn mode (2500 pt sample)
%           2 - ~45 turn mode (25,000 pt sample)
%           3 - ~100 turn mode (50,000 pt sample)
%
% OUTPUT:
%   scope_data - scope data in Mx6 array.
%       col 1 - time series
%       col 2,3,4,5 - ch1,ch2,ch3,ch4
%       col 6 - sum of ch1+ch2+ch3+ch4
%
% NOTES:
% mode_flag is invoked by loaded pre-saved settings files. i.e. configure
% the setting on the scope and save it using matlab.
% useful commands to know:
% invoke(scope.deviceObj.System,'savestate',1)
% invoke(scope.deviceObj.System,'loadstate',1)
%
% Written by Levon
% Updated May 2018
%
%##################################################################
ad = getad;

if nargin < 2
    scope = ad.scopes.bpm;
end
if nargin < 3
    mode_flag = 1;
end

%BPM MUX Initiallization and selection
%ni_mux_controller(num2str(bpm_number));
cytec_mux_controller(num2str(bpm_number))

% change mode:
%invoke(scope.deviceObj.System,'loadstate',mode_flag);
%setbeam();

%Delay used to pause scope before it samples
pause(ad.bpm_scope_pause) % grabbed from ad

%Retrieve sample from scope
[scope.yData1, scope.xData1, scope.yUnits1, scope.xUnits1] = invoke(scope.waveformObj1, 'readwaveform', scope.channelObj1.name);
[scope.yData2, scope.xData2, scope.yUnits2, scope.xUnits2] = invoke(scope.waveformObj2, 'readwaveform', scope.channelObj2.name);
[scope.yData3, scope.xData3, scope.yUnits3, scope.xUnits3] = invoke(scope.waveformObj3, 'readwaveform', scope.channelObj3.name);
[scope.yData4, scope.xData4, scope.yUnits4, scope.xUnits4] = invoke(scope.waveformObj4, 'readwaveform', scope.channelObj4.name);

scope_data(:,1)=transpose(scope.xData1); % these conver the data into 5 columns: t, ch1, ch2, ch3, ch4
scope_data(:,2)=transpose(scope.yData1); % by 25,000 lines of data.
scope_data(:,3)=transpose(scope.yData2);
scope_data(:,4)=transpose(scope.yData3);
scope_data(:,5)=transpose(scope.yData4);
scope_data(:,6)=transpose(scope.yData1+scope.yData2+scope.yData3+scope.yData4); % sum signal

%Clear all variables
clear scope.yData1 scope.yData2 scope.yData3 scope.yData4 scope.xData1 scope.xData2 scope.xData3 scope.xData4
clear scope.yUnits1 scope.yUnits2 scope.yUnits3 scope.yUnits4 scope.xUnits1 scope.xUnits2 scope.xUnits3 scope.xUnits4


