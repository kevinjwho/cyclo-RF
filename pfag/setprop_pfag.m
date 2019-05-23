function setprop_pfag(pfag)
% applys the properties for the pulse generator
%
% INPUT:
%   pfag (optional) - pfag object. Use getad to find this.
%
% OUTPUT:
%   None
%
% Written June 2018
% Levon
%
% Edited April 2019
% Kevin
%
% NOTES
%
%
%ad = getad;

if nargin < 1
    pfag=ad.scopes.pfag;
end


%%%%%%%%% Go one by one and set each property %%%%%%%%%
% Find channel
chan = num2str(pfag.prop.channel);

% create arb. sine wave
numpts = 49;
pfag.data1 = sin(linspace(0,2*pi,numpts));
pfag.data2 = pfag.data1;

% write data to volatile memory for each channel
str1 = [':DATA1 VOLATILE, ',pfag_arr2str(pfag.data1)];
fprintf(pfag.deviceObj,str1);
str2 = [':DATA2 VOLATILE, ',pfag_arr2str(pfag.data2)];
fprintf(pfag.deviceObj,str2);

% couple channel 1 to channel 2
fprintf(pfag.deviceObj,':TRAC:CHAN1 ON');
fprintf(pfag.deviceObj,':TRAC:CHAN1 OFF');
fprintf(pfag.deviceObj,':TRAC:CHAN1 ON');

% pfag.data = [sin(linspace(0,2*pi,47))];
% 
% fprintf(pfag.deviceObj,':FUNC:USER');
% fprintf(pfag.deviceObj,':FUNC USER');
% str = [':DATA VOLATILE, ',pfag_arr2str(pfag.data)];
% fprintf(pfag.deviceObj,str);

%output sine on both channels
% fprintf(pfag.deviceObj, ':FUNC SIN');
% %out1
% fprintf(pfag.deviceObj, ':FREQ1 22.87MHz');
% fprintf(pfag.deviceObj, 'VOLT1:AMPL 17dBm');
% %out2
% fprintf(pfag.deviceObj, ':FREQ2 22.87MHz');
% fprintf(pfag.deviceObj, 'VOLT2:AMPL 17dBm');
%
% fprintf(pfag.deviceObj, ':OUTP:DEL 1DEG');


% % create arbitrary wave form
% pFlag = 0;
% if strcmp(pfag.data,'sine')
%     pfag.data = [sin(linspace(0,2*pi,47))];
% elseif strcmp(pfag.data,'saw')
%     pfag.data = [linspace(1,-1,46) 0];
% elseif strcmp(pfag.data,'square')
%     pfag.data = [1 0];
% elseif strcmp(pfag.data,'pulse')
%     pFlag = 1;
%     str = [':APPL',chan,':PULS ',num2str(1/pfag.prop.period),', ',num2str(pfag.prop.amp),', ',num2str(pfag.prop.phase)];
% end
%
% if ~pFlag
%     fprintf(pfag.deviceObj,':FUNC:USER');
%     fprintf(pfag.deviceObj,':FUNC USER');
%     str = [':DATA VOLATILE, ',pfag_arr2str(pfag.data)];
% end
% fprintf(pfag.deviceObj,str);
%
% % set pulse delay
% str = [':PULS',chan,':DEL ', num2str(pfag.prop.delay)];
% fprintf(pfag.deviceObj,str);
%
% % set pulse period
% str = [':PER',chan,' ',num2str(pfag.prop.period)];
% fprintf(pfag.deviceObj,str);
%
% % set polarity
% strP = 'NORM';
% if pfag.prop.polarity
%     strP = 'INV';
% end
% str = [':OUTP',chan,':POL ',strP];
% fprintf(pfag.deviceObj,str);
%
% % set amplitude
% str = [':VOLT',chan,':AMPL ',num2str(pfag.prop.amp),'V'];
% fprintf(pfag.deviceObj,str);
%
% % set offset
% %str = [':VOLT',chan,':OFFS ',num2str(pfag.prop.offset)];
% %fprintf(pfag.deviceObj,str);
%
% %set phase
% %str = [':BURS',chan,':PHAS ',num2str(pfag.prop.phase)];
% %fprintf(pfag.deviceObj,str);
%
% % set number of bursts on trigger
% %str = [':TRIG',chan,':COUN ',num2str(pfag.prop.bursts)];
% %fprintf(pfag.deviceObj,str);
