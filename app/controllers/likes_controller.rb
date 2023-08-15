# frozen_string_literal: true

class LikesController < ApplicationController
  def index
    @likes = Like.where(post_id: params[:post_id])
  end

  def new
    current_like = Like.where(post_id: params[:post_id]).where(email: current_account.email)
    profile_id=Post.find_by(id:params[:post_id])
    if !current_like.exists?
      @like = Like.new(post_id: params[:post_id], email: current_account.email)
      Like.increment_like(params[:post_id])
      @like.save
      if request.referer.include? "profiles"
        redirect_to profile_path(profile_id.profile_id)
      else
        redirect_to root_path
      end
    end
  end

  def un_like
    current_like = Like.where(post_id: params[:id]).where(email: current_account.email)
    profile_id=Post.find_by(id:params[:id])
    if current_like.exists?
      current_like.destroy_all
      Like.decrement_like(params[:id])
      if request.referer.include? "profiles"
        redirect_to profile_path(profile_id.profile_id)
      else
        redirect_to root_path
      end
    end
  end
end
