public class Human {
  PVector location;
  PVector velocity;
  int size;
  int age;
  float immuneSystem;
  float hygiene;
  int status;
  boolean vaccinated;
  
  Human() {
    size = 10;
    location = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    velocity = new PVector(random(-3, 3), random(-3, 3));
    status = HEALTHY;
    age = (int) random(1,85);
    hygiene = (int) random(0,100);
    
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

  void step() {
    location.add(velocity);
  }

  boolean intersect(Human other) {
    //Calculates the distance between 2 humans to see if they intersect, in other words if they interract with eachother
    float distance;
    boolean isIntersecting;

    distance = dist(this.location.x, this.location.y, other.location.x, other.location.y);

    if (distance < this.size + other.size) {
      isIntersecting = true;
    } else {
      isIntersecting = false;
    }
    return isIntersecting;
  }

  void transmit(Human target) {
    //Try to inffect the other human
    //The formula calculation happens on the infect(target) method
    if (target != this)
      virus.infect(target);
  }
  
  void recover(){
    //Will try to recover depending on a formula
  }

  //Change their color depending on their status
  void display() {
    if (status == HEALTHY) {
      fill(green);
    } 
    else if (status == INFECTED){
      fill(yellow);
    }
    else if (status == SICK){
      fill(red);
    }
    else if (status == RECOVERED){
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
