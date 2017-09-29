class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	puts "dentro de show"
    puts "*******"
  	p params[:id]
    puts "*******"
  	p @user = User.find_by_id(params[:id]) #p @user = User.find_by(params[:id]) no funcionaba regresaba el User con id = 1 SIEMPRE!
  end

  def create
    p "params"
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      p "SAVED"# Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      #es lo mismo que: redirect_to user_url(@user)
      #redirige al show del user específico.
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