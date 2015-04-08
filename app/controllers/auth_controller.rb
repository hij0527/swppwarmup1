class AuthController < ApplicationController
	def main
	end

	def signup
		user = UsersModel.new(user_params)
		if user.valid?
			user.save
			log_in user
			render :json => { "user_name": user.username, "login_count": user.count }
		else
			if user.errors.added?(:username, :too_short, count: 5) ||
				 user.errors.added?(:username, :too_long, count: 20)
				render :json => { "error_code": -1 }, :status => 401
			elsif user.errors.added?(:password, :too_short, count: 8) ||
						user.errors.added?(:password, :too_long, count: 20)
				render :json => { "error_code": -2 }, :status => 401
			elsif user.errors.added?(:username, :taken)
				render :json => { "error_code": -3 }, :status => 401
			else
				render :json => { "error_code": -999 }, :status => 400
			end
		end
	end

	def login
		user_params
		user = UsersModel.find_by(username: params[:username], password: params[:password])
		if user
			user.count += 1
			user.save
			log_in user
			render :json => { "user_name": user.username, "login_count": user.count }
		else
			render :json => { "error_code": -4 }, :status => 401
		end
	end

	def logout
		log_out
		render nothing: true
	end

	def clearData
		UsersModel.delete_all()
		render nothing: true
	end

	private
	def user_params
		params.permit(:username, :password)
	end
end

