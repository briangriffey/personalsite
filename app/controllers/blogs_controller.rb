class BlogsController < ApplicationController

  def index
    @posts = BlogPost.order(created_at: :desc)
    render json: @posts
  end

end
