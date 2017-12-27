class UncompletedsController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league
  before_action :load_game

  def update
    @game.update(completed: false)
    redirect_to league_season_game_path(league, season, @game)
  end
end
