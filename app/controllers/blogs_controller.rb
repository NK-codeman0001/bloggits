class BlogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :check_admin, except: [:index, :show, :share_blog, :search]
  before_action :authenticate_user!
  before_action :set_blog, except: [:index, :new, :create, :scheduled, :draft, :archived, :bulk_archive_blogs, :search]
  def index    
    @blogs = Blog.all.published.where(archived: false).search(params[:search]).order(published_at: :desc)
    # @pagy, @records = pagy(Product.all)
    @pagy, @blogs = pagy(@blogs)
    
    respond_to do |format|
      format.html
      format.json { render json: @blogs}
    end
    
  rescue Pagy::OverflowError
    # render :json => { :error => "Page Over Flow"}, :status => 404
    redirect_to root_path(page: 1), :status => 404
    
  end

 
  def scheduled
    @blogs = Blog.all.scheduled.order(published_at: :desc)
    @pagy, @blogs = pagy(@blogs)
    
    respond_to do |format|
      format.html
      format.json { render json: @blogs}
    end
    
  rescue Pagy::OverflowError
    # render :json => { :error => "Page Over Flow"}, :status => 404
    redirect_to root_path(page: 1), :status => 404
   
  end

  def draft
    @blogs = Blog.all.draft.order(created_at: :desc)
    @pagy, @blogs = pagy(@blogs) 
   
    respond_to do |format|
      format.html
      format.json { render json: @blogs}
    end
    
  rescue Pagy::OverflowError
    # render :json => { :error => "Page Over Flow"}, :status => 404
    redirect_to root_path(page: 1), :status => 404
   
  end

  def archived
    @blogs = Blog.all.archived.order(updated_at: :desc)
    @pagy, @blogs = pagy(@blogs)
 
    respond_to do |format|
      format.html
      format.json { render json: @blogs}
    end
    
  rescue Pagy::OverflowError
    # render :json => { :error => "Page Over Flow"}, :status => 404
    redirect_to root_path(page: 1), :status => 404
  end

  def show
      respond_to do |format|
        format.html
        format.json { render json: @blog}
      end
  end

  def new
    @blog = Blog.new
  end

  def create
    if BlogCreateJob.perform_async(blog_params.as_json)
      # render :json => {success: blog_params.as_json}, :status => 201
      redirect_to root_path, :status => 201
    # else
    #   render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if !BlogUpdateJob.perform_async(params[:id], blog_params.as_json).nil?
      redirect_to blog_path(@blog), :status => 202

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
    if !BlogArchiveJob.perform_async(params[:id]).nil?
      redirect_to blog_path(@blog), :status => 202
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

  def search
    # Debugger
    # @posts = Blog.where("LOWER(title) LIKE ?", "%#{params[:search].downcase}%")

    respond_to do |format|
      # @posts = Blog.where("LOWER(title) LIKE ?", "%#{params[:search].downcase}%")
      @posts = Blog.all.published.where(archived: false).order(published_at: :desc).where("LOWER(title) LIKE ?", "%#{params[:search].downcase}%")
      @post_count = @posts.count
      @pagy, @posts = pagy(@posts)
    # rescue Pagy::OverflowError
    #   redirect_to root_path(page: 1)
      format.js
    end
    rescue Pagy::OverflowError
      redirect_to root_path(page: 1)
  end

  private 
  def check_admin
    if user_signed_in? && current_user && current_user.is_admin==false
      redirect_to root_path, :status => 405
      # render :json => { :error => "Method Not Allowed"}, :status => 405
    end
  end

  def set_blog
    @blog = user_signed_in? ? Blog.find(params[:id]) : Blog.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # render :json => { :error => "Record Not Found"}, :status => 404
    redirect_to root_path, :status => 404
  end

  def blog_params
    params.require(:blog).permit(:title,:content,:archived,:published_at)
    
  end
end
