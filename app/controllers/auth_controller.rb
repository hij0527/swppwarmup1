class AuthController < ApplicationController
	def main
	end

	def welcome
		@user = UsersModel.find_by(username: "00000")
	end

	def signup
		user = UsersModel.new(user_params)
		if user.valid?
			user.save
#			redirect_to welcome_path(:json => { "user_name": user.username, "login_count": user.count })
			render :json => { "user_name": user.username, "login_count": user.count }, :action => :welcome
		else
			if user.errors.added?(:username, :too_short, count: 5) ||
				 user.errors.added?(:username, :too_long, count: 20)
				render :json => { "error_code": -1 }, :action => :root, :status => 401
			elsif user.errors.added?(:password, :too_short, count: 8) ||
						user.errors.added?(:password, :too_long, count: 20)
				render :json => { "error_code": -2 }, :action => :root, :status => 401
#			elsif user.errors.added?(:username, :taken)
			elsif user.errors.added?(:username, :blank)
				render :json => { "error_code": -3 }, :action => :root, :status => 401
			else
				render :json => user.errors, :action => :root, :status => 400
#				render :json => { "error_code": -999 }, :action => :root, :status => 400
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
