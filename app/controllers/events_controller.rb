class EventsController < ApplicationController
  require 'recurrence'
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /events
  # GET /events.json
  def index

    @events = Event.is_public
    @events_by_date_all=@events.group_by { |i| i.date_rem }
    @date= params[:date_rem] ? params[:date_rem] : Date.today

    end
  def my_index
    @my_events=current_user.events.all
    @my_list_events=Array.new
    @my_events.each do |my_event|
      event_date=my_event.date_rem

      if my_event.everyday
        days = Recurrence.daily(:through => event_date.next_month)
        event_iter(days,@my_list_events,my_event)

        end

      if my_event.everyweek
        weeks=Recurrence.weekly(:on => event_date.wday,:start=>event_date,  :through=>event_date.next_year)
        event_iter(weeks,@my_list_events,my_event)
      end

      if my_event.everymonth
        months=Recurrence.monthly(:on => event_date.mday, :start=>event_date,:through=>event_date.next_year(2))
        event_iter(months,@my_list_events,my_event)

      end

      if my_event.everyyear
        years=Recurrence.yearly(:on=> [event_date.mon,event_date.mday])
        event_iter(years,@my_list_events,my_event)
      end




    end
    @my_list_events.uniq! { |uniq_event| [uniq_event.id, uniq_event.date_rem] }
    @events_by_date_my= @my_list_events.group_by {|j| j.date_rem}
    @date= (params[:date_rem] ? params[:date_rem] : Date.today).to_date

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
    @event = Event.new(event_params )
    puts @event
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
        format.html { redirect_to @event, notice: 'Событие было удачно обновлено.' }
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
      format.html { redirect_to events_url, notice: 'Событие было удачно удалено.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

  def event_iter(reccure,list,event)
    reccure.each do |my_reccure|
      event_curr=Event.find_or_initialize_by(id: event[:id],date_rem: event[:date_rem])
      event_curr.date_rem=my_reccure

      list<<event_curr




    end
end
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      po=params.require(:event).permit(:name, :description, :public, :everyday, :everyweek,:everymonth, :everyyear)
      po[:date_rem]=event_param_date
      puts po
      po
    end

    def event_param_date
      date_param=params.require(:event).permit(:date_rem)
      p= Date.parse( date_param.to_a.sort.collect{|c| c[1]}.join("-"))
      puts p
      p
    end

end
