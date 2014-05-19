class IslandsController < ApplicationController
  before_action :set_island, only: [:show, :edit, :update, :destroy]

  def index
    @search = Island.search(params[:q])
    @islands = @search.result.order("grepo_id ASC").paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def new
    @island = Island.new
  end

  def edit
  end

  def create
    @island = Island.new(island_params)

    respond_to do |format|
      if @island.save
        format.html { redirect_to @island, notice: 'Island was successfully created.' }
        format.json { render action: 'show', status: :created, location: @island }
      else
        format.html { render action: 'new' }
        format.json { render json: @island.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @island.update(island_params)
        format.html { redirect_to @island, notice: 'Island was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @island.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @island.destroy
    respond_to do |format|
      format.html { redirect_to islands_url }
      format.json { head :no_content }
    end
  end

  private
    def set_island
      @island = Island.find(params[:id])
    end

    def island_params
      params.require(:island).permit(:grepo_id, :island_x, :island_y, :type_number, :available_towns, :ocean, :coordinates)
    end
end
