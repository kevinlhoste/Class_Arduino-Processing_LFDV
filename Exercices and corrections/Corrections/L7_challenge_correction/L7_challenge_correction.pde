
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
  if(gameStarted==1)
    {
    ballX=ballX+speedX;
    ballY=ballY+speedY;  
    if((ballX+(ballDiameter/2)==raquetteX) && (ballY<raquetteY+50) &&(ballY>raquetteY-50))
      {
      speedX=speedX*-1;
      }
    else if(ballX-(ballDiameter/2)==0)
      {
      speedX=speedX*-1;
      }
    else if(ballX+(ballDiameter/2)==500)
      {
      println("perdu");
      gameStarted=0;
      ballX=250;
      ballY=250;
      } 
   if(ballY==500)
      {
      speedY=speedY*-1;
      }
   else if(ballY==0)
      {
      speedY=speedY*-1;
      }    
    }
  }
  
 void mousePressed() {
  gameStarted = 1;
} 
