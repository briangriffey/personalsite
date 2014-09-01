class BlogsController < ApplicationController

  def index
    @posts = BlogPost.order(created_at: :desc)
    respond_to do |format|
      format.json {render json: @posts}
      format.rss { render :layout => false }
    end
  end

  def show
    @post = BlogPost.find(params[:id])
    render json: @post
  end

end
