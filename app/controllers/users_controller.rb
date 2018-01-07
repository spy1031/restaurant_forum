class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit,:update]
  def show
    
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
    params.require(:user).permit(:avatar, :intro)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
