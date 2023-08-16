# frozen_string_literal: true

class PostsController < ApplicationController
  include CurrentProfile
  before_action :authenticate_account!
  skip_before_action :verify_authenticity_token
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.update(profile_id: current_profile)
    @postcount = Post.all.count
    if @post.save
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

  private

  def post_params
    params.require(:post).permit(:caption, :location, :image)
  end

  def edit_params
    params.require(:post).permit(:caption, :location)
  end
end
