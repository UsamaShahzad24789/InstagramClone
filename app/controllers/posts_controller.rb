# frozen_string_literal: true

class PostsController < ApplicationController
  include CurrentProfile
  before_action :authenticate_account!
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(profile_id: current_profile))
    if @post.save
      @postcount = Post.all.count
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', partial: 'posts/post', locals: { post: @post }) }
        format.html { redirect_to profiles_path, notice: 'Post Created' }
      end
    else
      render :new, status: :unporocessable_entity
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @post.destroy
    respond_to(&:js)
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.update(edit_params)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("onePost-#{@post.id}", partial: 'posts/post', locals: { post: @post }) }
      format.html { redirect_to profiles_path, notice: 'Post Created' }
    end
  end

  def share
    post=Post.find_by(id:params[:id])
    share_post=post.dup
    share_post.update(comment_count:0)
    share_post.update(likes_count:0)
    share_post.update(profile_id:current_profile)
    share_post.update(shared:Profile.where(id:post.profile_id).pluck(:user_name))
    share_post.update(status:1)
    share_post.update(images:post.images_blobs)
  end

  private

  def post_params
    params.require(:post).permit(:caption, :location, images: [])
  end

  def edit_params
    params.require(:post).permit(:caption, :location)
  end
end
