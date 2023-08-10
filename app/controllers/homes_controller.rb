# frozen_string_literal: true

class HomesController < ApplicationController
  include CurrentProfile
  include ProfilePicture
  before_action :authenticate_account!

  def index
    if !Profile.account_has_profile(current_account.id).exists?
      redirect_to new_profile_path
    else
      @following = Profile.following(current_profile)
      if @following.count >= 1
        @post = Post.where(profile_id: @following)
        @profile = Profile.find_by(id: @following)
      else
        @message = 'Recommended For You'
        follower = Profile.max_followers
        id = follower[0]
        @post = Post.where(profile_id: id)
        @profile = Profile.find_by(id:)
      end
      @current_profile_picture = current_profile_picture
      @user_name = @profile.user_name
    end
  end
end
