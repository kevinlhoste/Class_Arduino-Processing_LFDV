
int score=0;
int ballX=250;
int ballY=250;
int ballDiameter=80;
int raquetteX=450;
int raquetteY=250;
int gameStarted=0;
int ballDirection=1;
int speedX=5;
int speedY=5;


void setup()
  {
  size(500,500); 
  rectMode(CENTER);
  }
  
void draw()
  {
  background(0); 
  ellipse(ballX,ballY,ballDiameter,ballDiameter);
  rect(10,250,20,500);
  raquetteY=mouseY;
  rect(450,raquetteY,20,100);  
  }
