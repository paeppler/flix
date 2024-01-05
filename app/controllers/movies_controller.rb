class MoviesController < ApplicationController
  before_action :require_signin, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    case params[:filter]
    when "upcoming"
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    else
      @movies = Movie.released 
    end
  end

  def show
    @likers = @movie.likers
    @genres = @movie.genres.order(:name)
    if current_user
      @like = current_user.likes.find_by(movie_id: @movie.id)
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Task failed successfully!"
    else    
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save    
      redirect_to @movie, notice: "Movie successfully created!"
    else    
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other, alert: "Movie sucessfully deleted!"
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params 
    params.require(:movie).permit(:title, :total_gross, :description, :rating, :released_on, :duration, :director, :image_file_name, genre_ids: [])
  end
end
