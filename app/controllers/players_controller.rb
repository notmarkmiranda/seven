class PlayersController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league, except: [:index, :show]
  before_action :load_game, only: [:new, :create]
  before_action :load_player, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
    @player = Player.new
  end

  def create
    @player = game.players.new(player_params)
    @player.save
    redirect_to new_league_season_game_player_path(league, season, game)
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to league_season_game_player_path(league, season, game, @player)
    else
      render :edit
    end
  end

  private

  def player_params
    params.require(:player).permit(:game_id, :finishing_place, :additional_expense, :score, :user_id, :finished_at)
  end
end
