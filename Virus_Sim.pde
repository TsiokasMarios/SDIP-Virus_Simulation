//Colors
final int green = color(57, 227, 64);
final int red = color(237, 5, 9);
final int yellow = color(233, 255, 0);
final int blue = color(0, 185, 255);

//Status a human can have
static final int HEALTHY = 0;
static final int INFECTED = 1;
static final int SICK = 2;
static final int RECOVERED = 3;

int healthyCounter;
int infectedCounter;
int sickCounter;
int recoveredCounter;

//Human[] humans;
ArrayList<Human> humans;
Hospital hospital;
Virus virus;

//Initialize the humans and virus
void init() {
  //humans = new Human[200];
  //for (int i = 0; i < humans.length; i++) {
  //  humans[i] = new Human();
  //}
  
  hospital = new Hospital();
  humans = new ArrayList();
  for (int i = 0; i < 201; i++) {
    humans.add(new Human());
  }

  virus = new Virus(10, 20);

  //healthyCounter = humans.length;
  healthyCounter = humans.size();
  infectedCounter = 0;
  sickCounter = 0;
  recoveredCounter = 0;
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
  hospital.display();
  //for (int i = 0; i < humans.length; i++) {
  //  humans[i].step();
  //  humans[i].passEdges();
  //  humans[i].display();

  //  for (int j = 0; j < humans.length; j++) {
  //    //Check if 2 humans interact
  //    if (i != j && humans[i].intersect(humans[j])) {
  //      //Check if either of the humans are infected or sick
  //      //If one of them is sick or infected and the other human is healthy
  //      //Try to transmit the virus
  //      if ((humans[i].status == INFECTED || humans[i].status == SICK)  && humans[j].status == HEALTHY) {
  //        humans[i].transmit(humans[j]);
  //      } else if ((humans[j].status == INFECTED || humans[j].status == SICK) && humans[i].status == HEALTHY) {
  //        humans[j].transmit(humans[i]);
  //        //If true try to infect the other human
  //      }
  //    }
  //  }
    
  //  //virus.kill(humans[i],i);
    
  //  //The virus tries to make a human sick
  //  //For now it works
  //  //In the future compare it with when a human got infected
  //  if (frameCount % 500 == 0) {
  //    virus.getSick(humans[i]);
  //  }
  //  if (frameCount % 700 == 0) {
  //    humans[i].recover();
  //  }
  //}
  
  //Arraylist attempt
  for (int i = 0; i < humans.size(); i++) {
    Human tempI = humans.get(i);
    tempI.step();
    tempI.passEdges();
    tempI.display();

    for (int j = 0; j < humans.size(); j++) {
      Human tempJ = humans.get(j);
      //Check if 2 humans interact
      if (i != j && tempI.intersect(tempJ)) {
        //Check if either of the humans are infected or sick
        //If one of them is sick or infected and the other human is healthy
        //Try to transmit the virus
        if ((tempI.status == INFECTED || tempI.status == SICK)  && tempJ.status == HEALTHY) {
          tempI.transmit(tempJ);
        } else if ((tempJ.status == INFECTED || tempJ.status == SICK) && tempI.status == HEALTHY) {
          tempJ.transmit(tempI);
          //If true try to infect the other human
        }
      }
    }
    
   
    
    //The virus tries to make a human sick
    //For now it works
    //In the future compare it with when a human got infected
    if (frameCount % 500 == 0) {
      virus.getSick(tempI);
    }
    if (frameCount % 700 == 0) {
      tempI.recover();
    }
    
    virus.kill(tempI);
  }
  fill(200);
  textSize(20);
  text("Healthy: "+healthyCounter, 20, 20);
  text("Infected: "+infectedCounter, 20, 40);
  text("Sick: "+sickCounter, 20, 60);
  text("Recovered: "+recoveredCounter, 20, 80);
  text("Frame: " + frameCount, 20, 100);
}

//Infect a random human upon click
void mouseClicked() {
  virus.randomInfect();
}

//Press S to pause or unpause the simulation
void keyPressed() {
  final int k = keyCode;

  if (k == 'S') {
    if (looping) {
      noLoop();
    } else {
      loop();
    }
  } else if (k == 'R') {
    init();
  }
}
