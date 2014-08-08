class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_commentable, only: [:create, :edit, :update]
  before_action :authenticate_comment_commenter!, only: [:edit, :update, :destroy]

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/1/edit
  def edit
    @editing_comment = @comment
    respond_to do |format|
      format.html
      format.js { set_root }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    if commenter_signed_in?
      @commentable.comments.build comment_params.merge!({commenter: current_commenter})
    else
      guest = Guest.find_or_create(guest_params)
      guest.save
      @commentable.comments.build comment_params.merge!({commenter: guest})
    end

    respond_to do |format|
      if verify_recaptcha
        if @commentable.save
          format.html { redirect_to @commentable.commentable_root, notice: 'Commento creato' }
          format.js { set_root }
        else
          format.html { redirect_to @commentable, alert: 'Qualcosa non va' }
          format.js
        end
      else
        format.html { redirect_to @commentable.commentable_root, alert: 'Recaptcha sbagliato!' }
      end
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @commentable, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
        format.js { set_root; render :edit }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @commentable = @comment.commentable
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @commentable.commentable_root }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable
      @commentable = if params[:post_id]
                       Post.find(params[:post_id])
                     elsif params[:comment_id]
                       Comment.find(params[:comment_id])
                     else
                       raise Exception, "Couldn't find commentable, have you created new commentable models?"
                     end
    end

    def set_root
      case @commentable.commentable_root.class.to_s
      when 'Post'
        @post = @commentable.commentable_root
      end
    end

    def authenticate_comment_commenter!
      unless current_commenters.any? { |commenter| commenter == @comment.commenter }
        redirect_to params[:previous_url], alert: "Non hai i permessi per farlo"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def guest_params
      params.require(:comment).require(:guest).permit(:username, :email)
    end

end
