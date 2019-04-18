%% Reading in CSV Data
Experiment_Data = csvread('AutoTuner_Data.csv',1,0);
PhaseDifference_Oscilloscope = Experiment_Data(:,1);
Nominal_PhaseDifference = Experiment_Data(:,2);
Voltage_Readout = Experiment_Data(:,3);
%% Plotting Initial Plots
% Need to get rid of first couple datapoints since they are positive and
% everything else is negative
PhaseDifference_Oscilloscope = PhaseDifference_Oscilloscope(4:end)
scatter(PhaseDifference_Oscilloscope,Voltage_Readout(4:end))
title('Voltage Readout vs Measured Phase Difference')
xlabel('Phase Difference (Degrees)')
ylabel('Voltage Readout (Volts)')
hold on

p3 = polyfit(PhaseDifference_Oscilloscope, Voltage_Readout(4:end),3);
poly1 = polyval(p3, PhaseDifference_Oscilloscope)
plot(PhaseDifference_Oscilloscope, poly1)

p5 = polyfit(PhaseDifference_Oscilloscope, Voltage_Readout(4:end),5);
y5 = polyval(p5, PhaseDifference_Oscilloscope)
plot(PhaseDifference_Oscilloscope, y5)

%L is the curve's maximum, which is 1.75 Volts 
%x0 is the midpoint of the curve which is going to be 90 degrees
% for the equation f(x) = L/(1+ e^(-k(x-x0))). We need to find k. Little
% bit of guess and check makes 0.09 a good value for it.
x = linspace(-180,0,1000)
y = 2.75./(1+exp(0.09*(x+90))) -1 
plot(x,y)

legend('Data', '3rd Degree Polynomial Fit','5th Degree Polynomial Fit', 'Logistic Fit')

hold off
%% Making full plot 
x2 = linspace(0,180,1000);
y2 = 2.75./(1+exp(-0.09*(x+90))) -1;

Combined_XValues = [x x2];
Combined_YValues = [y y2];

figure(2)
plot(Combined_XValues,Combined_YValues)
title('Voltage Reponse to Phase Changes')
xlabel('Phase Difference (Degrees)')
ylabel('Voltage (Volts)')

