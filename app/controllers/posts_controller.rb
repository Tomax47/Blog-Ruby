class PostsController < ApplicationController


  def index
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end


  private

  def set_posts
    #TODO: DOUBLE CHECK THE ACCURATENESS OF THIS METHOD
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :content)
  end

end
