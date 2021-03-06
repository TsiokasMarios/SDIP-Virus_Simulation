public class Virus {
  //How infectious am I
  float infectionRate = infection_rate_slide.getValueF();
  //How lethal am I
  float lethality = virus_lethality.getValueF();
  //How strong am I? In other words, how likely am I to make a human sick
  float strength = virus_strength.getValueF();
  //Who will you be more effective against
  Range ageTarget; 


  Virus (int lowerRange, int higherRange) {
    ageTarget = new Range(lowerRange, higherRange);
    println("virus infection rate = " + infectionRate);
    println("virus lethality = " + lethality);
    println("virus strength = " + strength);
  }

  void randomInfect() {
    //Infects a random human
    int rand = (int) random(humans.size());
    humans.get(rand).status = INFECTED; //Random human's status is set to be infected
    infectedCounter++;
    healthyCounter--;
    println("Random infection successful");
  }

  void infect(Human target) {
    //Try to inffect the other human
    if (target.hygiene < virus.infectionRate) {
      target.status = INFECTED; //Updated status of the human
      infectedCounter++; //Increase infected counter
      healthyCounter--; //Decrease healthy counter
    }
  }

  //Takes a human as an argument
  void getSick(Human target) {
    if (target.status != RECOVERED) { //Humans who have recovered from the virus are immune to it
      //If human is infected 
      //and their immune system strength is less than the strength of the virus
      //And virus is targeting their age be more effective
      if ((target.status == INFECTED) && (ageTarget.contains(target.age) )) {
        if (target.immuneSystem < strength + 0.2) {
          //Change their status to sick
          target.status = SICK;
          sickCounter++;
          //Decrease infected counter
          infectedCounter--;
        }
      } 
      //Otherwise try to make them sick without any boost
      else if (target.status == INFECTED && target.immuneSystem < strength ) {
        target.status = SICK;
        sickCounter++;
        infectedCounter--;
      }
    }
  }

  void kill(Human target) {
    if (target.status == SICK) {     //If they target is sick
      if (random(11) < lethality) { //If random rolled number is less than the lethality of the virus
        humans.remove(target); //Delete the human from the list, in other words kill them
        deathCounter++; // Increase the death counter
        sickCounter--; //Decrease the sick counter
      }
    }
  }
}
