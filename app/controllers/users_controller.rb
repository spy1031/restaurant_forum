class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit,:update]
  
  def index
    @users = User.all
  end

  def show

    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @user_followings = current_user.followings
    @user_followers = current_user.followers
    @user_friends = current_user.friends
    @friend_invites = current_user.invites
  end

  def edit
    
    if @user != current_user
      redirect_to user_path(@user)
    end
    
  end

  def update
   
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "profile was successfully updated"
    else
      render :edit
      flash[:alert] = "profile was failed to update"
    end
  end



  private
  def user_params
    params.require(:user).permit(:avatar, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
