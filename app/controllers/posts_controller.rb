class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :authenticate_creator!, except: [:show, :index, :search]

  # GET /posts
  # GET /posts.json
  def index
    @unpublished_posts = Post.where(published_at: nil) if super_user_signed_in?
    @posts = Post.where.not(published_at: nil).order(published_at: :desc)
    if params[:tag_id]
      @selected_tag_id = params[:tag_id].to_i
      @posts = @posts.joins(:tagships).where(tagships: {tag_id: @selected_tag_id})
    end
  end

  def search
    @posts = Post.basic_search(params[:search])
    render :index
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments.order(:created_at)
    @selected_comment = params[:selected_comment].to_i
  end

  # GET /posts/new
  def new
    @post = Post.new
    @plain_text = params[:plain_text]
    @submit_text = "Crea post"
  end

  # GET /posts/1/edit
  def edit
    @plain_text = params[:plain_text]
    @submit_text = "Modifica post"
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new post_params.merge!({creator: current_creator(:super_user)})
    @post.add_or_create_tags(tag_names)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Il post è stato creato' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @post.published_at = DateTime.now

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Il post è stato pubblicato' }
      else
        format.html { render action: 'index', alert: 'Qualcosa è andato storto' }
      end
    end
  end

  def unpublish
    @post.published_at = nil

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Il post è stato spubblicato' }
      else
        format.html { render action: 'index', alert: 'Qualcosa è andato storto' }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.update_tags(tag_names)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def authenticate_creator!
      redirect_to new_super_user_session_path, alert: "Devi essere loggato per poter postare" unless creator_signed_in?
    end

    def tag_names
      parse_tag_names(params[:tag_names])
    end

end
