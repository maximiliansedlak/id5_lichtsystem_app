
// test 

byte[] lampCommandArray = new byte[8];

// immer wenn die mouse los gelassen wird, wird das array lamComandArray ein mal gesendet!
// du kannst di ganze zeit mit bytes arbeiten da deine zahlen nie über 255 hinausgehen!
// 0 und 1 musst du nicht extra speichern...entweder du bist aus = 0, an = 255 oder irgenwo dazuwischen!

void sortArray(){
  tempLightArray[0] = manySpots[0].spotBrightness;
  tempLightArray[1] = manySpots[1].spotBrightness;
  tempLightArray[2] = manySpots[2].spotBrightness;
  tempLightArray[3] = manySpots[3].spotBrightness;
  tempLightArray[4] = manySpots[7].spotBrightness;
  tempLightArray[5] = manySpots[6].spotBrightness;
  tempLightArray[6] = manySpots[5].spotBrightness;
  tempLightArray[7] = manySpots[4].spotBrightness;
}
void sendCommandArray() {
  sortArray();
  for (int j=0;j<tempLightArray.length;j++) {
    // Funktioniert mit einzelnen LEDs, die in tempLightArray geschrieben werden
    // Schreibt tempLightArray in lampCommandArray
    lampCommandArray[j] = tempLightArray[j];
  }
  // fixe zahlenfolge als delimiter um den anfang des arrays beim empfang im arduino zu finden
  serialPort.write(byte(10)); // schreibe linefeed entspricht der bytezahl 10
  serialPort.write(byte(13)); // schreibe return entpricht der bytezahl 13
  
  print("sende dieses array: ");
  // schreibe hier dein array raus
  for (int i=0; i<8;i++) {
    serialPort.write(lampCommandArray[i]);
    print(lampCommandArray[i] + ", ");
  }
  println();
}
/*
void serialEvent(Serial serialPort) {
  // read a byte from the serial port:
  char inByte = char(serialPort.read());
  print(inByte);
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
}
*/

