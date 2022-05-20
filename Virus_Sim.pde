final int green = color(57, 227, 64);
final int red = color(237, 5, 9);


//This is a test for git manager

Human[] humans;
Virus virus;

void init() {
  humans = new Human[200];
  for (int i = 0; i < humans.length; i++) {
    humans[i] = new Human();
  }
  virus = new Virus();
}

void setup() {
  surface.setResizable(true);
  background(0);
  size(800, 700);
  frameRate(60);
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
        if (humans[i].isInfected) {
          humans[i].transmit(humans[j]);
        } 
        else if (humans[j].isInfected) {
          humans[j].transmit(humans[i]);
          //If true try to infect the other human
        }
      }
    }
  }
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
