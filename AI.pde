class AI{
  
  int s_x = 0; //Start x
  int s_y = 0; //Start y
  
  int c_x, c_y; //Current cell's coordinates
  
  boolean finished = false;
  
  ArrayList<PVector> suspicious = new ArrayList<PVector>();
  
  AI(){
    c_x = s_x;
    c_y = s_y;
  }
  
  void update(){
    if(c_x<w && c_y<h){
      leftPressed(c_x, c_y);
      
      updateGrid();
      
      if(grid[c_x][c_y].my_value == 0){
        if(c_x+1<w){c_x++;
        }else if(c_y+1<h){c_y++;}
      }else{
        /*
        if the number of cells covered around the current one is less than or equal to the cell's value, uncover all of them
        */
      }
    }else{
      finished = true;
    }    
  }
}
