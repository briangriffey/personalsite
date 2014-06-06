class BlogsController < ApplicationController

  def index
    @posts = BlogPost.order(created_at: :desc)
    render json: @posts
  end

  def show
    @post = BlogPost.find(params[:id])
    render json: @post
  end

end
