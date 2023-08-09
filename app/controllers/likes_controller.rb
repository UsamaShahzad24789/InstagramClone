class LikesController < ApplicationController
  # before_action :postId
  def index
    @likes=Like.where(post_id:params[:post_id])
  end
  def new
    if !Like.find_by(email:current_account.email)
        @like=Like.new(post_id:params[:post_id],email:current_account.email)
        Like.increment_like(params[:post_id])
      if @like.save
        redirect_to root_path
      end
    else
    redirect_to root_path
    end
  end

end
