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


ArrayList<Human> humans;
Hospital hospital;
Virus virus;

//Initialize the humans and virus
void init() {
  
  hospital = new Hospital();
  humans = new ArrayList();
  for (int i = 0; i < 201; i++) {
    humans.add(new Human());
  }

  virus = new Virus(10, 20);

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
  
  //Setting i < humans.size() - 1, 
  //because once you check the final human you dont need to compare them against anyone
  for (int i = 0; i < humans.size() - 1; i++) { 
    Human humanI = humans.get(i); //Instead of using humans.get(i) whenever we need human[i]
    humanI.step();
    humanI.passEdges();
    humanI.display();
    
    //initializing the inner j=i+1. That way it wouldnt check same pairs again
    for (int j = i + 1; j < humans.size(); j++) {
      Human humanJ = humans.get(j); //Instead of using humans.get(j) whenever we need human[j]
      //Check if 2 humans interact
      if (i != j && humanI.intersect(humanJ)) {
        //Check if either of the humans are infected or sick
        //If one of them is sick or infected and the other human is healthy
        //Try to transmit the virus
        if ((humanI.status == INFECTED || humanI.status == SICK)  && humanJ.status == HEALTHY) {
          humanI.transmit(humanJ);
        } else if ((humanJ.status == INFECTED || humanJ.status == SICK) && humanI.status == HEALTHY) {
          humanJ.transmit(humanI);
          //If true try to infect the other human
        }
      }
    }
    
    //The virus tries to make a human sick
    //For now it works
    //In the future compare it with when a human got infected
    //So every human has a different "timer"
    if (frameCount % 500 == 0) {
      virus.getSick(humanI);
    }
    if (frameCount % 700 == 0) {
      humanI.recover();
    }
    
    virus.kill(humanI);
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
