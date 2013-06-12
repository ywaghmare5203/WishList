class SignUpController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
    #  UserMailer.welcome_email(@user).deliver
      redirect_to login_path
    else
      render "new"
    end
  end
end
