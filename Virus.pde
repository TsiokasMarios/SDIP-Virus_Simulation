public class Virus{
  float infectionRate = 20;
  float lethality = 0.1;
  int[] ageTarget;
  
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
  
  void getSick(Human target){
    //Takes a human as an argument
    //Depending on a formula it will try to make them sick
  }
  
  void goToHospital(Hospital hospital){
    //Will have a chance to go to the hospital if sick
    //Or to get vaccinated
  }
  
  
  
}
