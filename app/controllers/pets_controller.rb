class PetsController < ApplicationController
  before_action :set_pet, except: [:new, :index, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def feed
    if @pet.pet_hunger.decrease
      if @pet.happiness >= 80
        owner = User.find(@pet.user_id)
        owner.points += 25
        owner.save
      end
      current_user.earn_points
      redirect_to pet_path(@pet), notice: t("pets.feed_success", name: @pet.name)
    else
      redirect_to pet_path(@pet), notice: t("pets.feed_failure", name: @pet.name)
    end
  end

  def play
    if @pet.pet_boredom.decrease
      if @pet.happiness >= 80
        owner = User.find(@pet.user_id)
        owner.points += 25
        owner.save
      end
      current_user.earn_points
      redirect_to pet_path(@pet), notice: t("pets.play_success", name: @pet.name)
    else
      redirect_to pet_path(@pet), notice: t("pets.play_failure", name: @pet.name)
    end
  end

  def show
    @pet.update_happiness(Time.now)
    @owner = User.find(@pet.user_id)
    event
  end

  def new
    @pets = User.find(1).pets
    if @pets.count < 18
      until @pets.count == 18
        @pet = generate_pet
        give_to_shelter
      end
    end
    if params[:type]
      @pets = @pets.where(:type => params[:type])
      @pets = @pets.page(params[:page]).per_page(5)
    else
      @featured = @pets.sample
      @pets = @pets.page(params[:page]).per_page(5)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def adopt
    redirect_to user_path(current_user), notice: t("pets.too_many") and return if current_user.pets.count >= current_user.pet_slots
    respond_to do |format|
      if @pet.save
        normalize_pet_stats
        current_user.pets << @pet
        format.html { redirect_to pet_path(@pet), notice: t("pets.new") }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to user_path(current_user) }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pet.previous_owner = current_user.username
    current_user.pets = current_user.pets.to_a.reject! { |p| p.id == @pet.id }
    current_user.points = current_user.points/2
    current_user.save
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You abandoned #{@pet.name}." }
      format.json { head :no_content }
    end
    give_to_shelter
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_pet
    @pet = params[:id].nil? ? Pet.find(params[:pet_id]) : Pet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pet_params
    params.require(:pet).permit(:name, :type, :gender, :breed)
  end

  def give_to_shelter
    shelter = User.find(1)
    @pet.name = "My Owner Was a Bad Person" if Obscenity.profane?(@pet.name)
    @pet.name = PetsHelper::NEUTRAL_NAMES.sample if ApplicationHelper.obscene_substring?(@pet.name)
    shelter.pets.first.destroy if shelter.pets.count >= 20
    shelter.pets << @pet
  end

  def generate_pet
    @pet = Pet.new
    @pet.gender = PetsHelper::GENDERS.sample
    @pet.name = @pet.gender == "Female" ? (PetsHelper::FEMALE_NAMES + PetsHelper::NEUTRAL_NAMES).sample : (PetsHelper::MALE_NAMES + PetsHelper::NEUTRAL_NAMES).sample
    @pet.type = PetsHelper::TYPES.sample
    @pet.breed = @pet.type.constantize::BREEDS.sample
    @pet.story = PetsHelper.generate_story(@pet.name, @pet.type, @pet.gender)
    @pet
  end

  def normalize_pet_stats
    @pet.pet_hunger.value = 20
    @pet.pet_tiredness.value = 0
    @pet.pet_boredom.value = 75
    @pet.pet_hunger.save
    @pet.pet_tiredness.save
    @pet.pet_boredom.save
  end

  def event
    unless @pet.user_id == 1 || flash[:notice]
      if @pet.pet_boredom.value > 90
        flash[:alert] = t("pets.bored_#{1+rand(2)}", name: @pet.name, gender: @pet.gender == 'Male' ? 'he' : 'she', owner: current_user == @pet.user ? "your" : @pet.user.username )
      elsif @pet.pet_hunger.value > 90
        flash[:alert] = t("pets.hungry_#{1+rand(3)}", name: @pet.name, gender: @pet.gender == 'Male' ? 'he' : 'she', owner: current_user == @pet.user ? "your" : @pet.user.username )
      elsif @pet.happiness > 90
        flash[:notice] = t("pets.happy_#{1+rand(2)}", name: @pet.name, gender: @pet.gender == 'Male' ? 'he' : 'she', owner: current_user == @pet.user ? "your" : @pet.user.username )
      end
    end
  end

end
