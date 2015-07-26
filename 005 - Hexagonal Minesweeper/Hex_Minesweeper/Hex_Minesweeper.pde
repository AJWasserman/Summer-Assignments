/*
<-- CUSTOMIZE BOARD SIZE AND BOMB COUNT HERE -->
*/
int boardWidth = 9;
int boardHeight = 9;
int bombCount = 10;
int flagCount = 0;
/*
<-- END CUSTOMIZATION -->
*/

//2D Arrays
boolean[][] hasBomb = new boolean[boardWidth][boardHeight];
boolean[][] flagged = new boolean[boardWidth][boardHeight];
int[][] neighbors = new int[boardWidth][boardHeight];
boolean[][] covered = new boolean[boardWidth][boardHeight];
boolean[][] placed = new boolean[boardWidth][boardHeight];
boolean[][] hover = new boolean[boardWidth][boardHeight];
boolean[][] unN = new boolean[boardWidth][boardHeight];

//Menu booleans
boolean start = false;
boolean options = false;
boolean controls = false;
boolean displayOptions = false;
boolean displayControls = false;

//Hexagon Variables
float s; //Side length
float w; //Wdith
float h; //Height
float offset; 
int border; 

//Game state booleans
boolean menu = true;
boolean inGame = false;
boolean gameOver = false;
boolean won = false;

void setup() {
  size(700, 700);
  frame.setTitle("Hexagonal Minesweeper");
  
    placeBombs(); //Generate bomb positions
  
  //Generate starting states for some of the 2D arrays
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      placed[x][y] = false;
      unN[x][y] = true;
      covered[x][y] = true;
      neighborBombs(x, y);
    }
  }
}

void draw() {
  background(102);
  if(menu) {
    drawMenu();
    checkStart();
    checkOptions();
    checkControls();
  }
    
  if(inGame) {

    frame.setResizable(true);
    genVariables(); 
    
    hoverHex();
    
    drawBoard();  
    frame.setSize((int)((boardWidth*1.55*s + (w / 2))), (int)(50 + 2 * border + offset + (sqrt(3)/2) * w * boardHeight));
    
    checkWin();
  }
}

//Checks if cursor is above start button
void checkStart() {
  if(mouseX > (width/2 - 200) && mouseX < (width/2 + 200) && mouseY > 125 && mouseY < 225) {
    start = true;  
  }
  else {
    start = false;  
  }
}

//Checks if cursor is above options button
void checkOptions() {
  if(mouseX > (width/2 - 200) && mouseX < (width/2 + 200) && mouseY > 250 && mouseY < 350) {
    options = true;  
  }
  else {
    options = false;  
  }
}

//Checks if cursor is above controls button
void checkControls() {
  if(mouseX > (width/2 - 200) && mouseX < (width/2 + 200) && mouseY > 375 && mouseY < 475) {
    controls = true;  
  }
  else {
    controls = false;
  }
}

void placeBombs() {  
  int placeCount = bombCount;
  //Seed changes every millis so bombs are in a different spot without restarting sketch
  randomSeed(millis()); 
  for(int i = 0; i < placeCount; i++) {
    int randX = (int)random(boardWidth);
    int randY = (int)random(boardHeight);
    
    //If a bomb has already been placed it increases the amount of bombs being placed
    if(placed[randX][randY]) {
      //print("dupe ");
      placeCount++;
    }
    else {
      hasBomb[randX][randY] = true;
      placed[randX][randY] = true;
    }
  }
}

void neighborBombs(int x, int y) {
  int bc = bombCount;
  int bw = boardWidth;
  int bh = boardHeight;
  
  //Sets neighbors[][] for all hexagons neighboring a bomb
  try {
    //Checks neighbors for bombs in even columns
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
      
      unN[x][y] = false; //Makes sure bomb only increases neighbors once
    }
    //Checks neighbors for bombs in odd columns
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
      
      unN[x][y] = false; //Makes sure bomb only increases neighbors once
    }
    else {}
  }
  catch (Exception e) {}
}

//Initializes the hexagon vriables
void genVariables() {
  s = maxSize(); //Side length
  w = 2*s; //Width
  h = sqrt(3)/2*w; //Height 
  border = (int) w /2; 
}

//Determines max hexagon size based on size inputted
float maxSize() {
  float sl = 0;
  
  for(double i = 0; i < 200; i += .01) {
      if(boardWidth * (1.6 * i) < 680 && boardHeight *(sqrt(3)/2) * 2 * i < 725) {
        sl = (float) i;
      }
  }
  return (float) sl;
}

//Defines the hexagon shape
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
  if(!gameOver) {
    if(start) {
      menu = false;
      inGame = true;  
    }
    if(options) {
      displayControls = false;
      displayOptions = true;  
    }
    if(controls) {
      displayOptions = false;
      displayControls = true;  
    }
    for(int x = 0; x < boardWidth; x ++) {
      for(int y = 0; y < boardHeight; y++) {
        if(hover[x][y]) {
          if(mouseButton == LEFT) {
            //print("Clicked: " + x + ", " + y + " ");
            if(covered[x][y]) {
              if(!flagged[x][y]) { //Can't click a flagged hexagon
                //If you click a hexagon with no neighbors it clears a field
                if(neighbors[x][y] == 0 && !hasBomb[x][y]) {
                  clearField(x, y);  
                  covered[x][y] = false;
                }
                else {
                  //If it has neighbors only the tile clicked is revealed
                  covered[x][y] = false;  
                }
              }
              //Clicking a bomb causes you to lose
              if(hasBomb[x][y]) {
                gameOver();
              }
            }
          }
          else if(mouseButton == RIGHT) {
            flag(x, y);
          }
        }
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

//Keyboard input
void keyReleased() {
  if(gameOver) {
    if(key == 'R' || key == 'r') {
      reset();
    }
  }
}

//Checks which hexagon the cursor is over and sets it's hover array to true
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

void flag(int x, int y) {
  if(covered[x][y]) {
    if(flagged[x][y]) {
      flagged[x][y] = false;  
      flagCount--;
      //print("Unflagged: " + x + ", " + y + " ");
    }
    else {
      if(flagCount < bombCount) {
        flagged[x][y] = true;  
        flagCount++;
      }
      //print("Flagged: " + x + ", " + y + " ");
    }
  }
}

void checkWin() {
  int correctFlag = 0;
  int uncovered = 0;
  
  for(int x = 0; x < boardWidth; x++) {
    for(int y = 0; y < boardHeight; y++) {
      //If a flagged hexagon has a bomb it increases the amount of correct flags
      if(hasBomb[x][y] && flagged[x][y]) {
        correctFlag++;
      }  
      //If a hexagon isn't covered it increases uncovered
      if(!covered[x][y]) {
        uncovered++;  
      }
    }
  }
  
  //If the amount of correct flags is equal to the bombs you win
  if(correctFlag == bombCount) {
    gameOver = true;
    won = true;
  }
  
  //If the amount of uncovered hexagons is the total hexagons minus bombs you win
  if(uncovered == (boardWidth * boardHeight) - bombCount) {
    gameOver = true;
    won = true;      
  }
}

//Runs when you win or lose
void gameOver() {
  gameOver = true;
  for(int x = 0; x < boardWidth; x++) {
    for(int y = 0; y < boardHeight; y++) {
      covered[x][y] = false; //Reveals all cells at end of game
      flagged[x][y] = false; //Removes flags at end of games
    }
  }
}

//Sets all booleans and arrays back to their initial states and re-places bombs
void reset() {
  gameOver = false;
  won = false;
  flagCount = 0;
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      neighbors[x][y] = 0;
      hasBomb[x][y] = false;
      placed[x][y] = false;
      unN[x][y] = true;
      covered[x][y] = true;
      flagged[x][y] = false;
    }
  }
  placeBombs(); 
  for(int x = 0; x < boardWidth; x++) { 
    for(int y = 0; y < boardHeight; y++) {
      neighborBombs(x, y); //Finds new neighboring hexagons
    }
  }
}


