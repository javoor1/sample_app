class SessionsController < ApplicationController

  def new
  end

  def create
    p "dentro de sessions controller create"
    p params
    user = User.find_by(email: params[:session][:email].downcase)
    p user
    if user && user.authenticate(params[:session][:password])
      p "dentro del IF user"
      log_in(user) #llamas al método que crea la session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
      # redirect_to user_url(user.id)
      # redirect_to action: "show", id: user.id
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_path
    # redirect_to root_url
  end

end