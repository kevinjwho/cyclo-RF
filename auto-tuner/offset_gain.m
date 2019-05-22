%% offset gain amplifier

%% 1. Introduction - voltage level inputs
Vref = 9; % voltage level of stable reference
Voutfs = 5; % full-scale output voltage
Voutzs = 0; % zero-scale output voltage
Vinfs = .02; % full-scale input voltage
Vinzs = -.2; % zero-scale input voltage
Vinmid = (Vinfs+Vinzs)/2; % mid level input voltage
VinAmp = Vinfs-Vinmid;

%% 2. Determining the type of function - solving for m and b
m = (Voutfs - Voutzs)/(Vinfs - Vinzs);
b = Voutzs - m*Vinzs;

%% 3. Positive m and positive b

% -- inputs
R1 = 2200; % choose R1
Rf = 22000; % choose Rf
R2 = Vref * R1 * m / b; % calculate R2
Rg = R2 * Rf/ (m*(R1+R2)-R2); % calculate Rg

%% 4. make plots
theta = -180:1:180;
V = VinAmp*sin(theta*pi/180) + Vinmid;

figure(1), subplot(1,3,1), plot(theta,V); title('raw voltage'); grid on;
xlabel('theta'), ylabel('voltage (V)');

V5 = m*V+b;
figure(1), subplot(1,3,2), plot(theta, V5); title('scaled voltage'); grid on;
xlabel('theta'), ylabel('voltage (V)'); ylim([0 5])

Vard = V5/5*1023;
%figure(1), subplot(1,3,3), plot(theta, Vard); title('arduino read'); grid on;
%xlabel('theta'), ylabel('arduino voltage (0-1023)');

steady = Vard(theta == 0);
plusone = Vard(theta == 1);
minusone = Vard(theta == -1);
plustwo = Vard(theta == 45);
minustwo = Vard(theta == -45);

figure(1), subplot(1,3,3), 
plot(theta, Vard, 'b', theta, steady*ones(1,length(theta)), 'g', ... 
    theta, plusone*ones(1,length(theta)), 'r', ... 
    theta, minusone*ones(1,length(theta)), 'r');
title('arduino read'), grid on; xlabel('theta'), ylabel('arduino voltage'),
ylim([0 1023])

%% 5. output table
T = table(m, b, R2, Rg, minusone, steady, plusone)%, plustwo, minustwo)