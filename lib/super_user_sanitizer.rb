class SuperUser::ParameterSanitizer < Devise::ParameterSanitizer

	def sign_in
		default_params.permit(:email, :password)
	end

end