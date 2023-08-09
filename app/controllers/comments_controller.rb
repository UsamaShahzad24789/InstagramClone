class CommentsController < ApplicationController
  def index
    @comment=Comment.where(post_id:params[:post_id])
  end

  def new

    @comment=Comment.new
    @post=Post.find_by(id:params[:post_id])
    Comment.increment_comment(params[:post_id])
  end
  def create

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
