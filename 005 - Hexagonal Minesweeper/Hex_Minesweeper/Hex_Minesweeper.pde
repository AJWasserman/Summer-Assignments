int boardWidth = 9;
int boardHeight = 9;
int bombCount = 10;

boolean[][] hasBomb = new boolean[boardWidth][boardHeight];
int[][] neighbors = new int[boardWidth][boardHeight];
boolean[][] placed = new boolean[boardWidth][boardHeight];

//Hexagon Variables
float s; // = 700/(2*boardWidth); //Side length
float w; // = 2*s; //Width
float h; // = sqrt(3)/2*w; //Height 
float offset; //Variable for offsetting odd rows
int border; 

boolean drawMenu = true;
boolean inGame = true;
boolean gameOver = false;

void setup() {
  size(700, 700);
  frame.setTitle("Hexagonal Minesweeper");
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      placed[x][y] = false;
    }
  }
  placeBombs(); 
}

void draw() {
  background(102);
    
  if(inGame) {
    frame.setResizable(true);
    rect(0, 0, width, 40);
    genVariables(); //generates hexagon variables
    drawBoard();  
    frame.setSize((int)((boardWidth*1.55*s + (w / 2))), (int)(50 + 2 * border + offset + (sqrt(3)/2) * w * boardHeight));
  }
}

void drawMenu() {

}

void drawBoard() {
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      if((x%2) != 0) { 
        offset = h/2; //Offsets row y position on odd rows
      }
      else {
        offset = 0; //No offset on even rows
      }
        
      pushMatrix();
      if(hasBomb[x][y] == true) {
        fill(255, 0, 0);  
      }
      else {
        fill(255, 255, 255);  
      }
      hexagon(border + x*.75*w, 40 + border + offset + y*sqrt(3)/2*w);
      popMatrix();   
    }
  }
}

void placeBombs() {  
  int placeCount = bombCount;
  for(int i = 0; i < placeCount; i++) {
    int randX = (int)random(boardWidth);
    int randY = (int)random(boardHeight);
    if(placed[randX][randY]) {
      print("dupe ");
      placeCount++;
    }
    else {
      hasBomb[randX][randY] = true;
      placed[randX][randY] = true;
    }
    print("(" + randX + " " + randY + ") ");
  }
  print("Place Count: " + placeCount);
}

void neighborBombs() {
  int bombNeighbors = 0;
  for (int x = 0; x < boardWidth; x++) {
    for (int y = 0; y < boardHeight; y++) {
      try {
        //Checks bordering hexagons for even columns
        if (x % 2 == 0) {
          if (this.hasBomb[x][y - 1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x+1][y]) {
            bombNeighbors++;
          }
          
          if (this.hasBomb[x+1][y + 1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x][y + 1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x - 1][y + 1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x - 1][y]) {
            bombNeighbors++;
          }
        }
        //Checks bordering hexagons for odd columns
        else {
          if (this.hasBomb[x][y-1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x + 1][y - 1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x][y]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x + 1][y]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x][y + 1]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x - 1][y]) {
            bombNeighbors++;
          }
          if (this.hasBomb[x - 1][y - 1]) {
            bombNeighbors++;
          }
        }
      }
      catch (Exception e) {
        System.out.println(e.toString());
      }
      neighbors[x][y] = bombNeighbors;
    }
  }
}

void genVariables() {
  s = maxSize();
  w = 2*s; //Width
  h = sqrt(3)/2*w; //Height 
  border = (int) w /2; //Gives room between grid and window edges
}

float maxSize() {
  float sl = 0;
  
  for(double i = 0; i < 200; i += .01) {
      if(boardWidth * (1.6 * i) < 680 && boardHeight *(sqrt(3)/2) * 2 * i < 725) {
        sl = (float) i;
      }
  }
  return (float) sl;
}

void hexagon(float x, float y) { 
   beginShape();
   vertex(x+s, y); 
   vertex(x+s/2, y+(sqrt(3)/2*w)/2); 
   vertex(x-s/2, y+(sqrt(3)/2*w)/2); 
   vertex(x-s, y); 
   vertex(x-s/2, y-(sqrt(3)/2*w)/2); 
   vertex(x+s/2, y-(sqrt(3)/2*w)/2); 
   endShape(CLOSE);
}
