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
        @post = []
        @profile = []
        @following.each do |x|
          data = Post.where(profile_id: x)
          @post.append(data) if data.count != 0
          @profile.append(Profile.find_by(id: x))
        end
      else
        @message = 'Recommended For You'
        follower = Profile.max_followers
        @post = []
        @profile = []
        follower.each do |x|
          data = Post.where(profile_id: x.followed_id)
          @post.append(data) if data.count != 0
          @profile.append(Profile.find_by(id: x.followed_id))
        end
      end
      @post = @post.flatten
      @current_profile_picture = current_profile_picture
      # @user_name = @profile.user_name
    end
  end
end
