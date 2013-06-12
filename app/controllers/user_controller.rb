class UserController < ApplicationController
  def new
    @user = User.new
    render :layout => "user"
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html {redirect_to :action => "index", :controller => "home"}
        flash[:notice] = "Successfully Registerd..."
        format.json {render :json => @user}
      end
    end
  end

  def login_create
    
  end
end
