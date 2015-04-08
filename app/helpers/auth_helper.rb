module AuthHelper
	def log_in(user)
		session[:user_name] = user.username
	end

	def log_out
		session.delete(:user_name)
	end
end
