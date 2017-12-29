class Leagues::UsersController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league
  before_action :load_league

  def new
    session[:game_id] = params[:game_id]
    @user = User.new
  end

  def create
    @user = User.new(filtered_user_params)
    league_user = LeagueUserPlayerCreator.new(user: @user, league: league, params: other_params, game_id: session[:game_id], save_and_finish: params[:save_and_finish])
    league_user.save
    redirect_to new_league_season_game_player_path(league, current_game.season, current_game)
  end

  private

  def current_game
    @game ||= Game.find(session[:game_id])
  end

  def filtered_user_params
    game_user_params.except(:user_league_role, :player)
  end

  def game_user_params
    params.require(:user).permit(:email, :first_name, :last_name, user_league_role: [:invited, :admin], player: [:additional_expense])
  end

  def other_params
    game_user_params.slice(:user_league_role, :player)
  end
end
