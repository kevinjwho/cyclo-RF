// include the library code:
// From hackster.io code to make LCD display potentiometer readings
//https://www.hackster.io/Guitarman1/displaying-sensor-values-on-lcd-c0c44f
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7,8,9,10,11,12);

int potPin1 = A1;
int potPin2 = A2;

void setup()
{
// set up the LCD's number of columns and rows:
lcd.begin(16, 2);
lcd.clear();

pinMode(potPin1, INPUT);
pinMode(potPin2, INPUT);
}

void loop()
{
lcd.setCursor(0,0); // Sets the cursor to col 0 and row 0
lcd.print("SensorVal1: "); // Prints Sensor Val: to LCD
lcd.print(analogRead(potPin1)); // Prints value on Potpin1 to LCD
lcd.setCursor(0,1); // Sets the cursor to col 1 and row 0
lcd.print("SensorVal2: "); // Prints Sensor Val: to LCD
lcd.print(analogRead(potPin2)); // Prints value on Potpin1 to LCD
}
