class Program {

  int programID;
  byte[] programCommandByte = new byte[8];
  byte[] tempProgramCommandByte = new byte[8];


  public Program(int ID) {
    programID = ID;
  }
  
  public void setProgrammCommandByte(byte[] tempLightArray){
    this.programCommandByte = tempLightArray;
  }
}

