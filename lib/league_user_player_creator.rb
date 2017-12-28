class LeagueUserPlayerCreator
  attr_accessor :user
  attr_reader :league, :ulr_params, :player_params, :game, :save_and_finish

  def initialize(user:, league:, params:, game_id:, save_and_finish:)
    @user = user
    @league = league
    @ulr_params = params[:user_league_role]
    @player_params = params[:player]
    @save_and_finish = save_and_finish
    @game = Game.find(game_id)
  end

  def save
    user.password = SecureRandom.hex(10)
    if user.save
      grant_member_or_admin
      send_invitation
      create_player
      return true
    end
    return false
  end

  private

  def create_player
    game.players.create!(
      player_params.merge(
        user_id: user.id,
        finished_at: Time.current)
    ) if save_and_finish
  end
  def grant_member_or_admin
    ulr_params[:admin] == '1' ? league.grant_adminship(user) : league.grant_membership(user)
  end

  def send_invitation
    league.send_invitation(user) if ulr_params[:invited] == '1'
  end
end
