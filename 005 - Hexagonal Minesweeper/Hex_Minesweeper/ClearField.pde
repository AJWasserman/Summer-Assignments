void checkUp(int x, int y) {
  int j = x;
  int k = y - 1;
  if(neighbors[j][k] == 0 && covered[j][k]) {
    try {
      checkUp(j, k);
      covered[j][k] = false;      
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }
    try {
      checkUpperLeft(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    }   
    try {
      checkUpperRight(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    }  
  }
  else {
    try {
      covered[j][k] = false;  
    }
    catch (Exception e) {}
  } 
}

void checkDown(int x, int y) {
  int j = x;
  int k = y + 1;
  if(neighbors[j][k] == 0) {
    try {
      checkDown(j, k);
      covered[j][k] = false;
    }
    catch (Exception e) {
      covered[j][k] = false;
    }    
    try {
      checkLowerLeft(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    }   
    try {
      checkLowerRight(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    }   
  }
  else {
    try {
      covered[j][k] = false;  
    }
    catch (Exception e) {}
  } 
}

void checkUpperRight(int x, int y) {
  int j;
  int k;
  if((x%2) == 0) {
    j = x + 1;
    k = y - 1;
  }
  else {
    j = x + 1;
    k = y;
  }
  if(neighbors[j][k] == 0) {
    try {
      checkUp(j, k);   
      covered[j][k] = false;   
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }
    
    try {
      checkUpperRight(j, k);
      covered[j][k] = false;   
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }  
    try {
      checkLowerRight(j, k);
      covered[j][k] = false;   
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }  
  }
  else {
    try {
      covered[j][k] = false;  
    }
    catch (Exception e) {}
  } 
}

void checkUpperLeft(int x, int y) {
  int j;
  int k;
  if((x%2) == 0) {
    j = x - 1;
    k = y - 1;
  }
  else {
    j = x - 1;
    k = y;
  }
  if(neighbors[j][k] == 0) {
    try {
      checkUpperLeft(j, k);
      covered[j][k] = false;      
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }   
    try {
      checkUp(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    } 
    try {
      checkLowerLeft(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    } 
  }
  else {
    try {
      covered[j][k] = false;  
    }
    catch (Exception e) {}
  } 
}

void checkLowerRight(int x, int y) {
  int j;
  int k;
  if((x%2) == 0) {
    j = x + 1;
    k = y;
  }
  else {
    j = x + 1;
    k = y + 1;
  }
  if(neighbors[j][k] == 0) {
    try {
      checkLowerRight(j, k);
      covered[j][k] = false;      
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }   
    try {
      checkUpperRight(j, k);
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }   
    try {
      checkDown(j, k);   
    }
    catch (Exception e) {}
  }
  else {
    try {
      covered[j][k] = false;  
    }
    catch (Exception e) {}
  } 
}

void checkLowerLeft(int x, int y) {
  int j;
  int k;
  if((x%2) == 0) {
    j = x - 1;
    k = y;
  }
  else {
    j = x - 1;
    k = y + 1;
  }
  if(neighbors[j][k] == 0) {
    try {
      checkLowerLeft(j, k);
      covered[j][k] = false;      
    } 
    catch (Exception e) {
      covered[j][k] = false;
    }  
    try {
      checkUpperLeft(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    }   
    try {
      checkDown(j, k);
    }
    catch (Exception e) {
      covered[j][k] = false;
    }  
  }
  else {
    try {
      covered[j][k] = false;  
    }
    catch (Exception e) {}
  } 
}
