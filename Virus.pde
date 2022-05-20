public class Virus{
  float infectionRate = 20;
  float lethality = 0.1;
  float strength = 0.3;
  Range ageTarget; 
  
  
  Virus (int lowerRange, int higherRange){
    ageTarget = new Range(lowerRange,higherRange);
  }
  
  void randomInfect(Human[] humans){
    int rand = (int) random(humans.length);
    
    humans[rand].status = INFECTED;
    println("success");
  }
  
  void infect(Human target) {
    //Try to inffect the other human
    if (target.hygiene < virus.infectionRate){
      println(target.hygiene);
      target.status = INFECTED;
    }
  }
  
  //Takes a human as an argument
  void getSick(Human target){
    if (target.status != RECOVERED){ //Humans who have recovered from the virus are immune to it
      //If human is infected and their immune system strength
      
      if ((target.status == INFECTED) && (ageTarget.contains(target.age) )){
        if (target.immuneSystem < strength + 0.2)
          target.status = SICK;
      }
      
      else if (target.status == INFECTED && target.immuneSystem < strength ){
        target.status = SICK;
      }
      
      
    }
    
    
  }
  
  void goToHospital(Hospital hospital){
    //Will have a chance to go to the hospital if sick
    //Or to get vaccinated
  }
  
  
  
}
