/*
 * Autotuner Control
 * 
 * Allows for automatic and manual control of variable vacuum capacitor used in RF tank
 * circuit used for 19" UMD Cyclotron.
 * 
 * By: Geoffrey Palo, ENEE408T Spring 2018
 */

#include <MSMotorShield.h> // Library for motorshield (clone of Adafruit Motor Shield, version 1
  // Library available from http://wiki.sainsmart.com/index.php/L293D_Motor_Drive_Shield
  // More info on motor class: https://learn.adafruit.com/adafruit-motor-shield/af-dcmotor-class

MS_DCMotor motor(4); // Set which motor output will be used (labeled 1-4 on the shield)
const int analogInPin = A4; // Analog input pin for output from Phase Detector -> Amplifier/Offset circuit
const int switchSTATE = A3; // Analog input pin for switch that controls whether the tuner is in auto, manual, or off mode. GREEN SWITCH
const int switchDIR = A0; // Analog input pin for switch that control direction of motor when in manual mode. RED SWITCH
int sensorValue = 0; // value read from A5 (corresponds to a phase; should be between 0-5V, with 0 phase difference
                     // at ~2.5 V
int autoState = 0; // One of three values corresponding to the state of the tuner: 5 V for auto, 2.5 V for manual, 0 V for off
int manualDir = 0; // One of three values for the direction the motor runs in manual mode: 5 V for forward, 2.5 V for off,
                  // 0 V for backwards.
int lastSensorValue = 0;


void setup() {
  motor.run(RELEASE); // Motor starts off not moving.
  Serial.begin(9600);
}

void loop() {
  lastSensorValue = sensorValue;
  sensorValue = analogRead(analogInPin);
  if(abs(lastSensorValue - sensorValue) > 100){
        Outliers = true;
        return 0;
   }
  autoState = analogRead(switchSTATE); // Read state of the system from the state switch
  
  if (autoState > 700) { // If the input from the state switch is 5 V, run auto-tuner
    
    if(lastSensorValue = 0){
    sensorValue = analogRead(analogInPin); // Read from the Phase Detector -> Amplifier/Offset circuit
    //Serial.println(sensorValue);
    }
    else{
      lastSensorValue = sensorValue;
      sensorValue = analogRead(analogInPin);
      Serial.println(sensorValue);
      //Serial.println("Sensor Value above, last value below");
      //Serial.println(lastSensorValue);
    }
      
    
    if(sensorValue >= 0 && sensorValue <=200){ // If out of phase in one direction, motor runs forward.
      if(sensorValue - lastSensorValue > 0) {
        if(sensorValue - lastSensorValue > 2 ) {
          motor.run(FORWARD);
          motor.setSpeed(255);
        }
        else {
          motor.run(RELEASE);
        } 
      }
      if(sensorValue - lastSensorValue < 0) {
        if(abs(sensorValue - lastSensorValue) > 2 ) {
          motor.run(BACKWARD);
          motor.setSpeed(255);
        }
        else {
          motor.run(RELEASE);
        } 
      }
      }

    else if(sensorValue > 200 && sensorValue <800) { 
      if(sensorValue - lastSensorValue > 0) {
        if(sensorValue - lastSensorValue > 5 ) {
          motor.run(FORWARD);
          motor.setSpeed(255);
        }
        else {
          motor.run(RELEASE);
        } 
      }
      if(sensorValue - lastSensorValue < 0) {
        if(abs(sensorValue - lastSensorValue) > 5 ) {
          motor.run(BACKWARD);
          motor.setSpeed(255);
        }
        else {
          motor.run(RELEASE);
        } 
      }
    }
    //take into account if you are completely out of phase. Right now it does not move.
    else if (sensorValue >= 800 && sensorValue <= 1023) { // If phase difference is around 0 degrees, don't move.
      if(sensorValue - lastSensorValue > 0) {
        if(sensorValue - lastSensorValue > 2 ) {
          motor.run(FORWARD);
          motor.setSpeed(255);
        }
        else {
          motor.run(RELEASE);
        } 
      }
      if(sensorValue - lastSensorValue < 0) {
        if(abs(sensorValue - lastSensorValue) > 2 ) {
          motor.run(BACKWARD);
          motor.setSpeed(255);
        }
        else {
          motor.run(RELEASE);
        } 
      }
      if(sensorValue == 1023 && lastSensorValue == 1023){
        motor.run(BACKWARD);
        motor.setSpeed(255);
      }
    }
 }
  else if(autoState < 300) { // If the input from the state switch is 0 V, don't move

    motor.run(RELEASE);

  }
  else { // If input from state switch is 2.5 V, manual control.

    manualDir = analogRead(switchDIR);

    if (manualDir > 700){ // If input from direction switch is 5 V, run forward.
      motor.run(FORWARD);
      motor.setSpeed(255);
    }
    else if (manualDir < 300) { // If input from direction switch is 0 V, don't move.
      motor.run(RELEASE);
    }
    else { // If input from direction switch is 2.5 V, run backward.
      motor.run(BACKWARD);
      motor.setSpeed(255);
    }
    
  }

  delay(500);
}
