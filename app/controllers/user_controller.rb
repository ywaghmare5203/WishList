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

def change_password
 @user_password = User.find_by_id(params[:change])
    user = User.authenticate_password(@user_password.email, params[:password][:password])
      if user.present?
         user.update_attributes(params[:password])
      if user.save
        redirect_to edit_profile_path(user.id)
        flash[:notice] = "Password change successfully"
      end
    else
      redirect_to edit_profile_path(@user_password.id)
        flash[:notice] = "Password do not match"
      end
  end


def de_activate_user_account
  puts"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{params.inspect}"
  @deactivate = User.find_by_id(params[:deactivate])
  if @deactivate.present?
    @deactivate.destroy
   # session[:user_id].destroy
    redirect_to root_path
    flash[:notice] = "Successfully De-activate Your Account"
  else
    redirect_to edit_profile_path(@deactivate.id)
    flash[:notice] = "Error During De-activate your account"
  end
end

end
