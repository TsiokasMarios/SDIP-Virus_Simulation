final int green = color(57, 227, 64);
final int red = color(237, 5, 9);


Human[] humans;
Virus virus;

void setup() {
  background(0);
  size(800, 700);
  frameRate(60);
  humans = new Human[100];
  for (int i = 0; i < humans.length; i++) {
    humans[i] = new Human();
  }
  virus = new Virus();
}

void draw() {
  background(0);
  for (int i = 0; i < humans.length; i++) {
    humans[i].step();
    humans[i].passEdges();
    humans[i].display();

    for (int j = 0; j < humans.length; j++) {
      if (i != j && humans[i].intersect(humans[j])) {
        //Check if either of the humans are infected
        if (humans[i].isInfected){
          humans[i].infect(humans[j]);
        }
        else if (humans[j].isInfected){
          if (humans[j].isInfected);
        //If true try to infect the other human
        }
      }
    }
  }
}

void mouseClicked() {
  virus.randomInfect(humans);
}
