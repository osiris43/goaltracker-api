class ProgressEventsController < ApplicationController
  def index
    events = ProgressEvent.all
    render :json => events.as_json, :status => 201
  end

  def new
  end

  def create
    activity = Activity.find_by_description(progress_params[:goal])
    goal = Goal.find_by_activity_id(activity.id)
    @event = ProgressEvent.new(goal: goal, number: progress_params[:progress])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render status: :created, json: @event.as_json }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def progress_params
      params.permit(:goal, :progress)
    end
end
