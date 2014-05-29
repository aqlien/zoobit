class PetsController < ApplicationController
  before_action :set_pet, except: [:new, :index, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def feed
    if @pet.pet_hunger.decrease
      redirect_to pet_path(@pet), notice: t("pets.feed_success", name: @pet.name)
    else
      redirect_to pet_path(@pet), notice: t("pets.feed_failure", name: @pet.name)
    end
  end

  def play
    if @pet.pet_boredom.decrease
      redirect_to pet_path(@pet), notice: t("pets.play_success", name: @pet.name)
    else
      redirect_to pet_path(@pet), notice: t("pets.play_failure", name: @pet.name)
    end
  end

  def index
    @pets = Pet.all
  end

  def show
    @pet.update_happiness(Time.now)
  end

  def new
    @pet = Pet.new
  end

  def edit
  end

  def create
    redirect_to pets_path, notice: t("pets.too_many") and return if current_user.pets.count >= 10
    @pet = Pet.new(pet_params)
    respond_to do |format|
      if @pet.save
        current_user.pets << @pet
        format.html { redirect_to pet_path(@pet), notice: t("pets.new") }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def adopt
    respond_to do |format|
      if @pet.save
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
        format.html { redirect_to pet_path(@pet), notice: "Your pet's name was successfully updated." }
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
    shelter = User.find(2)
    shelter.pets << @pet
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
