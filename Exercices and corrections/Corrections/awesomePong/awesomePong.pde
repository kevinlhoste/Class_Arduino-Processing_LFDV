import processing.serial.*;

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
Serial myPort;                       // The serial port
int[] serialInArray = new int[3];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive           // Starting position of the ball
boolean firstContact = false;     

void setup()
  {
  size(500,500); 
  rectMode(CENTER);
  for(int i=0;i<5;i++)
    {
      score=score+1;
      println(score);
    }
   // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);  
  }
  
void draw()
  {
  background(0); 
  ellipse(ballX,ballY,ballDiameter,ballDiameter);
  rect(10,250,20,500);
  //raquetteY=mouseY;
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
      /*if(ballDirection==1)
        {
        ballX=ballX+1;
        ballY=ballY+1;
        }
      else if(ballDirection==-1)
        {
       println("reverse");
        ballX=ballX-1;
        ballY=ballY-1;
        }  */
      //println(ballX);
      //ellipse(ballX,ballY,ballDiameter,ballDiameter);
    
    }
  }
  
 void mousePressed() {
  gameStarted = 1;
} 

void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    } 
  } 
  else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 2 ) {
      raquetteY = serialInArray[0];
      int xpos = serialInArray[1];
      int fgcolor = serialInArray[2];

      // print the values (for debugging purposes only):
      println(raquetteY);

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
}

