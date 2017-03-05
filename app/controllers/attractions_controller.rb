class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update]

  def index
    @attractions = Attraction.all
  end

  def show
  end

  def new
    @attraction = Attraction.new
  end

  def create
    attraction = Attraction.new(attraction_params)
    if current_user.admin
      attraction.save
      redirect_to attraction_path(attraction, notice: "Attraction has been created.")
    else
      redirect_to attractions_path
    end
  end

  def edit
  end

  def update
    if current_user.admin
      @attraction.update(attraction_params)
      redirect_to attraction_path(@attraction, notice: "Attracion has been updated.")
    else
      redirect_to attractions_path
    end
  end

  private
  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end
end
