class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_action :set_tournament, only: [:new, :create, :edit, :update, :destroy]

  def new
    @round = Round.new
    authorize @round
  end

  def create
    @round = Round.new(round_params)
    authorize @round
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
    authorize @round
  end

  def round_params
    params.require(:round).permit(:tournament_id, :order_nb, :small_blind, :big_blind, :ante, :duration, :category, :counter)
  end
end
