function ostr = pfag_arr2str(arr)
% Format a numeric array to a string format for pfag object
%

ostr = '';
for i = 1:length(arr)
    ostr = [ostr, num2str(arr(i)), ', '];
end

% remove last comma
ostr = ostr(1:end-2);
end