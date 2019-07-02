class TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[
    show edit update destroy busted start_countdown pause_countdown reset_tournament
  ]

  def index
    @tournaments = policy_scope(Tournament)
  end

  def show
    timer if @tournament.rounds.any?
    next_break if @tournament.rounds.any?
  end

  def copy
    if params[:id]
      tournament = Tournament.find(params[:id])
    else
      tournament = Tournament.find(params[:tournament_id])
    end
    @tournament = tournament.amoeba_dup
    authorize @tournament
    @tournament.save
    redirect_to tournaments_path
  end

  def busted
    busted_nb = params[:busted].to_i
    @tournament.save if (@tournament.remaining_attendees += busted_nb) >= 1
    redirect_to edit_tournament_path(@tournament)
  end

  def new
    @tournament = Tournament.new
    authorize @tournament
  end

  def create
    @tournament = Tournament.new(tournament_params)
    authorize @tournament
    @tournament.remaining_attendees = @tournament.attendees_nb
    if @tournament.save
      redirect_to tournaments_path
    else
      render :new
    end
  end

  def edit
    @rounds = Round.all
    timer if @tournament.rounds.any?
  end

  def update
    @tournament.update(tournament_params)
    redirect_to edit_tournament_path(@tournament)
  end

  def destroy
    @tournament.destroy
    redirect_to tournaments_path
  end

  def start_countdown
    if @tournament.rounds.where(state: "actived")[0]
      tournament_round = @tournament.rounds.where(state: "actived")[0]
      tournament_round.ends_at = Time.now + tournament_round.counter
      tournament_round.save
    end
    redirect_to edit_tournament_path(@tournament)
  end

  def pause_countdown
    if @tournament.rounds.where(state: "actived")[0]
      tournament_round = @tournament.rounds.where(state: "actived")[0]
      tournament_round.counter = tournament_round.ends_at - Time.now
      tournament_round.ends_at = nil
      tournament_round.save
      @tournament.next_break = nil
      @tournament.save
    end
    redirect_to edit_tournament_path(@tournament)
  end

  def reset_tournament
    @tournament.rounds.each do |round|
      round.counter = round.duration * 60
      round.pending!
      round.ends_at = nil
      round.save
    end
    @tournament.rounds.where(order_nb: 1)[0].actived!
    redirect_to edit_tournament_path
  end

  private

  def timer
    unless @tournament.rounds.where(state: "actived")[0].nil?
      i = @tournament.rounds.where(state: "actived")[0].order_nb
      @tournament_round = @tournament.rounds.where(order_nb: i)[0]
      @next_round = @tournament.rounds.where(order_nb: i + 1)[0]
    end
    action_timer
  end

  def action_timer
    if @tournament_round&.ends_at && Time.now > @tournament_round.ends_at && @next_round
      @next_round.ends_at = Time.now + (@next_round.duration * 60)
      @tournament_round.ended!
      @next_round.actived!
    elsif @tournament_round&.ends_at && Time.now > @tournament_round.ends_at
      @tournament_round.ended!
    end
  end

  def next_break
    unless @tournament.rounds.where(state: "actived")[0].nil?
      i = @tournament.rounds.where(state: "actived")[0].order_nb
    end
    action_break(i)
  end

  def action_break(ind)
    total_time_before_break = 0
    while @tournament.rounds.where(order_nb: ind)[0] && @tournament.rounds.where(order_nb: ind)[0].category != "break"
      if !@tournament.rounds.where(order_nb: ind)[0].ends_at.nil?
        total_time_before_break += (@tournament.rounds.where(order_nb: ind)[0].ends_at - Time.now)
      else
        total_time_before_break += @tournament.rounds.where(order_nb: ind)[0].counter
      end
      ind += 1
    end
    @tournament.next_break = Time.now + total_time_before_break
  end

  def set_tournament
    if params[:id]
      @tournament = Tournament.find(params[:id])
    else
      @tournament = Tournament.find(params[:tournament_id])
    end
    authorize @tournament
  end

  def tournament_params
    params.require(:tournament).permit(:title, :sub_title,:attendees_nb, :starting_stack, :color, :font_color, :remaining_attendees, :busted)
  end
end
