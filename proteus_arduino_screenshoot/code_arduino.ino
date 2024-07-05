#include <SoftwareSerial.h>

int ROOM1 = 2;
int ROOM2 = 3;
int ROOM3 = 4;
int ROOM4 = 5;


void setup() {
  Serial.begin(9600);

  pinMode(ROOM1, OUTPUT);
  pinMode(ROOM2, OUTPUT);
  pinMode(ROOM3, OUTPUT);
  pinMode(ROOM4, OUTPUT);
}

void loop() {
  if (Serial.available() > 0) {
    int value = Serial.readString().toInt();

    switch (value) {
      case 1:
        digitalWrite(ROOM1, HIGH);
        break;
      case 2:
        digitalWrite(ROOM1, LOW);
        break;
      case 3:
        digitalWrite(ROOM2, HIGH);
        break;
      case 4:
        digitalWrite(ROOM2, LOW);
        break;
      case 5:
        digitalWrite(ROOM3, HIGH);
        break;
      case 6:
        digitalWrite(ROOM3, LOW);
        break;
      case 7:
        digitalWrite(ROOM4, HIGH);
        break;
      case 8:
        digitalWrite(ROOM4, LOW);
        break;
      default:
        break;
    }
  }
  delay(100);
}
