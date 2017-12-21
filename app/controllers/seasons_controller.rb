class SeasonsController < ApplicationController
  def create
    league = League.find_by(slug: params[:league_slug])
    season = league.seasons.new(season_params)
    season.save
    redirect_to league_season_path(league, season)
  end

  def update
    league = League.find_by(slug: params[:league_slug])
    season = Season.find(params[:id])
    season.update(season_params)
    redirect_to league_season_path(league, season)
  end

  private

  def season_params
    params.require(:season).permit(:active)
  end
end
