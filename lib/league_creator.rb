class LeagueCreator
  attr_reader :league

  def initialize(league)
    @league = league
  end

  def save
    if league.save
      UserLeagueRole.create!(user_id: league.user_id, role: 1, league_id: league.id)
      return true
    end
    return false
  end
end
