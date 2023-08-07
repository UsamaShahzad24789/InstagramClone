class PostsController < ApplicationController
  include CurrentProfile
  before_action :authenticate_account!

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(post_params)
    @post.update(profile_id:current_profile)
    if @post.save
      redirect_to profiles_path
    else
      render :new , status: :unporocessable_entity
   end
  end

  def post_options

  end
  private
    def post_params
      params.require(:post).permit(:caption,:location,:image)
    end

end
