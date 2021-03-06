class SessionsController < ApplicationController
	
	def create
  		#byebug sessions
  		@user = User.find_by(username: params[:username])
  		if @user && @user.authenticate(params[:password])
  			session[:user_id] = @user.id
  			session[:user_name] = @user.name
  			puts "URL: #{request.original_url}"

  			if !session[:before_login_url]
  				session[:before_login_url] = main_menu_path
  			end
  			redirect_to session[:before_login_url]
  		else
  			flash[:notice] = "Wrong Username and/or Password"
  			redirect_to login_path
  		end
  		#if @user && @user.password == params[:password]
  		#white_list = params[:user].permit(:name, :username, :password)
  		#user = User.new(white_list)

  		# if user.valid?
  		# 	user.save
  		# 	redirect_to main_menu_path
  		# else
  		# 	flash[:notice] = "Something was wrong, prob a field wasn't filled in. Or maybe the username isn't unique."
  		# 	redirect_to login_path
  		# end
  	end

  	def destroy
	    session.delete :user_id
	    session.delete :user_name

	    #Used to make sure u return to the page u logout from
	    if !session[:before_login_url]
  			session[:before_login_url] = main_menu_path
  		end
		redirect_to session[:before_login_url]
	end
end