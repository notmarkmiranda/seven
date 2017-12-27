require 'rails_helper'

describe CompletedsController, type: :controller do
  context 'PATCH#update' do
    let(:game)   { create(:game, completed: false) }
		let(:league) { game.league }
    let(:admin)  { league.creator }
    let(:params) { { league_slug: league.slug, season_id: game.season.id, game_id: game.id } }

    it 'changes completed from false to true with multiple players' do
      create_list(:player, 2, game: game)
      expect {
        patch :update, session: { user_id: admin.id }, params: params
      }.to change { game.reload.completed }.from(false).to(true)
      expect(response).to redirect_to league_season_game_path(league, game.season, game)
    end

    it 'doesnt change completed with 0 players' do
      expect {
        patch :update, session: { user_id: admin.id }, params: params
      }.to_not change { game.reload.completed }.from(false)
      expect(response).to redirect_to league_season_game_path(league, game.season, game)
    end

    it 'doesnt change completed with 1 player' do
      create(:player, game: game)
      expect {
        patch :update, session: { user_id: admin.id }, params: params
      }.to_not change { game.reload.completed }.from(false)
      expect(response).to redirect_to league_season_game_path(league, game.season, game)
    end

    context 'redirects a non-admin' do
      let(:user) { create(:user) }
      let(:member) do
        league.grant_membership(user)
        user
      end

      it 'redirects a visitor to root path' do
        patch :update, params: params

        expect(response).to redirect_to root_path
      end

      it 'redirects a user to dashboard path' do
        patch :update, session: { user_id: user.id }, params: params

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects a member to dashboard path' do
        patch :update, session: { user_id: member.id }, params: params

        expect(response).to redirect_to dashboard_path
      end
    end
  end
end
