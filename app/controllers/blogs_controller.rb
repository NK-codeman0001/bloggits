class BlogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :check_admin, except: [:index, :show, :share_blog]
  before_action :authenticate_user!
  before_action :set_blog, except: [:index, :new, :create, :scheduled, :draft, :archived, :bulk_archive_blogs]
  def index    
    @blogs = Blog.all.published.where(archived: false).order(published_at: :desc)
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

  def share_blog
    # BlogMailer.share_blog(@blog, current_user).deliver_later
    BlogMailer.with(user: current_user, blog: @blog).share_blog(@blog, current_user).deliver_later
    # Any key-value pair passed to with just becomes the params for the mailer action. So with(user: @user, account: @user.account) makes params[:user] and params[:account] available in the mailer action. Just like controllers have params.

    redirect_to blog_path(@blog)
  end

  def archive    
    @blog.toggle!(:archived)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :show, status: :unprocessable_entity
    end

  end

  def bulk_archive_blogs
    respond_to do |format|
      @blogs = Blog.where(id: params[:blog_ids])
      @blogs.update_all(archived: true)

      format.js
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
