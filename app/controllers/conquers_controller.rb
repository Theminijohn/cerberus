class ConquersController < ApplicationController
  before_action :set_conquer, only: [:show, :edit, :update, :destroy]

  # GET /conquers
  # GET /conquers.json
  def index
    @conquers = Conquer.all.order("time desc").paginate(:page => params[:page], :per_page => 20)
  end

  # GET /conquers/1
  # GET /conquers/1.json
  def show
  end

  # GET /conquers/new
  def new
    @conquer = Conquer.new
  end

  # GET /conquers/1/edit
  def edit
  end

  # POST /conquers
  # POST /conquers.json
  def create
    @conquer = Conquer.new(conquer_params)

    respond_to do |format|
      if @conquer.save
        format.html { redirect_to @conquer, notice: 'Conquer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @conquer }
      else
        format.html { render action: 'new' }
        format.json { render json: @conquer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conquers/1
  # PATCH/PUT /conquers/1.json
  def update
    respond_to do |format|
      if @conquer.update(conquer_params)
        format.html { redirect_to @conquer, notice: 'Conquer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @conquer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conquers/1
  # DELETE /conquers/1.json
  def destroy
    @conquer.destroy
    respond_to do |format|
      format.html { redirect_to conquers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conquer
      @conquer = Conquer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conquer_params
      params.require(:conquer).permit(:town_id, :time, :new_player_id, :old_player_id, :new_ally_id, :old_ally_id, :town_points)
    end
end
