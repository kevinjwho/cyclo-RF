%% LC Optimization

%% TODO:
% 1.) determine how to calculate Rac for each L, C pair
% 2.) determine how to calculate Q value, and how this relates to
% optimization problem
% 3.) improve frequency color scheme

%% reset
clear; close all; clc

%% Constants
C_Dee = 78.1*10^-12; % in Farads -- maybe want to remeasure
min_freq = 6*10^6; max_freq = 16*10^6; % in Hz
d = 2; % diameter of inductor loop, in inches
n_l = 1.125; % turns per unit length

%% Variables
L = (0.1:0.1:10)*10^-6; % choose discrete values for L, in H
RAc = (800)*10^-3; % in Ohm -- somehow this relates to L?
C = (0:0.1:550)*10^-12; % in F -- actually (mostly) continuous for vacuum C
P = (1500); % in W -- can probably tune with hardware

%% Inductor things
ll = zeros(2, length(L)); % vector for inductor length, in inches
a = d^2*n_l^2; 
for k = 1:length(L)
    b = -40*L(k)*10^6;
    c = -18*d*L(k)*10^6;
    % r = roots([a b c]);
    ll(:,k) = roots([a b c]);
end
l = ll(1,:);
d = 3;
n_l = 2;
roots([d^2*n_l^2 -40*1.2 -18*d*1.2])
%figure(11), plot(1:length(ll), ll(1,:),'x', 1:length(ll), ll(2,:),'o')
%figure(12), plot(l)

%% Calculations
C_eq = C+C_Dee; % calculate parallel capacitance
[Cg, Lg] = meshgrid(C_eq, L); % define meshgrid to compute something as a function of (L,C) ordered pair

freq = 1./(2*pi*sqrt(Lg.*Cg)); % define freq array as freq(L,C) for each (L,C) pair
ind = (freq >= min_freq) & (freq <= max_freq); % create logical array to see which indices (l,c) puts us within our range

% -------- Some notes:
% RAc should change for each L - how to figure this out?
% we assumed P was set at 1500 - 
% maybe better to plot P as one of the X-Y axes and generate level surfaces
% for each discrete L value.
% need to verify the indices where freq in proper range

for n = 1:length(P)
    Vpp = 2*sqrt(2*P(n)*Lg./(RAc*Cg)).*ind; % compute Vpp for given power, at each (L,C)
        % multiply by our logical array s.t. V(L,C) for (L,C) pair out of
        % freq. range returns 0, and keeps original value o.w.
    
    figure(1), hold on, scatter3(Cg(Vpp>0)*10^12,Lg(Vpp>0)*10^6,... 
        Vpp(Vpp>0),1,freq(Vpp>0)*10^-6); % use scatter plot to show data
        % uses conditionals to plot only the data within our freq. range
        % parameter 4 specifies point size
        % parameter 5 specifies color map (change color for different Vpp
        % values).
    title('V_{pp} and Frequency for given L,C pair @ various P')
    xlabel('Capacitance (pF)'), ylabel('Inductance (uH)'),zlabel('V_{pp} (V)');
    view(45,45); 
    
    % -- just for scatter3 vs surface comparison
    %{
    if n==1
    figure(n+100), surfc(Cg,Lg,Vpp)
    title('Voltage level for given L,C pair')
    xlabel('Capacitance'), ylabel('Inductance'),zlabel('Voltage');
    view(45,45);
    end
    %}
    
end
figure(1), grid on; cbar=colorbar; ylabel(cbar,'frequency (MHz)'); hold off;

%% If you've decided on an L value, take a slice of the 3D plot...
myC_Dee = C_Dee; % in F
myL = 1.2; % in uH
myP = 1500; % in W
myRAc = RAc; % in Ohm
myL = myL * 10^-6; % in H, to be input

[myC, myV] = getInfo(myC_Dee, myL, myP, myRAc, min_freq, max_freq);
myC = myC * 10^12
myV


%% other plots
figure(100), scatter3(Cg(ind==1),Lg(ind==1),freq(ind==1));
title('Frequency for given L,C pair');
xlabel('Capactance'),ylabel('Inductance'),zlabel('Frequency');
view(45,45);

figure(101), mesh(Cg,Lg,freq.*ind);
title('Frequency for given L,C pair');
xlabel('Capactance'),ylabel('Inductance'),zlabel('Frequency');
view(45,45);

figure(102), surf(Cg,Lg,freq);
title('Frequency for given L,C pair');
xlabel('Capactance'),ylabel('Inductance'),zlabel('Frequency');
view(45,45);

%% function getInfo
function [Crange, Vrange] = getInfo(C_Dee, L, P, RAc, Fmin, Fmax)
    Cmax = 1/(L*(2*pi*Fmin)^2) - C_Dee;
    Cmin = 1/(L*(2*pi*Fmax)^2) - C_Dee;
    Crange = [Cmin Cmax];
    
    Vmin = 2*sqrt(2*P*L/(RAc*Cmax));
    Vmax = 2*sqrt(2*P*L/(RAc*Cmin))
    Vrange = [Vmin Vmax];
    
    C_var = Cmin:(Cmax-Cmin)/1000:Cmax;
    C_vec = C_var + C_Dee;
    V_vec = 2*sqrt(2*P*L./(RAc*C_vec));
    F_vec = 1./(2*pi*sqrt(L*C_vec));
    
    figure(200); scatter(C_var * 10^12, V_vec, 1, F_vec*10^-6);
    xlabel('C_{var} (pF)'), ylabel('V_{pp} (V)'),
    title(['V_{pp} and Frequency vs C_{var} @ L = ' num2str(L*10^6) ...
        'uH, Rs = ' num2str(RAc*10^3) 'm\Omega']);
    ylim([0 max(V_vec)]);
    figure(200), grid; cb = colorbar; ylabel(cb, 'Frequency (MHz)');
end