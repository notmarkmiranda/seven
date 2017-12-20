class LeaguesController < ApplicationController
  before_action :redirect_visitors, except: [:index, :show]

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
    @league = current_user.leagues.new(league_params)
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
