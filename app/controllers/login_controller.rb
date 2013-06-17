class LoginController < ApplicationController
  def new
    render :layout => "application"
  end

  def create
    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user
      if user.terms == "0"
       session[:user_id] = user.id
       @users = user.update_attributes(:terms => "1")
       @users.save
        redirect_to terms_path(session[:user_id])
      else
         session[:user_id] = user.id
         redirect_to :action => "welcome", :controller => "login", :id => user.id
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def profile
    @users = User.find(params[:id])
    render :layout => "user"
  end

  def edit_profile
    @edit_profile = User.find(params[:id])
    render :layout => "user"
    puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#{@edit_profile.inspect}"
  end


  def welcome
     @user = User.find(params[:id])
     @product = Product.new
     @products = Product.where(:user_id=>params[:id])
     @pro_order = @products.find(:all , :order => "order_id")
     @friends = []
        if session['fb_token'] != nil then
            fb_friends = ActiveSupport::JSON.decode(open(URI.encode("https://graph.facebook.com/me/friends?access_token=#{session['fb_token']}")))['data']
            @friends = fb_friends.collect { |f| User.find_by_provider_and_facebook_id('facebook', f['id']) }.compact
        end

    @wishlist_friend = User.where(:all, :conditions => { :id =>  :id != params[:id] })
      respond_to do |format|
      	format.html {render :layout => "user"}
        format.json { render :json => [@user, @friends] }
      end
  end

  def user_wish
      @user = User.find_by_id(session[:user_id])
      @product = Product.find(params[:id])
      @photos = Photo.find_all_by_product_id(params[:id])
  end

  def terms
      
  end

  def terms_and_condition
    puts"params...............................................3#{params.inspect}"
    if params[:users][:id]
      @trems = User.find_by_id(params[:users][:id])
      @trems.update_attributes(params[:users])
      @trems.save

      redirect_to welcome_path(session[:user_id])
    end
  end


end
