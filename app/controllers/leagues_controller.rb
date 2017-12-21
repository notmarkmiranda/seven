class LeaguesController < ApplicationController
  include LeagueHelper

  before_action :redirect_visitors, except: [:index, :show]
  before_action :verify_admin_for_league, only: [:edit, :update]

  def index
    @leagues = League.all
  end

  def show
    @league = League.find_by slug:(params[:slug])
  end

  def new
    @league = League.new
  end

  def create
    @league = current_user.created_leagues.new(league_params)
    # league_creator = LeagueCreator.new(@league)
    if @league.save
      redirect_to @league
    else
      render :new
    end
  end

  def edit
    @league = League.find_by(slug: params[:slug])
  end

  def update
    @league = League.find_by(slug: params[:slug])
    if @league.update(league_params)
      redirect_to @league
    else
      render :edit
    end
  end

  private

  def league_params
    params.require(:league).permit(:name, :user_id, :privated)
  end
end
