class UsersController < Devise::RegistrationsController

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
		resource.add_or_create_tags(parse_tag_names(params[:tags]))
		super(resource, parameters)
	end

end
