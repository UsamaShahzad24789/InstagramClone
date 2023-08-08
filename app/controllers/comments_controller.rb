class CommentsController < ApplicationController
  def new
    debugger
    @comment=Comment.new
  end
  def create
    debugger
    @comment=Comment.new(comment_params)
    if @comment.save
      redirect_to root_path
    end

  end
  def comment_params
    params.require(:comment).permit(:comment,:post_id)
  end
end
