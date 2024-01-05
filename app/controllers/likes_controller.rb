class LikesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @movie.likes.create!(user: current_user )
    redirect_to @movie
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy 
    redirect_to @movie
  end

  private

  def set_movie 
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
