const int buttonPin = 2;
int buttonState;             // the current reading from the input pin
int transp =0;   // the previous reading from the input pin

void setup() {
  Serial.begin(9600);

  pinMode(buttonPin, INPUT);
  pinMode(11, OUTPUT);
}

void loop() {
  int reading = digitalRead(buttonPin);

  if (reading == HIGH) {
    transp =255;
  } else {
    transp =0;
  }
  
  digitalWrite(11, reading);
  Serial.println(transp);
  
}

