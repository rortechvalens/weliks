class UserCategoryController < ApplicationController

  def create  #<......comment-----the create method use for create the users category....
   cs=  params[:user_category][:master_category_id].split(",")
    category = {}
    @category = Array.new
    respond_to do |format|
      cs.each do |i|
       @master_category = MasterCategory.where(:id => i)
       @master_category.each do |master_cate|
         @user_category = UserCategory.new  #.<comment.........create the user category the UserCategory model contain master_category_id, user_id etc
      @user_category.update_attributes(:master_category_id => i ,:user_id =>params[:user_category][:user_id], :is_active => "1")
      @user_category.save
      cate = category.merge(:user_category_name => master_cate.category_name, :user_category_image => master_cate.category_image, :master_category_id => @user_category.master_category_id ,:user_category_id => @user_category.id,:user_id =>@user_category.user_id, :is_active => @user_category.is_active)
      @category << cate
      end
      end
    format.json {render :json=> @category }
    end
  end
   
  def get_friend
    user_c = {}
    @category_friends = Array.new
   @user_category = UserCategory.where(:master_category_id => params[:category][:master_category_id])
   @user_category.each do |user|
   @users = User.where(:id => user.user_id).all
   @users.each do |image|
   # ch =  user.merge(:first_name => image.first_name,:user_id => image.id, :profile_picture =>image.profile_picture)
   ch = user_c.merge(:first_name => image.first_name,:user_id => image.id, :profile_picture =>image.profile_picture)
   @category_friends << user << ch
  end
  end
   respond_to do |format|
    format.json {render :json => @category_friends }
    end
 end


  def aggrigrator
    category_user = {}
    respond_to do |format|
        @aggrigrator_screen = Array.new
        @aggrigrator = UserCategory.where(:user_id => params[:category][:user_id])
        @aggrigrator.each do |category|
          @master_category = MasterCategory.where(:id => category.master_category_id)
          @master_category.each do |master_category|
            cat = category_user.merge(:user_id => category.user_id, :user_categy_name => master_category.category_name, :user_category_image => master_category.category_image, :user_category_id => category.id, :master_category_id => master_category.id )
             @aggrigrator_screen << cat
        end
         end
              format.json {render :json => @aggrigrator_screen}
        end
     end

  
  def all_category
    @master = Array.new
    master_category = {}
    @all_category = MasterCategory.all
     respond_to do |format|
    @all_category.each do |cat|
       @user_cat = UserCategory.where(:user_id => params[:user_id],:master_category_id => cat.id).all
       if (@user_cat.empty?)
         master_entity = master_category.merge(:master_category_id => cat.id, :status => "NO", :master_category_name => cat.category_name, :master_category_image => cat.category_image)
         @master << master_entity
       else
         @user_cat.each do |user_cat|
         user_entity = master_category.merge(:master_category_id => cat.id, :status => "YES" , :master_category_name => cat.category_name, :master_category_image => cat.category_image, :user_category_id => user_cat.id)
         @master << user_entity
        end
       end
    end
      format.json {render :json => @master}
    end
end


















end
