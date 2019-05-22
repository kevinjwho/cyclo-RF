%% Auto-Tuner Output Data 
formatSpec= '%f';
EightFeetID = fopen('2MeterExtension.txt','r');
FiveFeetID = fopen('5FeetExtension_Output.txt','r');
SameCableID = fopen('SameCableLengthOutput.txt','r');
EightFeetData = fscanf(EightFeetID,formatSpec);
FiveFeetData = fscanf(FiveFeetID,formatSpec);
SameCableData = fscanf(SameCableID,formatSpec);
figure(1)
subplot(2,2,1)
stem(EightFeetData)
xlabel('Index')
ylabel('Analog Value 0-1023')
title('Eight Feet Cable Length Addition')
subplot(2,2,2)
stem(FiveFeetData)
xlabel('Index')
ylabel('Analog Value 0-1023')
title('5 Feet Cable Length Addition')
subplot(2,2,3)
stem(SameCableData)
xlabel('Index')
ylabel('Analog Value 0-1023')
title('Same Cable Length Output')
subplot(2,2,4)
hold on
stem(EightFeetData)
stem(FiveFeetData)
stem(SameCableData)
legend('Eight Feet', 'Five Feet', 'Same Cable Length')
xlabel('Index')
ylabel('Analog Value 0-1023')
title('Combined Plot')
hold off
fclose(EightFeetID);
fclose(FiveFeetID);
fclose(SameCableID);
