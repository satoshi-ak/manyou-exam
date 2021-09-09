class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_admin

    def index
      @users = User.all.includes(:tasks)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice:"ユーザーを登録しました"
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path, notice: "ユーザーを更新しました"
      else
        render :edit, notice: "管理者権限を外すと管理者がいなくなります"
      end
    end

    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: "ユーザーを削除しました"
      else
        redirect_to admin_users_path,notice: "削除すると管理者がいなくなります"
      end
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      unless current_user.admin?
        redirect_to tasks_path, notice: "不正なアクセスです。"
      end
    end
end 

