module LeagueHelper
  include ApplicationHelper

  def league
    @league ||= League.find_by(slug: league_param)
  end

  def season
    @season ||= Season.find(season_param)
  end

  def game
    @game ||= Game.find(game_param)
  end

  def load_league
    league
  end

  def load_season
    load_league
    season
  end

  def load_game
    load_season
    game
  end

  def verify_admin_for_league
    return redirect_to dashboard_path if current_user && current_user.not_admin?(league)
    redirect_to root_path unless current_user
  end

  private

  def league_param
    controller_name == 'leagues' ? params[:slug] : params[:league_slug]
  end

  def season_param
    controller_name == 'seasons' ? params[:id] : params[:season_id]
  end

  def game_param
    controller_name == 'games' ? params[:id] : params[:game_id]
  end
end
