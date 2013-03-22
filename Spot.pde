
class Spot {
  protected int spotID;
  protected boolean spotTrigger = false;
  float spotDistance;
  byte spotBrightness;
  int bEllipseSize = spotBeginSize;

  int sX;
  int sY;

  int sEs;
  int sBs;

  // Spot(y, sXarray[y], sYarray[y], spotBeginSize, spotEndSize );
  public Spot(int sID, int sx, int sy, int sbs, int ses) {
    spotID = sID;
    sX = sx;
    sY = sy;
    sEs = ses;
    sBs = sbs;
  }

  ///// Speichert Helligkeitswert des Spots
  void setBrightness(byte sB) {
    // Setze Helligkeit des Spots auf eben definierten Wert
    if (this.spotTrigger) {
      tempLightArray[this.spotID] = this.spotBrightness;
    }
    if (!this.spotTrigger) {
      tempLightArray[this.spotID] = 0;
    }
  }

  // Wenn Spot aktiviert, dann zeichne Ellipse mit aktuellem Helligkeitswert
  void displaySpot() {
    if (spotTrigger) {
      drawSpot();
    }
  }

  void drawSpot() {
    println(spotDistance);
    if (spotTrigger || calcSpotDistance() > 10) {
      drawSpotBrightness(sX, sY, spotBrightness, spotBrightness);
      // Zeichnet den Endkreis
      noFill();
      //stroke(0, 190);
      //strokeWeight(2);
      ellipse(sX, sY, spotEndSize+15, spotEndSize+15);
      // Zeichnet ersten Punkt
      noStroke();
      if (int(spotBrightness) == 255) {
      fill(0, 190);
      }
      else{
        fill(#DFAA05);
      }
      ellipse(sX, sY, sBs, sBs);
    }
  }

  byte calcSpotBrightness() {

    int distanceToCCenter = int(dist(sX, sY, mouseX, mouseY));
    byte bEllipseSizeByte;

    if (distanceToCCenter <= sBs) {
      bEllipseSize = sBs;
    }
    else if (distanceToCCenter <= sEs) {
      bEllipseSize = distanceToCCenter;
    }
    else if (distanceToCCenter >= sEs) {
      bEllipseSize = sEs;
    }

    bEllipseSizeByte = byte(map(bEllipseSize, spotBeginSize, spotEndSize, 0, 150));
    setBrightness(bEllipseSizeByte);
    
    return bEllipseSizeByte;
  }

  void drawSpotBrightness(int sPx, int sPy, int ePx, int ePy) {
    float rad, oscillation;

    rad = frameCount * 0.5;
    oscillation = sin(rad);

    noStroke();
    fill(0, 128);
    if (int(spotBrightness) == 255) {
      fill(#D95D30, 190);
      ellipse(sPx, sPy, spotEndSize+oscillation, spotEndSize+oscillation);
    }
    else {
      fill(#D9B343, 190);
      ellipse(sPx, sPy, int(spotBrightness)+(oscillation*2), int(spotBrightness)+(oscillation*2));
    }
  }

  ///// Berechnet die Distanz zwischen Spotpunkt und Mauszeiger -> Rückgabewert Distanz (float)
  float calcSpotDistance() {
    float distanceToMouse = dist(sX, sY, mouseX, mouseY);
    if (distanceToMouse <= 250) {
      spotTrigger = true;
      spotDistance = distanceToMouse;
      manyRects[this.spotID].selectedSpot = true;
      return distanceToMouse;
    }
    else {
      spotTrigger = false;
      manyRects[this.spotID].selectedSpot = false;
      spotBrightness = 0;
      spotDistance = 0;
      return float(0);
    }
  }

  void calcSpotDistanceBrightness() {
    float spotDistanceToSpot = map(spotDistance, 0, 780, 10, 255);
    spotBrightness = byte(spotDistanceToSpot);
  }
  
  void debugSpot(){
    print("SpotID: "+spotID+" ");
    print(" spotTrigger: "+spotTrigger+" ");
    print(" spotBrightness: "+spotBrightness);
    println();
  }
}

