class Button {

  protected int buttonID;
  protected int buttonColor;
  protected int buttonBreite;
  protected int buttonHoehe;
  protected int buttonX;
  protected int buttonY;
  protected int posCorrect = 10;
  protected String buttonLabel;

  ///// STEUERUNG

  boolean sperrVar;
  boolean buttonSelected = false;
  boolean buttonOver;
  PVector buttonPos;

  ///// ANZEIGE
  int buttonGroesse = 30;
  int buttonProgramColorR;
  int buttonProgramColorG;
  int buttonProgramColorB;

  public Button(int bID, String bLabel, int bBreite, int bHoehe, int xKoord, int yKoord) {
    buttonID = bID;
    buttonLabel = bLabel;
    buttonBreite = bBreite;
    buttonHoehe = bHoehe;
    buttonX = xKoord-buttonBreite/2;
    buttonY = yKoord-buttonHoehe/2;
    buttonPos = new PVector(buttonX, buttonY);
  }

  public void setButtonLabel(String bLabel) {
    this.buttonLabel = bLabel;
  }

  public void setButtonColor(int bCr, int bCg, int bCb) {
    buttonProgramColorR = bCr;
    buttonProgramColorG = bCg;
    buttonProgramColorB = bCb;
  }

  public void setButtonColor(int bColor) {
    buttonColor = bColor;
  }

  public void drawButton() {
    if (buttonSelected) {
      buttonColor = 150;
    }
    else {
      buttonColor = 0;
    }
    //fill(0, 128);
    //rect(buttonPos.x, buttonPos.y-posCorrect, buttonBreite, buttonHoehe);
    fill(buttonColor);
    // Debug Rect: rect(buttonX, buttonY, 50, 50);
    //text(buttonLabel, buttonPos.x, buttonPos.y);
  }

  void selectButton() {
    if (mouseX>buttonPos.x && mouseX<buttonPos.x+buttonBreite && mouseY>buttonPos.y&& mouseY<buttonPos.y+buttonHoehe) {
      buttonOver = true;
      if (!buttonSelected && buttonID > 1 && buttonID < 5) {
        println("buttonSelected: "+buttonID+" SelectStatus: "+buttonSelected);
        buttonSelected = true;
      }
      else if (buttonSelected && buttonID > 1 && buttonID < 5) {
        println("buttonSelected: "+buttonID+" SelectStatus: "+buttonSelected);
        buttonSelected = false;
      }
      else {
        buttonSelected = false;
      }
    }
    else {
      buttonOver = false;
    }
  }
}

