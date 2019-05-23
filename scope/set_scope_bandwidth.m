function bw = set_scope_bandwidth(bw)
% Sets the scope bandwidth for all channels
%
% INPUT:
%   bw - bandwidth to set to.
%
%
%

ad = getad;
channels = 4;

for i = 1:4
    set(ad.scopes.bpm.deviceObj.Channel(i), 'BandwidthLimit', bw)
end

end