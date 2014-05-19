class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @search = Player.search(params[:q])
    @players = @search.result.order("rank ASC").includes(:alliance).paginate(:page => params[:page], :per_page => 30)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    render layout: 'no_con'
  end

  def towns
    @players = Player.find(params[:id])
  end

  def show
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:grepo_id, :name, :alliance_id, :points, :rank, :town_count, :all_rank,
                                     :all_points, :def_rank, :def_points, :att_rank, :att_points)
    end
end
