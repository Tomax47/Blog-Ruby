class PostsController < ApplicationController


  def index
    #This will show the posts in a DESC order on the index page of the posts
    # As we want to display all the posts we sued the tag @posts plural, instead if @post
    @posts = Post.all.order("created_at DESC")
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

  def show
    set_posts
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])

  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to root_path
    else
      flash.now[:notice] = "Couldn't delete the post!"
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
