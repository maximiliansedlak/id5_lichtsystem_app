class Rectangle {
  //// Übergabewerte
  protected byte rectID;
  protected float a;
  protected float b;
  protected float positionX;
  protected float positionY;
  
  //// Steuerungswerte
  boolean rectPressed = false;
  boolean selectedSpot = false;
  boolean sperrVar;
  boolean rectOver;
  PVector rectPos;

  int rectBreite;
  int rectHoehe;
  float rectGroesse;

  public Rectangle(int ID, int rectHeight, int rectWidth, int Groesse, int Hoehe, int xKoord, int yKoord) {
    rectID = byte(ID);
    rectBreite  = rectWidth;
    rectHoehe  = rectHeight;
    positionX = xKoord;
    positionY = yKoord;
    rectPos = new PVector(positionX, positionY, random(0, height));
  }

  void selectSpot() {
    if (mouseX>rectPos.x && mouseX<rectPos.x+rectBreite && mouseY>rectPos.y && mouseY<rectPos.y+rectHoehe) {

      if (manyButtons[3].buttonSelected || manyButtons[4].buttonSelected) {
        if (!sperrVar) {
          if (selectedSpot) {
            selectedSpot = false;
          }
          else {
            selectedSpot = true;
          }
          sperrVar = true;
        }
      }
    }
  }
}

