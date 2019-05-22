import processing.serial.*;
Serial mySerial;
PrintWriter analogValue;
float value;

void setup() {
  mySerial = new Serial( this, Serial.list()[2], 9600 );//Change the 1 to be your correct com port
  analogValue = createWriter( "NewValues.txt" );
}
int flag = -1, loop= 1;

void draw() {
   String message = mySerial.readStringUntil(13);
  if(message != null){
    value = float(message);
    analogValue.println(value);
    println(value);
  }
}

void keyPressed() {
  analogValue.flush(); // Writes the remaining data to the file
  analogValue.close(); // Finishes the file
  exit(); // Stops the program
}
