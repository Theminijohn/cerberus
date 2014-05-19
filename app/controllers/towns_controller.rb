class TownsController < ApplicationController
  before_action :set_town, only: [:show, :edit, :update, :destroy]

  def index
    @towns = Town.all.order("points DESC").paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @towns = Town.includes(:conquers).find(params[:id])
  end

  def new
    @town = Town.new
  end

  def edit
  end

  def create
    @town = Town.new(town_params)

    respond_to do |format|
      if @town.save
        format.html { redirect_to @town, notice: 'Town was successfully created.' }
        format.json { render action: 'show', status: :created, location: @town }
      else
        format.html { render action: 'new' }
        format.json { render json: @town.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @town.update(town_params)
        format.html { redirect_to @town, notice: 'Town was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @town.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @town.destroy
    respond_to do |format|
      format.html { redirect_to towns_url }
      format.json { head :no_content }
    end
  end

  private
    def set_town
      @town = Town.find(params[:id])
    end

    def town_params
      params.require(:town).permit(:grepo_id, :player_id, :name, :island_x, :island_y, :slot, :points, :ocean, :coordinates)
    end
end
