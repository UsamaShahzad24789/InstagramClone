class HomesController < ApplicationController
  include CurrentProfile
  before_action :authenticate_account!

  def index
      if !Profile.account_has_profile(current_account.id).exists?
        redirect_to new_profile_path
      else
          @following=Profile.following(current_profile)
        if @following.count>=1
          # @post=[]
        # @profile=[]
        # debugger
        # @following.each do |account|
        #   @posts.append(Post.where(profile_id:account).order(created_at: :desc))
        #   @profile.append(Profile.find_by(id:account))
        # end
        @post=Post.where(profile_id:@following)
        @profile=Profile.find_by(id:@following)
        @user_name=@profile.user_name
        #Implement a logic that will display post from all the followed account of a profile
      else
        @message="Recommended For You"
        follower=Profile.max_followers
        id=follower[0]
        @post=Post.where(profile_id:id)
        @profile=Profile.find_by(id:id)
        @user_name=@profile.user_name
      end
    end


  end
end
