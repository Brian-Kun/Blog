class PostsController < ApplicationController

  before_action :find_post, only: [:show,:edit,:update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    # Creates a post so the form can fill it out
    @post = Post.new
    @post = current_user.posts.build
  end

  def create
    # Creates the actual post from the parameters and then redirects to if if created successfully
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'new'
    end

  end


  def show
    # Searches for the post when given the parameters from the url.
    # If the url is posts/1 this code will search for Post.find(1);
  end

  def edit
    #
  end


  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    # Makes sure that the post only accepts these parameters. This makes it very secure
    params.require(:post).permit(:title,:body)
  end

end
