%% offset gain amplifier

%% 1. Introduction - voltage level inputs
Vref = 9; % voltage level of stable reference
Voutfs = 5; % full-scale output voltage
Voutzs = 0; % zero-scale output voltage
Vinfs = .1; % full-scale input voltage
Vinzs = -.1; % zero-scale input voltage

%% 2. Determining the type of function - solving for m and b
m = (Voutfs - Voutzs)/(Vinfs - Vinzs)
b = Voutzs - m*Vinzs

%% 3. Positive m and positive b

% -- inputs
R1 = 22000; % choose R1
Rf = 22000; % choose Rf
R2 = Vref * R1 * m / b % calculate R2
Rg = R2 * Rf/ (m*(R1+R2)-R2) % calculate Rg
