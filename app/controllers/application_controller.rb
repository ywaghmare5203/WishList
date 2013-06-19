class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  helper_method :current_user

def set_locale
      I18n.locale = params[:locale] ||  I18n.default_locale
      if session[:user_id].present?
         @userlanguage = User.find_by_id(session[:user_id])
         if @userlanguage.present?
           I18n.locale = params[:locale] || @userlanguage.locale ||  I18n.default_locale
         if params[:locale] and @userlanguage
            @userlanguage.locale=params[:locale]
            @userlanguage.save
         end
         end
       
      end
end

  def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end

	def signed_in?
		!!current_user
	end

	def current_user=(user)
		@current_user = user
		session[:user_id] = user.nil? ? user : user.id
	end

  def logged_in?
    return (session[:user_id].to_i > 0)
  end
end
