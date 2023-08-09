# frozen_string_literal: true

class LikesController < ApplicationController

  def index
    @likes = Like.where(post_id: params[:post_id])
  end

  def new
    if !Like.find_by(email: current_account.email)
      @like = Like.new(post_id: params[:post_id], email: current_account.email)
      Like.increment_like(params[:post_id])
      redirect_to root_path if @like.save
    else
      redirect_to root_path
    end
  end

end
