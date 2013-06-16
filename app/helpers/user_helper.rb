module UserHelper
  def getUserNamebyId(uid)
     @user = User.find(uid)
    @user.first_name
  end

  def getUserLastNamebyId(uid)
     @user = User.find(uid)
    @user.last_name
  end
end
