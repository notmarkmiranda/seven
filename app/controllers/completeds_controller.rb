class CompletedsController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league
  before_action :load_game

	def update
    @game.update(completed: true) if @game.scorable?
    redirect_to league_season_game_path(league, season, @game)
	end
end
