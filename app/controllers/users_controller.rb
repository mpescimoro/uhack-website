class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@role = 'user'
	end

	def show_super
		@user = SuperUser.find(params[:id])
		@role = 'super_user'
		render :show
	end
end
