module ApplicationHelper

    def getUserNamebyId(uid)
     @user = User.find(uid)
    @user.name
  end
end
