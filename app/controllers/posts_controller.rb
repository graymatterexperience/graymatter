class PostsController < ApplicationController
  def index
    @page_title = 'Message Board'
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    #TODO can not use first name what if lots of people have the name Kim
    #how would I tell them apart
    @post = Post.new(post_params)
    @post[:user_tags] = find_user_tags(@post.body)
    
    if @post.save
      flash[:success] = 'Successfully created a question'
      redirect_to posts_path
    else
      flash[:error] = 'Something went wrong try again'
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      reder 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_user_tags(string)
    User.all.map { |user| user.user_tag if string.include?(user.user_tag) }.compact
  end
  
  def post_params
    params.require(:post).permit(:title,
                                 :body,
                                 :auther_id,
                                 :user_tags => [])
  end
end
