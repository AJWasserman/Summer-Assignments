/*
CHALLENGE: HEXAGONAL GAME OF LIFE
AUTHOR: AARON WASSERMAN
RULE: B4,5,6 S2,3

For this challenge I used a lot of nexted for loops to fill for 25 X spaces
and 25 Y spaces to account for the 625 hexagons. It also uses try/catch
which I didn't know before the challenge. The original states are determined
randomly.

MY SCRATCH PAPER: http://i.imgur.com/hwm5rbe.jpg

Also note that Carson and I did share a rule so our code will have some major similarities.

HELPFUL RESOURCES I USED:
  - http://www.redblobgames.com/grids/hexagons/
  - https://processing.org/examples/regularpolygon.html
  
(You will see a lot of ideas I used in the Red Blob link. 
Great descriptions if using hexagons without giving code.)
*/

float s = 12; //Side length
float w = 2*s; //Width
float h = sqrt(3)/2*w; //Height 

int border = 15; //Gives room between grid and window edges
float offset; //Variable for offsetting odd rows

boolean[][] cycle = new boolean[25][25]; //Array of starting cells being alive or dead

color dead = color(153);
color alive = color(204, 102, 0);

void setup() {
  size(465, 540); 
  lifeCycle(); //Calls the original (and random) states
}

void draw() { 
  background(102);
  
  try {
    Thread.sleep(500);   //Allows for a delay in between cycles
    updateCycle();
  }
  catch (Exception e) {}
  
  //Draws hexagons to form a grid
  for(int x = 0; x < 25; x++) { //Rows
      for(int y = 0; y < 25; y++) { //Columns
        if((x%2) != 0) { //Checks if number is odd or even
          offset = h/2; //Offsets row y position on odd 
        }
        else {
          offset = 0; //Even has no offset
        }
        
        pushMatrix();
        if(cycle[x][y]) {
          fill(alive); //Colors orange when cell is alive
        }
        else {
          fill(dead); //Colors grey when cell is dead
        }
        hexagon(border + x*.75*w, border + offset + y*sqrt(3)/2*w); //Draws hexagons in rows/columns from nested loops
        popMatrix();   
      }
    }
}

//Gives vertex locations relative to hexagon center
//Image I "named" each vertex with: http://i.imgur.com/IAay7D0.png
void hexagon(float x, float y) { 

   beginShape();
   vertex(x+s, y); //Position of vertice 2 relative to center
   vertex(x+s/2, y+(sqrt(3)/2*w)/2); //Position of vertice 3 relative to center
   vertex(x-s/2, y+(sqrt(3)/2*w)/2); //Position of vertice 4 relative to center
   vertex(x-s, y); //Position of vertice 5 relative to center
   vertex(x-s/2, y-(sqrt(3)/2*w)/2); //Position of vertice 0 relative to center
   vertex(x+s/2, y-(sqrt(3)/2*w)/2); //Position of vertice 1 relative to center
   endShape(CLOSE);
}


//Randomly generates original state
void lifeCycle() {
    for (int x = 0; x < 25; x++) {
      for (int y = 0; y < 25; y++) {
        
        //If the generated number rounds to 0 the hexagon is alive
        int random = floor(random(2));
        if (random == 0) {
          this.cycle[x][y] = true;
        }
        else {
          this.cycle[x][y] = false;
        }
      }
    }
}


void updateCycle() {
  boolean[][] nextCycle = new boolean[25][25];
    for (int x = 0; x < 25; x++) {
      for (int y = 0; y < 25; y++) {
        int livingNeighbors = 0;
        if((x%2) != 0) { //Checks if number is odd or even
          offset = h/2; //Offsets row y position on odd 
        }
        else {
          offset = 0; //Even has no offset
        }
        
        try {
          
          //Checks bordering hexagons for even columns
          //I referenced Red Blob (linked above) for how neighbors are found in the array
          if (x % 2 == 0) {
            if (this.cycle[x][y - 1]) {
              livingNeighbors++;
            }
            if (this.cycle[x+1][y]) {
              livingNeighbors++;
            }
          
            if (this.cycle[x+1][y + 1]) {
              livingNeighbors++;
            }
            if (this.cycle[x][y + 1]) {
              livingNeighbors++;
            }
            if (this.cycle[x - 1][y + 1]) {
              livingNeighbors++;
            }
            if (this.cycle[x - 1][y]) {
              livingNeighbors++;
            }
          }
          //Checks bordering hexagons for odd columns
          else {
            if (this.cycle[x][y-1]) {
              livingNeighbors++;
            }
            if (this.cycle[x + 1][y - 1]) {
              livingNeighbors++;
            }
            if (this.cycle[x][y]) {
              livingNeighbors++;
            }
            if (this.cycle[x + 1][y]) {
              livingNeighbors++;
            }
            if (this.cycle[x][y + 1]) {
              livingNeighbors++;
            }
            if (this.cycle[x - 1][y]) {
              livingNeighbors++;
            }
            if (this.cycle[x - 1][y - 1]) {
              livingNeighbors++;
            }
          }
        }
        catch (Exception e) {
          System.out.println(e.toString());
        }
        
        
        //Takes livingHeighbors determined above and applies the rule to each hexagon.
        if (cycle[x][y]) {
          if (livingNeighbors < 2) {
            nextCycle[x][y] = false;
          }
          else if (livingNeighbors == 2 || livingNeighbors == 3) {
            nextCycle[x][y] = true;
          }
          else if (livingNeighbors > 3) {
            nextCycle[x][y] = false;
          }
        }
        else {
          if (livingNeighbors > 3) {
            nextCycle[x][y] = true;
          }
          else {
            nextCycle[x][y] = false;
          }
          
        }
      }
      
    }
    cycle = nextCycle; //Sets current cycle to the newly created one
}

