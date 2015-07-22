/*
CHALLENGE: ALGORITHM VISUALIZATION 
AUTHOR: AARON WASSERMAN

The sorting algorithm demonstrated is a modified comb sort where instead of shrinking 
the gap every pass it does it every term making it more like a bubble sort quicker while
still slightly improving it's efficiency. The comb sort like the bubble sort checks one 
term with another and swaps them if they are out of order. The comb sort compares a term
to that term + a gap while the bubble sort compares adjacent terms.

HELPFUL RESOURCES I USED:
  - https://en.wikipedia.org/wiki/Comb_sort
*/


int arraySize = 50; //# of terms in array
int[] values = new int[arraySize]; //Creates array with size defined by arraySize
boolean[] match = new boolean[arraySize];

boolean sortFinished = false; //Whether sorting is completed
boolean searchFinished = false; //Whether search is completed
boolean inputFinished = false; //Whether ascending or descending has been selected
boolean acceptNumber; //Whether the user can input a number to be searched
boolean foundMatch = false; //Whether the search algorithm found a match
boolean ascending; 
boolean startSearch = false;
boolean displayError;
boolean chosen = false; //Whether user has chosen ascending or descending

int beingChecked = 0; //Which array position is being checked
int gap; //The difference in array positions checked
int target; //Number the searching algorithm looks for

String tg = "";

void setup() {
  size(700, 700);
  gap = arraySize; //Sets the starting gap to the size fo the whole array
  randomArray(arraySize); //Assigns random numbers to each position in the array
}

void draw() {
  background(0, 0, 0);
  
  target = int(tg); 
  gui();
    
  if(inputFinished) {
    drawRectangles();
    algorithms();
  }
}

void drawRectangles() {
  rectMode(CENTER);
    for(int z = 0; z < arraySize; z++) {
      if(beingChecked == z) {
        fill(0, 0, 255); //Colors the bar being checked blue
      }
      else if (beingChecked + gap == z) {
        fill(0, 255, 0); //Colors the bar being compared green
      }
      else {
        fill(255, 255, 255); //Colors the other bars white
      }
      
      if(match[z]) {
        fill(255, 0, 0);
        foundMatch = true;  
      }
      rect(7 + (z * 14), width / 2, 14,  10 * values[z]); //Draws the rectangles
    }
}

void algorithms() {
  if(!sortFinished) {
    comb(beingChecked, gap);
    delay(10);
    beingChecked++;
    beingChecked %= 50;
    
    //Shrinks the gap unless it gets below 1
    gap = int(gap / 1.3);
    if(gap < 1) {
      gap = 1;
    }
    
    sortFinished = doubleCheck(); //Double checks order and sets soprtFinished to true if order is correct
  }
  else if (sortFinished && startSearch && !searchFinished) {   
    compare(beingChecked);
    checkSearch(beingChecked);
    delay(10);
    beingChecked++;
    beingChecked %= 50;

  }
  else {
    beingChecked = 51; //Sets beingChecked to a value outside of the array
  }

}

void gui() {
    if(displayError) {
    textSize(15);
    text("Number not between 1 and 50. Try again.", width/2 - 175, height - 30);
  }
  
  if(!chosen) {
    textSize(15);
    text("Press 'A' for ascending or 'D' for descending", width/2 - 175, 30);
  }
  
  
  if(inputFinished) {

    if(sortFinished) {
      textSize(15);
      text("Sort completed!", 10, 30); 
      text("Enter a number (1-50) to search for and press enter: " + target, 10, 50);
      acceptNumber = true;
    }
    
    if(searchFinished) {
      acceptNumber = false;
      if(foundMatch) {
        text("Search completed, match(es) found!", 10, 70); 
      }
      else {
        text("Search completed, NO match(es) found!", 10, 70); 
      }
    }
  }
}

void checkSearch(int c) {
  //Once the term being checked reached the last term the search finishes
  if(c == 49) {
    searchFinished = true;
  }
}

//Generates random values for the array and prints them to console (For checking if search works)
void randomArray(int n) {
  int size = n;
   
  for(int i = 0; i < size; i++) {
    values[i] = 1 + int(random(50)); //Assigns each array position to a random number from 0 - 49
    print(values[i] + " ");
  }
}

void compare(int compare) {
  try {
    if(values[compare] == target) { //Checks if a term is equal to the target of the search
      match[compare] = true;
    }
  }
  catch(Exception e) {}  
}

void comb(int compare, int gap) {
  try {
    //When ascending if a term's value is bigger than that of the term at it's position + the gap they swap values
    if(ascending) {
      if (values[compare] > values[compare + gap]) {
        swapVals(compare, gap);
        comb(compare, gap);
      }
    }
    //When descending if a term's value is smaller than that of the term at it's position + the gap they swap values
    else {
      if (values[compare] < values[compare + gap]) {
        swapVals(compare, gap);
        comb(compare, gap);
      }
    }
  }
  catch (Exception e) {}
}

void swapVals(int i, int gap) {
  int temp = values[i]; //Stores the value of the term
  values[i] = values[i + gap]; //Sets the value of the term to it's partner
  values[i + gap] = temp; //Sets the partner to the stored value of the term
}


boolean doubleCheck() {
  //Double check for ascending
  if(ascending) {
    for (int x = 0; x < values.length; x++) {
      try {
        if (values[x] > values[x + gap]) {
          return false;
        }
      }
      catch (Exception e) {}
    }
  }
  
  //Double check for descending
  else {
    for (int x = 0; x < values.length; x++) {
      try {
        if (values[x] < values[x + gap]) {
          return false;
        }
      }
      catch (Exception e) {}
    }
  }
  return true;
}

void keyReleased() {
  if(!chosen) {
    if(key == 'a' || key == 'A') {
      print("Ascending");
      ascending = true;
      inputFinished = true;  
      chosen = true;
    }
    else if(key == 'd' || key == 'D') {
      print("Descending");
      ascending = false;
      inputFinished = true;
      chosen = true;
    }
  }
  
  if(sortFinished && acceptNumber) {
    switch(key) {
      case 48: 
              tg += "0";
              break;
      case 49: 
              tg += "1";
              break;
      case 50: 
              tg += "2";
              break;
      case 51:
              tg += "3"; 
              break;
      case 52: 
              tg += "4";
              break;
      case 53: 
              tg += "5";
              break;
      case 54: 
              tg += "6";
              break;
      case 55: 
              tg += "7";
              break;
      case 56: 
              tg += "8";
              break;
      case 57:
              tg += "9";
              break;
           
    }
    if(key == ENTER || key == RETURN) {
      if(target > 50 || target < 1) {
        tg = "";
        target = 0;
        displayError = true;
      }
      else {
        acceptNumber = false;  
        displayError = false;
        startSearch = true;
      }
    }
  }
}

