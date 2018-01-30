class FollowshipsController < ApplicationController

  def create
    @followships = current_user.followships.build(following_id: params[:following_id])
    if @followships.save
      flash[:notice] = "Successfully followed"
    else
      flash[:alert] = @followships.errors.full_messages.to_sentence      
    end
    redirect_back(fallback_location: root_path)
  end
end
