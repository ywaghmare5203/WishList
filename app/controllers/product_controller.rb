class ProductController < ApplicationController
  def new
  end

  def create
    @product_order = Product.last
    @user = User.find(params[:user_id])
    @products = Product.create
    @products.update_attributes(params[:upload])
    @products.user_id = params[:user_id]
     if @products.save
       params[:image].each do |images|
         photos = @products.photos.build(:photos => images , :product_id =>@products.id , :user_id => @products.id)
           photos.save
           end
     end
    redirect_to welcome_path(session[:user_id])
  end

  def sendlist
    @userss = Array.new
    userss = {}
    @user = User.find(params[:id])
    @product_list = Product.find_by_user_id(@user.id)
      us = userss.merge(:first_name => @user.first_name, :last_name => @user.last_name, :user_id => @user.id, :product_name => @product_list.name, :product_id => @product_list.id, :email => params[:sender][:email], :product_image => @product_list.photos)
      @userss << us
    ListMailer.share_list_email(us).deliver #proper name conventions
    flash[:notice] = "Email is succesfully send"
    respond_to do |format|
      format.html { redirect_to welcome_path(@user.id)}
      format.json { head :no_content }
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @product_edit = @user.products.find(params[:id])
    @edit_photo = Photo.find_all_by_product_id(params[:id])
    render :layout => "user"
  end

  def update
    @product_edit = Product.find_by_id(params[:update])
    @product_edit.update_attributes(params[:product])
    @photo = Photo.find_by_product_id(params[:update])
    if @photo.present?
      @photo.destroy
    end
     if @product_edit.save
       params[:image].each do |images|
         photos = @product_edit.photos.build(:photos => images , :product_id =>@product_edit.id ,:user_id => @product_edit.user_id)
         photos.save
       end
      redirect_to welcome_path(session[:user_id])
     else
       render "edit"
    end
   end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to welcome_path(session[:user_id])}
      format.json { head :no_content }
    end
  end

def product_profile
    @friends_product = Product.find_all_by_user_id(params[:id])
  end

  def product_friend_profile
    @friends_prod_profile = Product.find_by_id(params[:id])
    @user_name = User.find_by_id(@friends_prod_profile.user_id)
    @photo_friend = Photo.find_all_by_product_id(@friends_prod_profile.id)
  end

end
