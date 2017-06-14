class UsersController < ApplicationController
  def index
    if session[:user_id]
      @documents = Document.where("user_id = ? OR is_public = ?",
                                  session[:user_id], 1)
    else
      @documents = Document.where(is_public: true)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_home_path
    else
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
