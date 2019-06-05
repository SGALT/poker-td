class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_action :set_tournament, only: [:new, :create, :edit, :update, :destroy, :start_countdown, :pause_countdown, :reset_tournament]

  def show
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

  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
    @round.tournament = @tournament
    @round.counter = @round.duration
    if @round.save
      @round.order_nb == 1 ? @round.actived! : @round.pending!
      redirect_to edit_tournament_path(@tournament)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @round.update(round_params)
    redirect_to edit_tournament_path(@tournament)
  end

  def destroy
    @round.destroy
    redirect_to edit_tournament_path(@tournament)
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_round
    @round = Round.find(params[:id])
  end

  def round_params
    params.require(:round).permit(:tournament_id, :order_nb, :small_blind, :big_blind, :ante, :duration, :category, :counter)
  end
end
