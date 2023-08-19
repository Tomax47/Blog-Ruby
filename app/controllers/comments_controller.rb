class CommentsController < ApplicationController


  def new
    @post = Post.find(params[post_id])
    @comment = @post.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to @post
    else
      flash.now[:notice] = "Couldn't add a comment!"
    end

  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to @post
      flash.now[:notice] = "Comment has been deleted!"
    else
      flash.now[:notice] = "Couldn't delete the comment!"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:name, :comment)
  end

end
