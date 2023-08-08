class CommentsController < ApplicationController
  def new
    debugger
    @comment=Comment.new
  end
  def create
    debugger
    @comment=Comment.new(comment_params)
    @comment.update(post_id:params[:post_id])
    if @comment.save
      redirect_to root_path
    end
  end


  def comment_params
    params.require(:comment).permit(:comment)
  end
end
