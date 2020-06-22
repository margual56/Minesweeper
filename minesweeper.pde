boolean gameOver = false;

int cs = 35; //Cell size

int w = 30; //Number of x cells
int h = 24; //Number of y cells

int n_bombs = 200;//335; //Number of bombs
int n_marked = 0; //Number of markers

PImage covered, covered_marked, mine, mine_exploded;
PFont cellFont;

Cell[][] grid = new Cell[w][h];

void settings() {
  size(w*cs+1, h*cs+1);
}


void setup(){
  //------------------IMAGES SETUP------------------------
  covered =loadImage("images/covered.png");
  covered_marked = loadImage("images/covered_marked.png");
  mine =loadImage("images/mine.png");
  mine_exploded =loadImage("images/mine_exploded.png");
  //------------------------------------------------------
  
  
  //---------------GRID AND CELL SETUP--------------------
  //Create cells
  for(int x = 0; x<w; x++){
    for(int y = 0; y<h; y++){
      grid[x][y] = new Cell(x, y);
    }
  }
  
  //Create bombs
  int curr_bombs = 0; //the current number of bombs in the game
  do{
    int r_x = round(random(w-1));
    int r_y = round(random(h-1));
    
    if(!grid[r_x][r_y].bomb){
      grid[r_x][r_y].bomb = true;
      curr_bombs++;
    }
  }while(curr_bombs<n_bombs);
  
  //Post create event (check neighbors)
  for(int x = 0; x<w; x++){
    for(int y = 0; y<h; y++){
      grid[x][y].post_create();
    }
  }
  //------------------------------------------------------
  
  
  //------------------TEXT SETUP--------------------------
  textAlign(CENTER, CENTER);
  cellFont = createFont("Arial", cs*0.75);
  textFont(cellFont);
  //------------------------------------------------------
  
  //frameRate(1);
}

void draw(){
  background(178);
  
  for(int x = 0; x<w; x++){
    for(int y = 0; y<h; y++){
      grid[x][y].show();
    }
  }
  
  //----------------------GAME OVER-----------------------
  if(gameOver){
    fill(255, 0, 0);
    float s = g.textSize;
    float ss;
    for(ss = s; textWidth("GAME OVER")<width*0.75; ss+=5){
      textSize(ss);
    }
    
    int offst = 3;
    for(int i = -offst; i<=offst; i+=1){
      for(int j = -offst; j<=offst; j+=1){
        if(i != 0 && j != 0){
          fill(0);
        
          text("GAME OVER", width/2+i, height/2+j);
        }
      }
    }
    
    fill(255,0,0);
    text("GAME OVER", width/2, height/2);
    
    textSize(s);
    //----------------------------------------------------
  }
    
}

void mousePressed(){
  if(!gameOver){
    if(mouseButton == LEFT){//-------------LEFT CLICK
      leftPressed(floor(mouseX/cs), floor(mouseY/cs));
    }else{//------------------------------RIGHT CLICK
      rightPressed(floor(mouseX/cs), floor(mouseY/cs));
    }//----------------------------------------------
  }
  
}

void leftPressed(int xx, int yy){
  /*/int xx = floor(_x/cs);
  int yy = floor(_y/cs);*/
  
  if(grid[xx][yy].bomb){
    grid[xx][yy].exploded = true;
    gameOver = true;
    gameOver();
    return;
  }else if(!grid[xx][yy].marked){
    if(!grid[xx][yy].uncovered){
      grid[xx][yy].uncovered = true;
      
      updateGrid();
    }
  }
}

void rightPressed(int xx, int yy){
  /*int xx = floor(_x/cs);
  int yy = floor(_y/cs);*/
  
  if(!grid[xx][yy].uncovered){
    grid[xx][yy].marked = !grid[xx][yy].marked;
    n_marked += grid[xx][yy].marked?1:-1;
  }
}

void updateGrid(){
  for(int i = 0; i<25; i++){ //Repeat 25 times
    for(int x = 0; x<w; x++){
      for(int y = 0; y<h; y++){
        grid[x][y].update();
      }
    }
  }
}

void gameOver(){
  for(int x = 0; x<w; x++){
    for(int y = 0; y<h; y++){
      grid[x][y].uncovered = true;
    }
  }
}

color getColor(int n){
  switch(n){
     case 1:
       return color(0, 0, 255);
     
     case 2:
       return color(0, 168, 0);
       
     case 3:
       return color(255, 0, 0);
       
     case 4:
       return color(31, 0, 94);
       
     case 5:
       return color(150, 0, 0);
       
     case 6:
       return color(0, 146, 183);
       
     case 7:
       return color(0);
       
     case 8:
       return color(180, 0, 180);
       
     case 9:
       return color(255, 100, 0);
       
     default:
       return color(0);
  }
}
