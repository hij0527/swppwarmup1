class AuthController < ApplicationController
	def main
	end

	def welcome
	end

	def signup
		@user = UsersModel.new(user_params)
		@user.save
		render :json => { name: "name comes here" }
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
