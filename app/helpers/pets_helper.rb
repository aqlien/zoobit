module PetsHelper


  def generate_story(pet)
    line1 = "#{pet.name} has been here at the shelter for #{rand(1..25)} #{["days","weeks","months"].sample}. "
    line2a = "We found #{pet.gender == "Female" ? "her":"him" } abandoned, living on the street. "
    line2b = "#{pet.gender == "Female" ? "She":"He" } was dropped off by an elderly #{["gentleman", "lady"].sample} who said they were unable to care for #{pet.name} anymore. "
    line2c = "#{pet.gender == "Female" ? "Her":"His" } owner had to move, and they couldn't take #{pet.name} with them. "
    line2d = "We were able to rescue #{pet.gender == "Female" ? "her":"him" } from an abusive owner. "
    line2e = ""
    line3a = "#{pet.gender == "Female" ? "She":"He" } loves #{["other #{pet.type.downcase.pluralize}.","to meet new people.","playing with kids.","the outdoors.","food - maybe a little too much!","getting new toys."].sample} "
    line3b = "#{pet.gender == "Female" ? "She":"He" } is #{["very","really","extremely","","very"].sample} #{["playful","friendly","talkative","energetic","smart"].sample}."
    line4a = "#{pet.gender == "Female" ? "She":"He" } has had some #{["leg","eye","eating","movement","hearing","digestion","socialization"].sample} issues in the past, "
    line4b = "#{pet.gender == "Female" ? "She":"He" } doesn't always get along with #{["everyone","teenagers","loud noises","veterinarians"].sample}, "
    line5 = "but we hope that won't stop the two of you from being great friends!"
    story = string = line1 + [line2a,line2b,line2c,line2d].sample + [line3a,line3b].sample + [line4a,line4b].sample + line5
  end
end
