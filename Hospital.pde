public class Hospital {
  PImage hospital; //Holds the image of the hospital
  PVector location;
  final int SIZE = 128;

  Hospital() {
    hospital = loadImage("Hospital.png"); //Loads the image of the hospital
    location = new PVector(width/2, height/2); //To display the hospital in the center of the screen
  }

  void display() {
    //Display the image of the hospital with x and y location and with the specified size
    imageMode(CENTER); //Center the image
    image(hospital, location.x, location.y, SIZE, SIZE);
  }

  void administerVaccine(Human human, Vaccine vaccine) {
    //Increase the vaccinated human's immune system strength
    human.immuneSystem += vaccine.strength;
  }

  void hospitalize(Human human, Vaccine vaccine) {
    float distance = dist(this.location.x, this.location.y, human.location.x, human.location.y);
    //Check if human is close to the hospital
    //Also check if they are heading to the hospital 
    //so humans randomly passing it dont get affected
    if (distance < this.SIZE + human.size && human.headingToHospital) {
      //If they are healthy get vaccinated
      if (human.status == HEALTHY) {
        administerVaccine(human, vaccine);
        human.vaccinated = true;
      }
      //If they are sick get treated
      else if (human.status == SICK) {
        human.recoverStrength += 0.2;
      }
    }
  }
}
