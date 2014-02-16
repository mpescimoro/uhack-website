class Users::RegistrationsController < Devise::RegistrationsController

  before_action :set_user, only: [:show]
  before_action :set_super_user, only: [:show_super]
  before_action :set_recent_activities, only: [:show, :show_super]

	def index
		@super_users = SuperUser.all
		@users = User.all
		if params[:tag_id]
			@selected_tag_id = params[:tag_id].to_i
			@super_users = @super_users.joins(:tagships).where(tagships: {tag_id: @selected_tag_id})
			@users = @users.joins(:tagships).where(tagships: {tag_id: @selected_tag_id})
		end
	end

	def edit
		#render 'users/registrations/edit'
	end

	def show
		@role = 'user'
    @comments = @user.comments.order(:created_at).take(5)
	end

	def show_super
		@role = 'super_user'
		render :show
	end

	private
	def update_resource(resource, parameters)
		resource.update_tags(parse_tag_names(params[:tags]))
    resource.save
		super(resource, parameters)
	end

  def set_user
    @user = User.find(params[:id])
  end

  def set_super_user
		@user = SuperUser.find(params[:id])
  end

  def set_recent_activities
    @comments = @user.comments.order(:created_at).take(5)
    @posts = if @user.respond_to? :posts
               @user.posts.where.not(published_at: nil).order(:published_at).take(5)
             else
               []
             end
    @recent_activities = (@comments + @posts).sort do |a, b|
      b.activity_date <=> a.activity_date
    end.take(5)
  end

end
