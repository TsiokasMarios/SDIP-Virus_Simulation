public class Human {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  int size;
  int age;
  int status;
  int maxSpeed;
  
  float immuneSystem;
  float hygiene;
  float recoverStrength;

  boolean vaccinated;
  boolean headingToHospital;


  Human() {
    maxSpeed = 3; 
    size = 10;
    location = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    velocity = new PVector(random(-3, 3), random(-3, 3));
    acceleration = new PVector(0, 0);
    status = HEALTHY;
    age = (int) random(1, 85);
    hygiene = (int) random(0, 100);
    headingToHospital = false;
    recoverStrength = 5;

    //Immune system strength depends on a human's age
    //Younger ages and bigger ages have a weak immune system
    //Teens and adults have average immune systems
    if (age > 0 && age <= 10)
      immuneSystem = 0.2;
    else if (age > 10 && age <= 20)
      immuneSystem = 0.4;
    else if (age > 20 && age <= 40)
      immuneSystem = 0.5;
    else if (age > 40 && age <= 60)
      immuneSystem = 0.4;
    else if (age > 60 && age <= 80)
      immuneSystem = 0.2;
    else if (age > 80)
      immuneSystem = 0.1;
  }

  boolean intersect(Human other) {
    //Find the distance between the two humans
    float distance = dist(this.location.x, this.location.y, other.location.x, other.location.y);
    
    //If distance smaller than their size then they are intersecting
    if (distance < this.size + other.size) {
      return true;
    } 
    else {
      return false;
    }
  }

  void transmit(Human target) {
    //Try to inffect the other human
    if (target != this)
      virus.infect(target);
  }

  void recover() {
    if (status == SICK) { //If human is sick
      if (random(11) < recoverStrength) { //And a random rolled number is smaller than their recovery strength
        this.status = RECOVERED; //Update their status
        recoveredCounter++; //Increase recovered counter
        sickCounter--; //Decrease sick counter
      }
    }
  }

  void goToHospital(PVector hospital) {
    //If they are sick and aren't heading to the hospital go there to get treated
    if (status == SICK && random(11) < 0.02 && !headingToHospital) {
      seek(hospital); //Go towards the hospital
      headingToHospital = true;
      println("Heading to hospital to get recovered");
    }
    //Otherwise go there to get vaccinated
    else if (status == HEALTHY &&random(11) < 0.003  && !headingToHospital &&  !vaccinated) {
      seek(hospital); //Go towards the hospital
      headingToHospital = true;
      println("Heading to hospital to get vaccinated");
    }
  }
  
  void applyForce(PVector f){
    acceleration.add(f);
  }
  
  void seek(PVector target){
    //calculate the desired velocity
    //target - location
    PVector desiredV = PVector.sub(target,this.location);
    //limit this to maxspeeed
    desiredV.setMag(this.maxSpeed);
    //calculate the sterring force
    //as desired velocity - velocity
    PVector steeringForce = PVector.sub(desiredV,this.velocity);
    //apply the force
    applyForce(steeringForce);
  }
  
  void update() {
    //Updates their velocity, location and acceleration
    this.velocity.add(acceleration);
    this.velocity.limit(this.maxSpeed);
    this.location.add(this.velocity);
    this.acceleration.set(0, 0);
  }



  //Change their color depending on their status
  void display() {
    if (status == HEALTHY) {
      fill(green);
    } else if (status == INFECTED) {
      fill(yellow);
    } else if (status == SICK) {
      fill(red);
    } else if (status == RECOVERED) {
      fill(blue);
    }
    noStroke();
    ellipse(location.x, location.y, size, size);
  }

  void passEdges() {
    if (location.x < 0)      location.x = width;
    if (location.x > width)  location.x = 0;
    if (location.y < 0)      location.y = height;
    if (location.y > height) location.y = 0;
  }
}
