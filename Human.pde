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
  float heading;

  boolean vaccinated;
  boolean headingToHospital;


  Human(float RecStrength) {
    maxSpeed = 3; 
    size = 10;
    location = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    velocity = new PVector(random(-3, 3), random(-3, 3));
    acceleration = new PVector(0, 0);
    status = HEALTHY;
    age = (int) random(1, 85);
    println(age);
    hygiene = (int) random(0, 100);
    headingToHospital = false;
    recoverStrength = RecStrength;
    heading = velocity.heading();

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

  void updateAge() {
    //This method will update a human's age
    //and their immune system strength respectively
    //Limit the age to 100
    if (age < 100) {
      age++;
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
  }

  Human(float RecStrength, float ImuneSystemStrength) {
    maxSpeed = 3; 
    size = 10;
    location = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    velocity = new PVector(random(-3, 3), random(-3, 3));
    acceleration = new PVector(0, 0);
    status = HEALTHY;
    age = (int) random(1, 85);
    hygiene = (int) random(0, 100);
    headingToHospital = false;
    recoverStrength = RecStrength;
    immuneSystem = ImuneSystemStrength;
  }

  boolean intersect(Human other) {
    //Find the distance between the two humans
    float distance = dist(this.location.x, this.location.y, other.location.x, other.location.y);

    //If distance smaller than their size then they are intersecting
    if (distance < this.size + other.size) {
      return true;
    } else {
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
      //If random number is smaller than their recovery strength
      if (random(11) < recoverStrength) { 
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
      //println("Heading to hospital to get recovered");
    }
    //Otherwise go there to get vaccinated
    else if (status == HEALTHY &&random(11) < 0.003  && !headingToHospital &&  !vaccinated) {
      seek(hospital); //Go towards the hospital
      headingToHospital = true;
      //println("Heading to hospital to get vaccinated");
    }
  }

  void breed(Human parent2) {
    //If the population is not full
    if (humans.size() < Number_of_humans.getValueI()) {
      //Have a random chance to create a child human
      //With the average imune system strength of the parents
      //And a chance to be better or worse
      float avgImuneSystem = (this.immuneSystem + parent2.immuneSystem) / 2;

      //If either of the parents have recovered from the virus before
      //The child will have a chance to be imune as well
      if (this.status == RECOVERED || parent2.status == RECOVERED) {
        avgImuneSystem = 1;
      } else if (random(1) < 0.5) { //Chance for child to have a stronger immune system
        avgImuneSystem += 0.2;
      } else { //Chance for child to have a weaker immune system
        avgImuneSystem -= 0.2;
      }
      humans.add(new Human(human_recovery_strength.getValueI(), avgImuneSystem));
      healthyCounter++;
    }
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void seek(PVector target) {
    //calculate the desired velocity
    //target - location
    PVector desiredV = PVector.sub(target, this.location);
    //limit this to maxspeeed
    desiredV.setMag(this.maxSpeed);
    //calculate the sterring force
    //as desired velocity - velocity
    PVector steeringForce = PVector.sub(desiredV, this.velocity);
    //apply the force
    applyForce(steeringForce);
  }

  void update() {
    //Updates their velocity, location and acceleration
    this.velocity.add(acceleration);
    this.velocity.limit(this.maxSpeed);
    this.location.add(this.velocity);
    heading = velocity.heading();
    this.acceleration.set(0, 0);
  }

  //Change their color depending on their status
  void display() {
    pushMatrix();
    translate(location.x,location.y);
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

    if (age <= 10)
      ellipse(location.x, location.y, size, size);
    else if (age > 10 && age <= 20)
      ellipse(location.x, location.y, size*2, size*2);
    else if (age > 20 && age <= 40)
      rect(location.x, location.y, size, size);
    else if (age > 40 && age <= 60)
      rect(location.x, location.y, size*2, size);
    else if (age > 60 && age <= 80){
      rotate(heading);
      triangle(-size ,-size/2, size, 0, -size, size/2);
    }
    else if (age > 80){
      rotate(heading);
      triangle(-size*2 ,(-size/2)*2, size*2, 0, -size*2, (size/2)*2);
    }
    
    popMatrix();
  }

  void passEdges() {
    if (location.x < 0)      location.x = width;
    if (location.x > width)  location.x = 0;
    if (location.y < 0)      location.y = height;
    if (location.y > height) location.y = 0;
  }
}
