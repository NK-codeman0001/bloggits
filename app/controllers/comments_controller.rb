class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if !@comment.save
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end

    redirect_to blog_path(params[:blog_id])

  end

  def update
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.update(is_archived: !@comment.is_archived)
    redirect_to blog_path(@blog)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(blog_id: params[:blog_id])
  end

end
