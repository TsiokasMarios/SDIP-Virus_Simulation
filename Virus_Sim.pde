import g4p_controls.*;
//To work you need to download the g4p library
//Tools -> libraries -> search for g4p then install

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

int healthyCounter; //How many humans are healthy
int infectedCounter; //How many humans have been infected 
int sickCounter; //How many humans are sick
int recoveredCounter; //How many humans have recovered
int deathCounter; // How many humans have died

//Get age targets from slider
int min;
int max;

ArrayList<Human> humans;
Hospital hospital;
Virus virus;
Vaccine vaccine;


//Initialize the humans, virus and counters
public void init() {
   
  hospital = new Hospital();
  //Initialize the humans and put them in a list
  humans = new ArrayList();
  
  for (int i = 0; i < Number_of_humans.getValueI(); i++) {
    humans.add(new Human(human_recovery_strength.getValueI()));
  }
  
  //Create the virus with the targeted ages
  virus = new Virus(min,max);
  //Create the vaccine
  vaccine = new Vaccine();
  
  //At the start everyone is healthy
  healthyCounter = humans.size();
  infectedCounter = 0;
  sickCounter = 0;
  recoveredCounter = 0;
  deathCounter = 0;
}

void setup() {
  surface.setResizable(true);
  background(0);
  size(800, 700, JAVA2D);
  createGUI();
  frameRate(60);
  init();
}

void draw() {
  background(0);
  hospital.display();
  
  //Setting i < humans.size() - 1, 
  //because once you check the final human you dont need to compare them against anyone
  for (int i = 0; i < humans.size(); i++) { 
    Human humanI = humans.get(i); //Instead of using humans.get(i) whenever we need human[i]
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
        
        //If they are interesecting try to breed them
        humanI.breed(humanJ);
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
    if (frameCount % 365 == 0){
       //Every 365 frames make them older
       humanI.updateAge(); 
    }
    
    virus.kill(humanI);
    humanI.goToHospital(hospital.location);
    humanI.update();

    hospital.hospitalize(humanI,vaccine);
  }
  fill(200);
  textSize(20);
  text("Healthy: "+healthyCounter, 20, 20);
  text("Infected: "+infectedCounter, 20, 40);
  text("Sick: "+sickCounter, 20, 60);
  text("Recovered: "+recoveredCounter, 20, 80);
  text("Death Toll: "+deathCounter, 20, 100);
  text("Frame: " + frameCount, 20, 120);
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
