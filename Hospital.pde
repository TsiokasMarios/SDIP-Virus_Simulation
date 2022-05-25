public class Hospital{
  PImage hospital; //Holds the image of the hospital
  PVector location;
  
  Hospital(){
    hospital = loadImage("Hospital.png"); //Loads the image of the hospital
    location = new PVector(width/2,width/2-100);
  }
  
  void display(){
    //Display the image of the hospital with x and y location and size 64x64
    image(hospital,location.x,location.y,128,128);
  }

}
