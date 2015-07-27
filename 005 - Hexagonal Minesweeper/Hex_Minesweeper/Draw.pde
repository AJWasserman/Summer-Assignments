void drawMenu() {
    fill(200, 200, 200);
    rectMode(CENTER);
    rect(width/2, 20, width, 100);
    fill(100, 0, 0);
    textSize(48);
    textAlign(CENTER, CENTER);    
    text("Hexagonal Minesweeper", width/2, 30);
    
    fill(200, 200, 200);
    rectMode(CENTER);
    rect(width/2, 175, 400, 100);
    fill(100, 0, 0);
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Play now!", width/2, 175);
    
    fill(200, 200, 200);
    rectMode(CENTER);
    rect(width/2, 300, 400, 100);
    fill(100, 0, 0);
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Options", width/2, 300);

    
    fill(200, 200, 200);
    rectMode(CENTER);
    rect(width/2, 425, 400, 100);
    fill(100, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("Controls", width/2, 425);
    
    if(displayOptions) {
      
      fill(200, 200, 200);
      rect(width/2, 595, 600, 175);
      
      fill(220, 220, 220);
      rect(width/2, 555, 500, 70);
      
      fill(220, 220, 220);
      rect(width/2, 635, 500, 70);
      
      textSize(48);
      fill(100, 0, 0);
      text("Easy", width/2, 550);
      text("Normal", width/2, 630);
    }
    if(displayControls) {
      fill(200, 200, 200);
      rect(width/2, 595, 600, 175);
      fill(100, 0, 0);
      textSize(32);
      text("Left Click: Reveal", width/2, 550);
      text("Right Click: Flag/Unflag", width/2, 590);
      text("R: Reset (When won/lost)", width/2, 630);
    }

}

void drawBoard() {
  textAlign(CENTER, CENTER);
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
      if(!covered[x][y] && !hasBomb[x][y]) {
        textSize(15);
        fill(0, 0, 0);
        textAlign(CENTER, CENTER);
        text(neighbors[x][y], border + x*.75*w, 40 + border + offset + y*sqrt(3)/2*w);
      }
      if(flagged[x][y]) {
        textSize(15);
        fill(0, 0, 0);
        text("F", border + x*.75*w, 40 + border + offset + y*sqrt(3)/2*w);  
      }
      if(gameOver) {
        rectMode(CENTER);
        fill(100, 100, 100);
        rect(width/2, 40 + height/2, 300, 100);  
      }
      if(gameOver && won) {
        textSize(48);
        stroke(0, 0, 0);
        fill(255, 0, 0);
        text("You win!", width/2, 20 + height/2);  
      }
      if(gameOver && !won) {
        textSize(48);
        fill(0, 0, 0);
        text("You lose!", width/2, 20 + height/2);  
      }
      if(gameOver) {
        textSize(32);
        stroke(0, 0, 0);
        fill(255, 0, 0);
        text("Press 'r' to restart", width/2, 60 + height/2); 
      }
      fill(200, 200, 200);
      rectMode(CENTER);
      rect(width/2, 20, width, 40);
      fill(100, 0, 0);
      textSize(32);
      text("Flags remaining: " + (bombCount - flagCount), 175, 15);
      popMatrix();   
    }
  }
}
