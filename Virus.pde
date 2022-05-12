public class Virus{
  float infectionRate = 0.3;
  float lethality = 0.1;
  
  void randomInfect(Human[] humans){
    int rand = (int) random(humans.length);
    
    humans[rand].isInfected = true;
    println("success");
  }
  
  
  
}
