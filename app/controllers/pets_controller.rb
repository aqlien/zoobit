class PetsController < ApplicationController
  before_action :set_pet, except: [:new, :index, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def feed
    @pet.last_feeding = Time.now
    if @pet.fullness < 90
      @pet.happiness += 75
      @pet.fullness = 100
    end
    save_and_show
  end

  def play
    @last_interaction = Time.now
    if @pet.energy > 25
      @pet.happiness += 50
      @pet.energy -= 20
    end
    save_and_show
  end

  # GET /pets
  # GET /pets.json
  def index
    @pets = Pet.all
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    update_happiness
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)
    @pet.breed = @pet.type.constantize::BREEDS.sample
    initialize_pet
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

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
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

  # DELETE /pets/1
  # DELETE /pets/1.json
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
    params.require(:pet).permit(:name, :type, :gender)
  end

  def save_and_show
    @pet.save
    redirect_to pet_path(@pet)
  end

  def update_happiness
    current_time = Time.now

    decrease_fullness(current_time)
    decrease_energy(current_time)
    @pet.happiness = (@pet.fullness + @pet.energy*1.5)/2

    # decrease = @pet.happiness - (current_time - @pet.last_interaction) / 60 / 7
    # @pet.update(happiness: decrease)

    reset_below_zero
    @pet.save
  end

  def decrease_fullness(current_time)
    # Time in seconds since last feeding converted to minutes, every 8 minutes
    @pet.fullness -= (current_time - @pet.last_feeding) / 60 / 8
  end

  def decrease_energy(current_time)
    if @pet.energy < 10
      @pet.last_rest = Time.now
      @pet.energy = 100
    end
    @pet.energy -= (current_time - @pet.last_rest) / 60 / 10
  end

  def reset_below_zero
    @pet.happiness = 0 if @pet.happiness < 0
    @pet.fullness = 0 if @pet.fullness < 0
    @pet.energy = 0 if @pet.energy < 0
  end

  def initialize_pet
    @pet.happiness = 100
    @pet.energy = 100
    @pet.fullness = 100
    @pet.last_interaction = Time.now
    @pet.last_feeding = Time.now
    @pet.last_rest = Time.now
  end
end
