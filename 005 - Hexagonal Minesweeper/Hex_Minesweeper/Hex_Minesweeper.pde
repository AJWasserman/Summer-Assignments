int boardWidth = 9;
int boardHeight = 9;
int bombCount = 10;
int flagCount = bombCount;

boolean[][] hasBomb = new boolean[boardWidth][boardHeight];
boolean[][] flagged = new boolean[boardWidth][boardHeight];
int[][] neighbors = new int[boardWidth][boardHeight];
boolean[][] covered = new boolean[boardWidth][boardHeight];
boolean[][] placed = new boolean[boardWidth][boardHeight];
boolean[][] hover = new boolean[boardWidth][boardHeight];
boolean[][] unN = new boolean[boardWidth][boardHeight];

//Hexagon Variables
float s; // = 700/(2*boardWidth); //Side length
float w; // = 2*s; //Width
float h; // = sqrt(3)/2*w; //Height 
float offset; 
int border; 

boolean menu = false;
boolean inGame = true;
boolean gameOver = false;


void setup() {
  size(700, 700);
  frame.setTitle("Hexagonal Minesweeper");
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      placed[x][y] = false;
      unN[x][y] = true;
      covered[x][y] = true;
    }
  }
  placeBombs(); 
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      neighborBombs(x, y);
    }
  }
}

void draw() {
  background(102);
  if(inGame) {
    frame.setResizable(true);
    genVariables(); 
    
    hoverHex();
    
    fill(200, 200, 200);
    rect(0, 0, width, 40);
    drawBoard();  
    frame.setSize((int)((boardWidth*1.55*s + (w / 2))), (int)(50 + 2 * border + offset + (sqrt(3)/2) * w * boardHeight));
  }
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
      if(flagged[x][y]) {
        fill(255, 255, 0);  
      }
      else if(covered[x][y] == true) {
        fill(0, 255, 0);  
      }
      else if(hasBomb[x][y] == true) {
        fill(255, 0, 0);  
      }
      else if(neighbors[x][y] != 0) {
        fill(0, 0, 255);  
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
  print("Place Count: " + placeCount + " ");
}

void neighborBombs(int x, int y) {
  int bc = bombCount;
  int bw = boardWidth;
  int bh = boardHeight;
  try {
    if ((x%2) == 0 && hasBomb[x][y] && unN[x][y]) {
      try {
        neighbors[x][y-1]++; 
      } catch (Exception e) {}
      try {      
        neighbors[x][y+1]++; 
      } catch (Exception e) {}
      try {
        neighbors[x+1][y-1]++; 
      } catch (Exception e) {}      
      
      try { 
        neighbors[x+1][y]++; 
      } catch (Exception e) {}
      try {
        neighbors[x-1][y-1]++; 
      } catch (Exception e) {}
      try {
        neighbors[x-1][y]++; 
      } catch (Exception e) {}
      
      unN[x][y] = false;
    }
    //Checks bordering hexagons for odd columns
    if ((x%2) != 0 && hasBomb[x][y] && unN[x][y]) {
      try {
        neighbors[x][y-1]++; 
      } catch (Exception e) {}
      try {
        neighbors[x][y+1]++; 
      } catch (Exception e) {}
      try {
        neighbors[x-1][y]++;
      } catch (Exception e) {} 
      try {
        neighbors[x+1][y]++; 
      } catch (Exception e) {}
      try {
        neighbors[x-1][y+1]++; 
      } catch (Exception e) {}
      try {      
        neighbors[x+1][y+1]++; 
      } catch (Exception e) {}
      
      unN[x][y] = false;
    }
    else {}
  }
  catch (Exception e) {}
}


void genVariables() {
  s = maxSize(); //Side length
  w = 2*s; //Width
  h = sqrt(3)/2*w; //Height 
  border = (int) w /2; 
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

void mousePressed() {
  for(int x = 0; x < boardWidth; x ++) {
    for(int y = 0; y < boardHeight; y++) {
      if(hover[x][y]) {
        if(mouseButton == LEFT) {
          print("Clicked: " + x + ", " + y + " ");
          if(covered[x][y]) {
            if(!flagged[x][y]) {
              if(neighbors[x][y] == 0 && !hasBomb[x][y]) {
                clearField(x, y);  
                covered[x][y] = false;
              }
              else {
                covered[x][y] = false;  
              }
            }
            if(hasBomb[x][y]) {
              print("Game over ");
              //gameOver();
            }
          }
          //print("neighbors: " + neighbors[x][y] + " ");
        }
        else if(mouseButton == RIGHT) {
          flag(x, y);
        }
      }
    }
  }
}

void hoverHex() {
  for(int x = 0; x < boardWidth; x ++) {
    for(int y = 0; y < boardHeight; y++) {
      if((x%2) != 0) { 
        offset = h/2; //Offsets row y position on odd rows
      }
      else {
        offset = 0; //No offset on even rows
      }
      float hexX = border + x*.75*w;
      float hexY = 40 + border + offset + y*sqrt(3)/2*w;
      float disX = hexX - mouseX;
      float disY = hexY - mouseY;
      if (sqrt(sq(disX) + sq(disY)) < (s*(sqrt(3)/2))) {
        hover[x][y] = true;
      } else {
        hover[x][y] = false;
      }   
    }
  }
}

void clearField(int x, int y) {
  try {
    checkUp(x, y);
  }
  catch (Exception e) {}
  
  try {
    checkDown(x, y);
  }
  catch (Exception e) {}
  
  try {
    checkUpperRight(x, y);
  }
  catch (Exception e) {}
  
  try {
    checkUpperLeft(x, y);
  }
  catch (Exception e) {}
  
  try {
    checkLowerRight(x, y);  
  }
  catch (Exception e) {}
  
  try {
    checkLowerLeft(x, y);
  }
  catch (Exception e) {}
}

void flag(int x, int y) {
  if(covered[x][y]) {
    if(flagged[x][y]) {
      flagged[x][y] = false;  
      //print("Unflagged: " + x + ", " + y + " ");
    }
    else {
      flagged[x][y] = true;  
      //print("Flagged: " + x + ", " + y + " ");
    }
  }
}
