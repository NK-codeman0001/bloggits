class BlogsController < ApplicationController
  before_action :check_admin, except: [:index, :show]
  before_action :authenticate_user!
  before_action :set_blog, except: [:index, :new, :create, :scheduled, :draft, :archived]
  def index    
    @blogs = Blog.all.published.order(published_at: :desc)
    # @pagy, @records = pagy(Product.all)
    @pagy, @blogs = pagy(@blogs)
    rescue Pagy::OverflowError
      redirect_to root_path(page: 1)

  end

  def scheduled
    @blogs = Blog.all.scheduled.order(published_at: :desc)
    @pagy, @blogs = pagy(@blogs)
    rescue Pagy::OverflowError
      redirect_to root_path(page: 1)
  end

  def draft
    @blogs = Blog.all.draft.order(created_at: :desc)
    @pagy, @blogs = pagy(@blogs)
    rescue Pagy::OverflowError
      redirect_to root_path(page: 1)
  end

  def archived
    @blogs = Blog.all.archived.order(updated_at: :desc)
    @pagy, @blogs = pagy(@blogs)
    rescue Pagy::OverflowError
      redirect_to root_path(page: 1)
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @blog.destroy
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def archive    
    @blog.toggle!(:archived)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :show, status: :unprocessable_entity
    end

  end

  private 
  def check_admin
    if user_signed_in? && current_user && current_user.is_admin==false
      redirect_to root_path
    end
  end

  def set_blog
    @blog = user_signed_in? ? Blog.find(params[:id]) : Blog.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def blog_params
    params.require(:blog).permit(:title,:content,:archived,:published_at)
    
  end
end
