# frozen_string_literal: true

class ProfilesController < ApplicationController
  include CurrentProfile
  include ProfilePicture
  include AvatarCreator
  before_action :authenticate_account!
  skip_before_action :authenticate_account!, only: %i[after_registration_path after_confirmation_path]
  skip_before_action :verify_authenticity_token, only: [:search]
  layout 'flow', only: [:new]
  def index
    if !Profile.account_has_profile(current_account.id).exists?
      redirect_to new_profile_path
    else
      @current_profile_picture = current_profile_picture
      @profile = Profile.find_by(account_id: current_account.id)
      @user_name_for_api = @profile.user_name.gsub(" ", "+")
      @posts = Post.where(profile_id: current_profile).order(created_at: :desc)
      @followers = Profile.followers_count(@profile.id)
      @following = Profile.following_count(@profile.id)
      @post_count = Profile.post_count(@profile.id)
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.update(email: current_account.email, account_id: current_account.id)
    if @profile.save
      debugger
      if !@profile.profile_picture.representable?
        name_creator
      end
      respond_to do |format|
        format.html { redirect_to profiles_path, notice: 'Post was successfully Created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @current_profile_picture = current_profile_picture
    profile_id = params[:id]
    @profile = Profile.find_by(id: profile_id)
    @followers = Profile.followers_count(profile_id)
    @following = Profile.following_count(profile_id)
    @post_count = Profile.post_count(profile_id)
    follow_check = Friendship.where(follower_id: current_profile).where(followed_id: profile_id)
    followed_id = follow_check.pluck(:followed_id)
    @has_followed = if follow_check.empty?
                      0
                    elsif profile_id.to_i == followed_id[0]
                      1
                    else
                      0
                    end

    if profile_id.to_i == current_profile
      redirect_to profiles_path
    elsif @profile.status == 'public_profile'
      @posts = Post.where(profile_id:).order(created_at: :desc)
    elsif @profile.status == 'private_profile' && @has_followed == 1
      @posts = Post.where(profile_id:).order(created_at: :desc)
    else
      @message = 'This account is private'
    end
  end

  def search
    @result = if params[:searchQuery].include? '@'
                Profile.where(email: params[:searchQuery])
              else
                Profile.where(user_name: params[:searchQuery])
              end
  end

  def after_registration_path
    render layout: 'flow'
  end

  def after_confirmation_path
    render layout: 'flow'
  end

  private

  def profile_params
    params.require(:profile).permit(:user_name, :profile_picture)
  end
end
