import processing.serial.*;

PImage lightBackground;
PImage lightLogo;
PImage lightLogo_small;
PFont lightFont;

//// BUTTONS

PImage noBrightnessButton;
PImage fullBrightnessButton;
PImage distanceBrightnessButton;
PImage equalBrightnessButton;
PImage singleBrightnessButton;

Serial serialPort; 
int menuChar;
int[] xKoord = { 
  0, 200, 400, 600, 0, 200, 400, 600
};
int[] yKoord = {
  0, 0, 0, 0, 250, 250, 250, 250
};

// Speichert alle Werte der angeklickten Spots
byte[] tempLightArray = new byte[8];

/*
ERSTELLT BUTTONS ZUR NAVIGATION
 */
Button[] manyButtons;

String[] buttonLabels = {
  "ALLE AUS", "ALLE AN", "DISTANCE", "EQUAL", "SELECT"
};

/*
ERSTELLT ACHT RECHTECKE MIT EINER HÖHE VON 300 PX x 200 PX
 */
Rectangle[] manyRects;

/* ERSTELLT ACHT SPOTS */
Spot[] manySpots;

/* ERSTELLT DIVERSE LICHTPROGRAMME */
Program[] manyPrograms;


/////////////
//Konstaneten
/////////////


int spotBeginSize = 10;
int spotEndSize = 70;

int[] sXarray = {
  140, 308, 496, 660, 140, 308, 496, 660
};
int[] sYarray = {
  160, 80, 80, 160, 340, 420, 420, 340
};

void setup() {

  /////// ANZEIGE
  smooth();
  size(800, 600);  // size always goes first!
  lightFont = loadFont("Melbourne-48.vlw");
  textFont(lightFont);  
  textSize(15);
  lightBackground = loadImage("elucubro_background.png");
  lightLogo = loadImage("elucubro_startscreen.png");

  noBrightnessButton = loadImage("elucubro_nobrightness.png");
  fullBrightnessButton = loadImage("elucubro_fullbrightness.png");
  distanceBrightnessButton = loadImage("elucubro_distance.png");
  equalBrightnessButton = loadImage("elucubro_equal.png");
  singleBrightnessButton = loadImage("elucubro_single.png");

  /////// SERIAL
  println(Serial.list()); // Liste aller Ports ausgeben
  println(" Verbinde mit -> " + Serial.list());
  serialPort = new Serial(this, "/dev/tty.usbmodem1a21", 9600);

  /////// BUTTONS
  manyButtons = new Button[5]; 

  ////// ERSTELLE BUTTONS MANUELL
  manyButtons[0]= new Button(0, buttonLabels[0], 50, 50, width-70, 550);
  manyButtons[1]= new Button(1, buttonLabels[1], 50, 50, width-140, 550);
  manyButtons[2]= new Button(2, buttonLabels[2], 50, 50, width-280, 550);
  manyButtons[3]= new Button(3, buttonLabels[3], 50, 50, width-370, 550);
  manyButtons[4]= new Button(4, buttonLabels[4], 50, 50, width-460, 550);

  /////// RECHTECKE
  manyRects = new Rectangle[8]; 

  for (int v= 0; v<manyRects.length; v++) {
    manyRects[v]= new Rectangle(v, 250, 200, 10, 300, xKoord[v], yKoord[v]);
  }

  /////// SPOTS

  manySpots = new Spot[8];

  int sX = 140;
  int sY = 160;

  for (int y= 0; y<manySpots.length; y++) {
    manySpots[y]= new Spot(y, sXarray[y], sYarray[y], spotBeginSize, spotEndSize);
  }

  /////// PROGRAMME
  manyPrograms = new Program[5];

  for (int m = 0; m<manyPrograms.length; m++) {
    manyPrograms[m]= new Program(m);

    for (int v = 0; v<8; v++) {
      manyPrograms[m].tempProgramCommandByte[v] = tempLightArray[v];
    }
  }
}

// test

void draw() {
  background(255);
  menuChar = key;
  switch (menuChar) {
  case 104:
    //image(lightLogo_small, 100, 545);
    //shapeMode(CENTER);
    background(255);
    image(lightBackground, width/2, height/2);

    image(noBrightnessButton, width-70, 550);
    image(fullBrightnessButton, width-140, 550);
    image(distanceBrightnessButton, width-280, 550);
    image(equalBrightnessButton, width-370, 550);
    image(singleBrightnessButton, width-460, 550);

    for (int s=0; s<manyButtons.length; s++) {
      manyButtons[s].drawButton();
      if(manyButtons[s].buttonSelected){
        noStroke();
        fill(#D9B343);
        rect(manyButtons[s].buttonX, manyButtons[s].buttonY+20+manyButtons[s].buttonHoehe, 50, 10);
      }
    }

    for (int i=0; i<manySpots.length; i++) {
      manySpots[i].displaySpot();
    }
    break;
  default:
    imageMode(CENTER);
    image(lightLogo, width/2, height/2);
    fill(0);
  }

  if (mousePressed) {

    byte spotBrTemp = 0;

    // Wenn Maustaste losgelassen wird, überprüfe ob Programm zwei Aktiv (true) ist, dann berechne für alle Spots die Distanz ihrer Position zu mouseX/mouseY und setze Helligkeitswert
    if (manyButtons[2].buttonSelected ) {
      println("Bin in P3!");
      for (int i=0; i<manySpots.length; i++) {
        manySpots[i].calcSpotDistance();
        manySpots[i].calcSpotDistanceBrightness();
        manySpots[i].calcSpotBrightness();
        manySpots[i].drawSpot();
      }

      // Zeichnet Ellipse zur Distanzbestimmung
      noStroke();
      fill(0);
      ellipse(mouseX, mouseY, 20, 20);

      for (int p = 0; p<manyRects.length; p++) {
        /* FUNKTION ÜBERPRÜFT, OB SICH MAUS DARAUF BEFINDET UND MAUS GEDRÜCKT IST */
        if (!manyRects[p].selectedSpot) {
          manySpots[p].spotBrightness = 0;
        }
      }
    }

    // Wenn Button P2 angeklickt wurde ...
    if (manyButtons[3].buttonSelected) {
      println("Bin in P2!");
      // Schreibt immer den zuletzt definierten Helligkeitswert
      for (int p = 0; p<manyRects.length; p++) {
        if (manyRects[p].sperrVar) {
          spotBrTemp = manySpots[p].calcSpotBrightness();
        }
      }

      for (int p = 0; p<manySpots.length; p++) {
        if (manySpots[p].spotTrigger) {
          manySpots[p].spotBrightness = byte(spotBrTemp);
        }
        else if (!manyRects[p].selectedSpot) {
          manySpots[p].spotBrightness = 0;
        }
      }
    }

    // Wenn Button P1 angeklickt wurde ...
    if (manyButtons[4].buttonSelected) {
      println("Bin in P1!");
      // Schreibt immer den zuletzt definierten Helligkeitswert
      for (int i=0; i<manyRects.length; i++) {
        if (manyRects[i].sperrVar && manySpots[i].spotTrigger) {
          manySpots[i].spotBrightness = manySpots[i].calcSpotBrightness();
        }
        else if (!manyRects[i].selectedSpot) {
          manySpots[i].spotBrightness = 0;
        }
      }
    }
  }
}

