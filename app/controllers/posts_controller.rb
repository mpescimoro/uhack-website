class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!, except: [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where("published_at <= ?", Time.now).order(published_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
    @post = Post.new(post_params)
    
    @post.published_at = Time.now if @post.published_at < Time.now

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
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
      params.require(:post).permit(:title, :body, :published_at)
    end

    def authenticate!
      redirect_to new_super_user_session_path, alert: "Devi essere loggato per poter postare" unless signed_in? [:admin, :super_user]
    end
end
