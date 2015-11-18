class SessionsController < ApplicationController
  	def new
		@user = User.new
		@is_login = true
		if current_user && current_user.role =='ADMIN'
			redirect_to answers_path
		elsif current_user && current_user.role =='TRANSLATOR'
			redirect_to translate_index_path
		end
	end

	def create
		u = User.where(username: params[:user][:username]).first
		if u && u.authenticate(params[:user][:password])
			session[:user_id] = u.id.to_s
				if u.role =='ADMIN'
					redirect_to answers_path
				elsif u.role =='TRANSLATOR'
					redirect_to translate_index_path
				end
			else
				# Go back to the login page
				redirect_to root_path
		end
	end





	def destroy
		reset_session
		redirect_to root_path
	end
end
