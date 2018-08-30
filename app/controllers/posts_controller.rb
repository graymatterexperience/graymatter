class PostsController < ApplicationController
  def index
    @page_title = 'Message Board'
    @page_cohort = 'Cohort One'
    @post = Post.new
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @page_title = 'posting delete this soon'
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post[:user_tags] = find_user_tags(@post.body)
    @post[:auther_id] = current_user.id
    
    if @post.save
      flash[:success] = 'Successfully created a question'
      redirect_to posts_path
    else
      flash[:errors] = 'Something went wrong try again'
      redirect_to posts_path
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
