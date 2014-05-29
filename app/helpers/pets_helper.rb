module PetsHelper

  MALE_NAMES = ["Thor","Neo", "Hector", "Tony", "Peter", "Bruce", "Clark", "Samuel",
            "Lorenzo", "Reynaldo", "Raymondo", "Guillermo", "Theo", "Spike", "Joey",
            "Buddy", "Woody", "Clint", "Lord Whitby, Esquire"]
  FEMALE_NAMES = ["Ruby", "Sophie", "Pandora", "Pepper", "Natasha", "Elisabeth", "Monica",
                  "Betsy", "Betty", "Phoebe", "Diana", "Queen Elizabeth the Second"]
  NEUTRAL_NAMES = ["Spot", "Halo", "Scout", "AJ", "Killer", "Robin"]
  TYPES = ["Dog", "Cat", "Bird", "Rabbit"]
  GENDERS = ["Male", "Female"]

  def self.generate_story(name, type, gender, previous_owner = nil)
    stay = "#{name} has been here at the shelter for #{rand(1..25)} #{["days","weeks","months"].sample}. "
    past1 = "We found #{gender == "Female" ? "her":"him" } abandoned, living on the street. "
    past2 = "#{gender == "Female" ? "She":"He" } was dropped off by an elderly #{["gentleman", "lady"].sample} who said they were unable to care for #{name} anymore. "
    past3 = "#{gender == "Female" ? "Her":"His" } owner had to move, and they couldn't take #{name} with them. "
    past4 = "We were able to rescue #{gender == "Female" ? "her":"him" } from an abusive owner. "
    past5 = ""
    pros1 = "#{gender == "Female" ? "She":"He" } loves #{["other #{type.downcase.pluralize}.","to meet new people.","playing with kids.","the outdoors.","food - maybe a little too much!","getting new toys."].sample} "
    pros2 = "#{gender == "Female" ? "She":"He" } is #{["very","really","extremely","","very"].sample} #{["playful","friendly","talkative","energetic","intelligent"].sample}. "
    cons1 = "#{gender == "Female" ? "She":"He" } has had some #{["leg","eye","eating","movement","hearing","digestion","socialization"].sample} issues in the past, "
    cons2 = "#{gender == "Female" ? "She":"He" } doesn't always #{["get along with","appreciate","like","do well with"].sample} #{["everyone","teenagers","loud noises","the vet","sudden movements"].sample}, "
    leave1 = "but we hope that won't stop the two of you from being great friends!"
    leave2 = "but we're sure #{gender == "Female" ? "she":"he" } will be a great friend for you."
    story = stay + [past1,past2,past3,past4].sample + [pros1,pros2].sample + [cons1,cons2].sample + [leave1,leave2].sample
    return story
  end
end
