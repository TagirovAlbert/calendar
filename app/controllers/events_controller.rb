class EventsController < ApplicationController
  require 'recurrence'
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /events
  # GET /events.json
  def index

    @events = Event.is_public
    @events_by_date_all=@events.group_by { |i| i.date_rem.to_date }
    @date= params[:date_rem] ? Date.parse(params[:date_rem]) : Date.today

    end
  def my_index
    @my_events=current_user.events.all
    @my_list_events=Array.new
    @my_events.each do |my_event|
      event_date=my_event.date_rem.to_date

      if my_event.everyday
        days = Recurrence.new(:every => :day, :starts => event_date,:through => event_date.next_month)
        days.each do |my_dey|
          event_curr=Event.find_or_initialize_by(id: my_event[:id])
          event_curr.date_rem=my_dey.to_s
          @my_list_events.push(event_curr)
        end

      end

      if my_event.everymonth
        weeks=Recurrence.weekly(:on => event_date.mday, :through=>event_date.next_year)
        weeks.each do |my_week|
          event_curr=Event.find_or_initialize_by(id: my_event[:id])
          event_curr.date_rem=my_week.to_s
          @my_list_events.push(event_curr)



        end
      end



    end
    @events_by_date_my= @my_list_events.group_by {|j| j.date_rem.to_date}
    @date= params[:date_rem] ? Date.parse(params[:date_rem]) : Date.today

  end







  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user=current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :date_rem, :public, :everyday, :everyweek,:everymonth, :everyyear)
    end
end