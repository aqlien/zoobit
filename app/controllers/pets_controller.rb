class PetsController < ApplicationController
  before_action :set_pet, except: [:new, :index, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def feed
    if @pet.fullness < 90
      @pet.last_feeding = Time.now
      @pet.happiness += 75
      @pet.fullness = 100
      @pet.save
      redirect_to pet_path(@pet), notice: "#{@pet.name} #{t("pets.feed_success")}"
    else
      redirect_to pet_path(@pet), notice: "#{@pet.name} #{t("pets.feed_failure")}"
    end
  end

  def play
    if @pet.energy > 25
      @last_interaction = Time.now
      @pet.happiness += 50
      @pet.energy -= 20
      @pet.save
      redirect_to pet_path(@pet), notice: "#{t("pets.play_success")} #{@pet.name}!"
    else
      redirect_to pet_path(@pet), notice: "#{@pet.name} #{t("pets.play_failure")}"
    end
  end

  def index
    @pets = Pet.all
  end

  def show
    @pet.update_happiness
  end

  def new
    @pet = Pet.new
  end

  def edit
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.breed = @pet.type.constantize::BREEDS.sample
    respond_to do |format|
      if @pet.save
        current_user.pets << @pet
        format.html { redirect_to pet_path(@pet), notice: "Congratulations on your new pet!" }
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
        format.html { redirect_to pet_path(@pet), notice: "Your pet's name was successfully updated." }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_path, notice: "You abandoned #{@pet.name}." }
      format.json { head :no_content }
    end
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
end
