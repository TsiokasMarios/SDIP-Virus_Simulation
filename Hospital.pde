public class Hospital{
  PImage hospital; //Holds the image of the hospital
  PVector location;
  final int SIZE = 128;
  
  Hospital(){
    hospital = loadImage("Hospital.png"); //Loads the image of the hospital
    location = new PVector(width/2,width/2-100);
  }
  
  void display(){
    //Display the image of the hospital with x and y location and size 64x64
    image(hospital,location.x,location.y,SIZE,SIZE);
  }
  
  void administerVaccine(Human human,Vaccine vaccine){
    human.immuneSystem += vaccine.strength;
  }
  
  void hospitalize(Human human,Vaccine vaccine){
    float distance = dist(this.location.x, this.location.y, human.location.x, human.location.y);

    if (distance < this.SIZE + human.size && human.headingToHospital){
      if (human.status == HEALTHY){
        administerVaccine(human,vaccine);
        human.leaveHospital();
      }
      else if (human.status == SICK){
        human.recoverStrength += 0.2;
      }
  
    } 
  }

}
