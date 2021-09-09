class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user,only:[:show,:edit ,:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    if logged_in?
      flash[:danger] = '権限がありません。'
      redirect_to tasks_path
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to tasks_path, notice: "権限がありません"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
