class FriendshipsController < ApplicationController
  include CurrentProfile
  def new
    current_profile
    id=params[:profile_id]
    Friendship.create(follower_id:current_profile,followed_id:id.to_i)
    redirect_to profile_path(id)
  end
  def edit
    current_profile
    id=params[:profile_id]
    friendship=Friendship.find_by(followed_id:id.to_i,follower_id:current_profile)
    friendship.destroy
    redirect_to profile_path(id)
  end
end
