class AuthController < ApplicationController
	def main
	end

	def welcome
	end

	def signup
		
	end

	def login
	end

	def clearData
	end

	def create
		render plain: params[:credentials].inspect
	end
end
