class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	puts "hola"
  	p params
  	puts @user = User.find_by(params[:id])
  end

  def create
    p "params"
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      p "SAVED"# Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      #es lo mismo que: redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

    #Strong parameters
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end