

class SuperUser::ParameterSanitizer < Devise::ParameterSanitizer

	def sign_in
		default_params.permit(:email, :password)
	end

	def account_update
		default_params.permit(:email, :username, :image_url, :description, :password, :current_password)
	end

end

class User::ParameterSanitizer < Devise::ParameterSanitizer

	def sign_in
		default_params.permit(:email, :password)
	end

	def sign_up
		default_params.permit(:email, :username, :password)
	end

	def account_update
		default_params.permit(:email, :username, :image_url, :description, :password, :current_password)
	end

end