class GamesController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league, except: [:index, :show]
  before_action :load_season, only: [:new, :create]
  before_action :load_game, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @game = season.games.new
  end

  def create
    @game = season.games.new(game_params)
    if @game.save
      redirect_to league_season_game_path(league, season, @game)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if game.update(game_params)
      redirect_to league_season_game_path(league, season, game)
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:date, :buy_in, :completed, :season_id, :attendees)
  end
end
