class UserController < ApplicationController
  def new
    @user = User.new
    render :layout => "user"
  end

  def create
    @user = User.new(params[:user])
    @user.terms == "0"
    respond_to do |format|
      if @user.save
        format.html {redirect_to root_url}
        flash[:notice] = "Successfully Registerd..."
        format.json {render :json => @user}
      end
    end
  end

 
end
