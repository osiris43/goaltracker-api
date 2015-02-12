class TimeframesController < ApplicationController
  before_action :set_timeframe, only: [:show, :edit, :update, :destroy]

  # GET /timeframes
  # GET /timeframes.json
  def index
    @timeframes = Timeframe.all
  end

  # GET /timeframes/1
  # GET /timeframes/1.json
  def show
  end

  # GET /timeframes/new
  def new
    @timeframe = Timeframe.new
  end

  # GET /timeframes/1/edit
  def edit
  end

  # POST /timeframes
  # POST /timeframes.json
  def create
    @timeframe = Timeframe.new(timeframe_params)

    respond_to do |format|
      if @timeframe.save
        format.html { redirect_to @timeframe, notice: 'Timeframe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @timeframe }
      else
        format.html { render action: 'new' }
        format.json { render json: @timeframe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timeframes/1
  # PATCH/PUT /timeframes/1.json
  def update
    respond_to do |format|
      if @timeframe.update(timeframe_params)
        format.html { redirect_to @timeframe, notice: 'Timeframe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timeframe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timeframes/1
  # DELETE /timeframes/1.json
  def destroy
    @timeframe.destroy
    respond_to do |format|
      format.html { redirect_to timeframes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeframe
      @timeframe = Timeframe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeframe_params
      params.require(:timeframe).permit(:description)
    end
end
