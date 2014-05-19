class AlliancesController < ApplicationController
  before_action :set_alliance, only: [:show, :edit, :update, :destroy]

  def index
    @alliances = Alliance.all.order("rank ASC").paginate(:page => params[:page], :per_page => 25)
  end

  def towns
    @alliance = Alliance.find(params[:id])
  end

  def show
    @alliance_towns = Town.joins(:player).where('players.alliance_id = ?', params[:id]).order('points desc').paginate(:page => params[:page], :per_page => 25)
  end

  def new
    @alliance = Alliance.new
  end

  def edit
  end

  def create
    @alliance = Alliance.new(alliance_params)

    respond_to do |format|
      if @alliance.save
        format.html { redirect_to @alliance, notice: 'Alliance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alliance }
      else
        format.html { render 'new' }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @alliance.update(alliance_params)
        format.html { redirect_to @alliance, notice: 'Alliance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @alliance.destroy
    respond_to do |format|
      format.html { redirect_to alliances_url }
      format.json { head :no_content }
    end
  end

  private
    def set_alliance
      @alliance = Alliance.find(params[:id])
    end

    def alliance_params
      params.require(:alliance).permit(:grepo_id, :name, :points, :town_count, :member_count, :rank,
                                       :all_rank, :all_points, :def_rank, :def_points, :att_rank,
                                       :att_points)
    end
end
