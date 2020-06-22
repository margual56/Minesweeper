class Cell{
  int x;
  int y;
  int my_value = 0;
  boolean uncovered = false;
  boolean marked = false;
  boolean exploded = false;
  boolean bomb;
  
  Cell(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void post_create(){
    my_value = get_value();
  }
  
  int get_value(){ //Get the count of neighbors who have bombs
    int v = 0;
    
    for(int i = -1; i<=1; i++){
      for(int j = -1; j<=1; j++){
        try{
          v += grid[x+i][y+j].bomb?1:0;
        }catch(ArrayIndexOutOfBoundsException e){}
      }
    }
    
    return v;
  }
  
  void update(){
    if(!uncovered && !marked){
      uncovered = checkUncover();
    }
  }
  
  void show(){
    if(!uncovered){
      if(marked){
        image(covered_marked, x*cs, y*cs, cs, cs);
      }else{
        image(covered, x*cs, y*cs, cs, cs);
      }
    }else{
      stroke(0, 200);
      fill(200);
      rect(x*cs, y*cs, cs, cs);
      
      if(bomb){
        if(exploded){
          image(mine_exploded, x*cs, y*cs, cs, cs);
        }else{
          image(mine, x*cs, y*cs, cs, cs);
        }
      }else if(my_value>0){
        fill(getColor(my_value));
        text(Integer.toString(my_value), x*cs+cs/2, y*cs+cs/2-2);
      }
    }
  }
  
  boolean checkUncover(){
    for(int i = -1; i<2; i++){
      for(int j = -1; j<2; j++){
        try{
          boolean isuncovered = grid[x+i][y+j].uncovered;
          
          boolean iscero = grid[x+i][y+j].my_value==0;
          if(iscero && isuncovered){return true;}
          
        }catch(ArrayIndexOutOfBoundsException e){}
      }
    }
    
    return false;
  }
}
