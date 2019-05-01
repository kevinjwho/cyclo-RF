import processing.serial.*;
Serial mySerial;
PrintWriter analogValue;
float value;

void setup() {
  mySerial = new Serial( this, Serial.list()[1], 9600 );//Change the 1 to be your correct com port
  analogValue = createWriter( "analogValues.txt" );
}
int flag = -1, loop= 1;
String newline = System.getProperty("line.separator");
void draw() {

  if (mySerial.available() > 0 ) {
    String input = mySerial.readStringUntil(10); //where 10 is the ASCII code for new line
    if(input != null){
    value = float(input);
    analogValue.print(value);
    print(value);
    }
  }
  exit(); // Stops the program
}
