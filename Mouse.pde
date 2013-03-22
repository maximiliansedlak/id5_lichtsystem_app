void mousePressed() {
  for (int p = 0; p<manyRects.length; p++) {
    /* FUNKTION ÜBERPRÜFT, OB SICH MAUS DARAUF BEFINDET UND MAUS GEDRÜCKT IST */
    manyRects[p].selectSpot();
    manySpots[p].spotTrigger = manyRects[p].selectedSpot;
  }
}

void mouseReleased() {

  for (int p=0; p<manyButtons.length; p++) {
    /* FUNKTION ÜBERPRÜFT, OB SICH MAUS DARAUF BEFINDET UND MAUS LOSGELASSEN WURDE */
    manyButtons[p].selectButton();
  }

  for (int p = 0; p<manyRects.length; p++) {
    /* FUNKTION ÜBERPRÜFT, OB SICH MAUS DARAUF BEFINDET UND MAUS GEDRÜCKT IST */
    manyRects[p].selectSpot();
    manySpots[p].spotTrigger = manyRects[p].selectedSpot;
  }

  ///////// BEZIEHT SICH AUF DIE BUTTONS
  for (int b=0; b<manyButtons.length; b++) {
    if (manyButtons[b].buttonSelected || manyButtons[b].buttonOver) {
      //if (serialPort.available() > 0) {
      switch(manyButtons[b].buttonID) {
      case 0:
        for (int u=0; u<8; u++) {
          //Definiert fix Programm alle AUS
          //manyPrograms[0].tempProgramCommandByte[u] = byte(0);
          manySpots[u].spotBrightness = byte(0);
          manySpots[u].spotTrigger = false;
          manyRects[u].selectedSpot = false;
          manySpots[u].displaySpot();
          tempLightArray[u] =  manyPrograms[0].tempProgramCommandByte[u];
        }
        for (int i=1; i<manyButtons.length-1; i++) {
          manyButtons[i].buttonSelected = false;
        }
        break;
      case 1:
        for (int u=0; u<8; u++) {
          //Definiert fix Programm alle AN
          //manyPrograms[1].tempProgramCommandByte[u] = byte(255);
          manySpots[u].spotBrightness = byte(255);
          manySpots[u].spotTrigger = true;
          manyRects[u].selectedSpot = true;
          manySpots[u].calcSpotBrightness();
          manySpots[u].displaySpot();
          tempLightArray[u] =  manyPrograms[1].tempProgramCommandByte[u];
        }
        for (int i=2; i<manyButtons.length-1; i++) {
          manyButtons[i].buttonSelected = false;
        }
        break;
      case 2:
        for (int u=0; u<8; u++) {
          tempLightArray[u] =  manyPrograms[2].programCommandByte[u];
        }
        manyButtons[3].buttonSelected = false;
        manyButtons[4].buttonSelected = false;
        break;
      case 3:
        for (int u=0; u<8; u++) {
          tempLightArray[u] =  manyPrograms[3].programCommandByte[u];
        }
        manyButtons[2].buttonSelected = false;
        manyButtons[4].buttonSelected = false;
        break;
      case 4:
        for (int u=0; u<8; u++) {
          tempLightArray[u] =  manyPrograms[4].programCommandByte[u];
        }
        manyButtons[3].buttonSelected = false;
        manyButtons[2].buttonSelected = false;
        break;
      }
    }
  }

  for (int p = 0; p<manyRects.length; p++) {
    manyRects[p].sperrVar = false;
  }
  if (serialPort.available() > 0) {
    sendCommandArray();
  }
}

