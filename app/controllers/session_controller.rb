class SessionController < ApplicationController

    def create
    auth = request.env['omniauth.auth']
      if auth and params[:provider]
       @authhash = Hash.new # {"email" => '', "name" => '', "uid" =>'',  "provider" =>''}
        @authhash[:provider] = auth['provider'] or ''
          if params[:provider] == 'facebook'
            @authhash[:email] = auth['extra']['raw_info']['email'] or ''
            @authhash[:first_name] =  auth['extra']['raw_info']['first_name'] or ''
            @authhash[:name] =  auth['extra']['raw_info']['namek'] or ''
            @authhash[:last_name] = auth['extra']['raw_info']['last_name'] or ''
            @authhash[:gender] = auth['extra']['raw_info']['gender'] or ''
            @authhash[:facebook_id] =  auth['extra']['raw_info']['id'].to_s or ''
            @authhash[:fb_token] = auth['credentials']['token'] or nil
          elsif ['google'].index(params[:provider]) != nil
            @authhash[:email] =  auth['info']['email'] or ''
            @authhash[:name] = auth['info']['name'] or ''
            @authhash[:uid] = auth['uid'].to_s or ''
          else
         # TODO: message that it is not supported
          render root_url
          return
          end
          if @authhash[:facebook_id] != '' and @authhash[:provider] != ''
            @auth_service = User.find_by_facebook_id(@authhash[:facebook_id])
            if @auth_service.present?
              @auth_service.update_attributes(:name => @authhash[:name],:email=>@authhash[:email],:first_name=>@authhash[:first_name],:last_name=>@authhash[:last_name],:fb_token=>@authhash[:fb_token],:facebook_id=>@authhash[:facebook_id],:provider=>@authhash[:provider])
              current_user = @auth_service.id
               session[:user_id] = current_user
              redirect_to welcome_path(@auth_service.id)
            else
              @user = User.create
              #@users.first_name = @authhash[:first_name]
              @user.update_attributes(:name => @authhash[:name],:first_name => @authhash[:first_name], :last_name => @authhash[:last_name], :email => @authhash[:email], :fb_token => @authhash[:fb_token], :provider => @authhash[:provider], :facebook_id => @authhash[:facebook_id], :gender => @authhash[:gender])
              if @user.save!
                session[:facebook_id] = @authhash[:facebook_id]
                session[:user_id] = @user.id
                redirect_to terms_path(session[:user_id])
              else
                redirect_to root_url
             
              end
            end
               @authhash[:fb_token] && session[:fb_token] = @authhash[:fb_token]
            end
          end

    end

    def signout
    #logger.debug "token:", session[:fb_token]
    if session[:fb_token]
      #TODO: ask a user if he wants to logout from fb as well?
      url = "https://www.facebook.com/logout.php?access_token=" + session[:fb_token] + "&next=" + root_url
      reset_session
     # logger.debug url
      redirect_to url
    else
      #url = "https://mail.google.com/mail/u/0/?logout&hl=en&continue=" + root_url
      url = "https://www.google.com/accounts/logout?continue=" + root_url
      reset_session
      redirect_to url
    end
  end
private
  def reset_session
    self.current_user = nil
    session[:fb_token] = nil
  end
  

end
