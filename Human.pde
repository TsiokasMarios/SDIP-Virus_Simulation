public class Human {
  PVector location;
  PVector velocity;
  int size;
  int age;
  float resistance;
  float hygiene;
  boolean isInfected;
  boolean vaccinated;

  Human() {
    size = 10;
    location = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    velocity = new PVector(random(-3, 3), random(-3, 3));
    isInfected = false;
    age = (int) random(1,85);
    resistance =  random(1,2) * age;
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
    //Try to inffect the other human depending on a forumal
    if (target != this)
      virus.infect(target);
  }
  
  void recover(){
    //Will try to recover depending on a formula
  }


  void display() {
    if (isInfected) {
      fill(red);
    } else {
      fill(green);
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
