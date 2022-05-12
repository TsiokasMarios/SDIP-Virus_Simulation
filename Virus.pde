public class Virus{
  float infectionRate = 15;
  float lethality = 0.1;
  
  void randomInfect(Human[] humans){
    int rand = (int) random(humans.length);
    
    humans[rand].isInfected = true;
    println("success");
  }
  
  void infect(Human target) {
    //Try to inffect the other human
    if (target.resistance < virus.infectionRate){
      println(target.resistance);
      target.isInfected = true;
    }
  }
  
  
  
}
