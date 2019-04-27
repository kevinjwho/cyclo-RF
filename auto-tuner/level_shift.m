function [m, b, R2, Rg] = level_shift(Vinfs, Vinzs, Voutfs, Voutzs, Vref, R1, Rf)
%LEVEL_SHIFT Level shift for positive m and positive b
%   Give various input parameters to solve for level shift output
%   parameters. Input voltages have units of Volts. Resistances have units
%   Ohms. m and b are unitless, with m representing gain and b representing
%   offset. For further information, refer to the guide linked here:
%   https://www.ti.com/lit/an/sloa097/sloa097.pdf

    %% 1. introduction - voltage parameters
    % defined as inputs
    
    %% 2. calculating m and b
    m = (Voutfs - Voutzs)/(Vinfs - Vinzs);
    b = Voutzs - m*Vinzs;
    
    %% 3. positive m and positive b
    R2 = Vref * R1 * m / b; % calculate R2
    Rg = R2 * Rf/ (m*(R1+R2)-R2); % calculate Rg
end

