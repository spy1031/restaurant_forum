class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id],status: 1)
    @inverse_friendship = Friendship.new(user_id: params[:friend_id],friend_id: current_user.id ,status: 2)

    if @friendship.save && @inverse_friendship.save
      flash[:notice] = "Invite friend Successfully"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence      
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @inverse_friendship = Friendship.where(user_id: params[:id],friend_id: current_user.id).first
    @friendship.destroy && @inverse_friendship.destroy
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @inverse_friendship = Friendship.where(user_id: params[:id],friend_id: current_user.id).first
    @friendship.status =3
    @inverse_friendship.status =3
    if @friendship.save && @inverse_friendship.save
      flash[:notice] = "Add friend Successfully"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence      
    end
    redirect_back(fallback_location: root_path)
  end


end
