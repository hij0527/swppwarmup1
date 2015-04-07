class AuthController < ApplicationController
	def main
	end

	def welcome
		@user = UsersModel.find(1)
	end

	def signup
		user = UsersModel.new(user_params)
		if user.valid?
			user.save
#			redirect_to welcome_path(:json => { "user_name": user.username, "login_count": user.count })
			render :json => { "user_name": user.username, "login_count": user.count }, :action => "welcome"
		else
			if user.errors.added?(:username, :too_short) || user.errors.added?(:username, :too_long)
				render :json => { "error_code": -1 }, :action => "welcome"
			elsif user.errors.added?(:password, :too_short) || user.errors.added?(:password, :too_long)
				render :json => { "error_code": -2 }, :action => "root"
			elsif user.errors.added?(:username, :taken)
				render :json => { "error_code": -3 }, :action => "root"
			end
		end
	end

	def login
	end

	def clearData
	end

	def create
		render plain: params[:credentials].inspect
	end

	private
	def user_params
		params.require(:credentials).permit(:username, :password)
	end
end
