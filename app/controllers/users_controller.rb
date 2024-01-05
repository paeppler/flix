class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:update, :destroy] # :edit: require_correct_user -> current_user? bei edit action false?? warum
  before_action :set_user, only: [:edit, :show, :require_correct_user, :destroy]

  def index 
    @users = User.all
  end

  def show
    @email = @user.email
    @reviews = @user.reviews
    @liked_movies = @user.liked_movies
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save   
      session[:user_id] = @user.id
      redirect_to @user, notice: "User successfully created!"
    else    
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Task failed successfully!"
    else    
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to movies_url, status: :see_other, alert: "Account sucessfully deleted!"
  end

  private 

  def require_correct_user
    redirect_to root_path, status: :see_other unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by!(username: params[:id])
  end
end
