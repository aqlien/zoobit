class RabbitsController < ApplicationController
  before_action :set_rabbit, only: [:show, :edit, :update, :destroy]

  # GET /rabbits
  # GET /rabbits.json
  def index
    @rabbits = Rabbit.all
  end

  # GET /rabbits/1
  # GET /rabbits/1.json
  def show
  end

  # GET /rabbits/new
  def new
    @rabbit = Rabbit.new
  end

  # GET /rabbits/1/edit
  def edit
  end

  # POST /rabbits
  # POST /rabbits.json
  def create
    @rabbit = Rabbit.new(rabbit_params)

    respond_to do |format|
      if @rabbit.save
        format.html { redirect_to @rabbit, notice: 'Rabbit was successfully created.' }
        format.json { render :show, status: :created, location: @rabbit }
      else
        format.html { render :new }
        format.json { render json: @rabbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rabbits/1
  # PATCH/PUT /rabbits/1.json
  def update
    respond_to do |format|
      if @rabbit.update(rabbit_params)
        format.html { redirect_to @rabbit, notice: 'Rabbit was successfully updated.' }
        format.json { render :show, status: :ok, location: @rabbit }
      else
        format.html { render :edit }
        format.json { render json: @rabbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rabbits/1
  # DELETE /rabbits/1.json
  def destroy
    @rabbit.destroy
    respond_to do |format|
      format.html { redirect_to rabbits_url, notice: 'Rabbit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rabbit
      @rabbit = Rabbit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rabbit_params
      params[:rabbit]
    end
end
