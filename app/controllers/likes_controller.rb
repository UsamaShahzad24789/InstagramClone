class LikesController < ApplicationController
  # before_action :postId
  def create
    debugger
    @like=Like.new
  end
  # private
  #   def postId
  #     @post=Post.find_by(params{:post_id})
  #   end
end
