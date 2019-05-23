function [pfag] = initialize_pfag(tcpipaddr)
% Initializes the pulse function waveform generator
%
% INPUTS
%   1. tcpipaddr (optional) - insrument tcpipaddr. Can be found by going to
%   the instruments ip address in a browser window
%
% OUTPUS
%   1. pfag - a visa object used to access/write/read properties from the
%   insrument
%
% Written June 2018
% Levon
%
% NOTES
% This should only be run during startup ONCE. Otherwise you have multiple
% instances of the same visa object which causes problems. Use getad to get
% access to this pfag object.
%
%

if nargin < 1
    % Pre defined addresses
    tcpipaddr = 'TCPIP0::192.168.8.151::inst0::INSTR';
end

% ad = getad;
% try
%     pfag = ad.scopes.pfag;
%     return
% end

% data used to make arbitrary waveform 
pfag.data = sin(linspace(0,2*pi,47)); % (:DATA VOLATILE, x, x, x, x)
% data used to make arbitrary waveform
pfag.prop.channel = 1; % output channel 1 or 2 on the instrument
pfag.prop.delay = 0; % delay in seconds (:PULS1:DEL xxx)
pfag.prop.period = 984.20e-9; % period of pulse in seconds (:PER1 xx)
pfag.prop.polarity = 0; % 0 - NORM , 1 - Flipped (:OUTP1:POL NORM/INV)
pfag.prop.amp = 5; % amplitude in volts (:VOLT1:AMPL 1)
pfag.prop.bursts = 500; % number of bursts/periods to be executed for each trigger event. (:TRIG:COUN X)
pfag.prop.phase = 0; %starting phase of burst; zero-crossing of sine wave in degrees
pfag.prop.offset = 0; % vertical offset

% define our visa object
pfag.deviceObj = [];

% create visa object instance
pfag.deviceObj = visa('agilent',tcpipaddr);
fopen(pfag.deviceObj);

% Make sure waveform is set to custom user profile
fprintf(pfag.deviceObj,':FUNC:USER');
fprintf(pfag.deviceObj,':FUNC USER');

% Turn off the display (this runs things faster)
fprintf(pfag.deviceObj,':DISP OFF');

% Turn on outputs 1 and 2
fprintf(pfag.deviceObj,':OUTP1 ON');
fprintf(pfag.deviceObj,':OUTP2 ON');

% setup trigger to run with external source
fprintf(pfag.deviceObj,':ARM:SOUR1 EXT');
fprintf(pfag.deviceObj,':ARM:SOUR2 EXT');

% Set default properties
setprop_pfag(pfag);