//Colors
final int green = color(57, 227, 64);
final int red = color(237, 5, 9);
final int yellow = color(233,255,0);
final int blue = color(0,185,255);

//Status a human can have
static final int HEALTHY = 0;
static final int INFECTED = 1;
static final int SICK = 2;
static final int RECOVERED = 3;

Human[] humans;
Virus virus;
int healthyCounter;
int infectedCounter;
int sickCounter;
int recoveredCounter;

//Initialize the humans and virus
void init() {
  humans = new Human[200];
  for (int i = 0; i < humans.length; i++) {
    humans[i] = new Human();
  }
  virus = new Virus(10,20);
}

void setup() {
  surface.setResizable(true);
  background(0);
  size(800, 700);
  frameRate(60);
  healthyCounter = 0;
  infectedCounter = 0;
  sickCounter = 0;
  recoveredCounter = 0;
  init();
}

void draw() {
  background(0);
  for (int i = 0; i < humans.length; i++) {
    humans[i].step();
    humans[i].passEdges();
    humans[i].display();

    for (int j = 0; j < humans.length; j++) {
      //Check if 2 humans interact
      if (i != j && humans[i].intersect(humans[j])) {
        //Check if either of the humans are infected
        if (humans[i].status == INFECTED || humans[i].status == SICK ) {
          humans[i].transmit(humans[j]);
        } 
        else if (humans[j].status == INFECTED || humans[j].status == SICK) {
          humans[j].transmit(humans[i]);
          //If true try to infect the other human
        }
      }
      if(frameCount % 500 == 0)
      humans[i].recover();
      virus.getSick(humans[i]);
      if (humans[i].status == HEALTHY)
          healthyCounter++;
      else if(humans[i].status == INFECTED)
          infectedCounter++;
      else if(humans[i].status == SICK)
          sickCounter++;
      else if(humans[i].status == RECOVERED)
          recoveredCounter++;
    }
  }
  fill(200);
  textSize(20);
  text("Healthy: "+healthyCounter, 20, 20);
  text("Infected: "+infectedCounter, 20, 40);
  text("Sick: "+sickCounter, 20, 60);
  text("Recovered: "+recoveredCounter, 20, 80);
  
}

//Infect a random human upon click
void mouseClicked() {
  virus.randomInfect(humans);
}

//Press S to pause or unpause the simulation
void keyPressed() {
  final int k = keyCode;

  if (k == 'S') {
    if (looping){
      noLoop();
    }
    else{
      loop();
    }
  }
  else if (k == 'R'){
    init();
  }
}
