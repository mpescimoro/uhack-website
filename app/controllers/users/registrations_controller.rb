class Users::RegistrationsController < Devise::RegistrationsController

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
		render 'users/registrations/edit'
	end

	def show
		@user = User.find(params[:id])
		@role = 'user'
	end

	def show_super
		@user = SuperUser.find(params[:id])
		@role = 'super_user'
		render :show
	end

	private
	def update_resource(resource, parameters)
		logger.debug "%%%%%%%%%%TAGS= #{params[:tags]}\n"
		resource.update_tags(parse_tag_names(params[:tags]))
		super(resource, parameters)
	end

end
