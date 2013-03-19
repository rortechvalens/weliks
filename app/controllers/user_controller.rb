class UserController < ApplicationController

  def create #<-----comment-----create method use for create new user account or sign up with emailid
     @user = User.new(params[:user])
    if params[:cover_photo]
     cover_photo = (params[:cover_photo]).gsub(" ", "+")
      data = StringIO.new(Base64.decode64(cover_photo))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "#{@user.first_name}.jpg"
      data.content_type = "image/jpg"
      @user.cover_photo = data
    end
    if params[:profile_picture]  # <..........Comment..... user have profile picture the responce form the user side is base64 format using this method we convert base64 string into image.
      @prof_pic=(params[:profile_picture]).gsub(" ", "+")
      data = StringIO.new(Base64.decode64(@prof_pic))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "#{@user.first_name}.jpg"
      data.content_type = "image/jpg"
      @user.profile_picture = data
      @user.provider = "email"
   end

      @user.privacy = "0"
      @user.friend_like_my_activity_for_pn = "1"
      @user.friend_like_my_activity_for_mail = "0"
      @user.any_one_like_my_activity_for_pn = "1"
      @user.any_one_like_my_activity_for_mail = "0"
      @user.friend_mention_me_in_comment_for_pn = "1"
      @user.friend_mention_me_in_comment_for_mail = "1"
      @user.any_one_mention_me_in_comment_for_pn = "1"
      @user.any_one_mention_me_in_comment_for_mail = "1"
      @user.a_friend_follow_my_category_for_pn ="1"
      @user.a_friend_follow_my_category_for_mail = "0"
      @user.any_one_friend_follow_my_category_for_pn = "1"
      @user.any_one_friend_follow_my_category_for_mail = "0"
      @user.a_friend_shares_a_place_tip_or_entity_with_me_for_pn = "1"
      @user.a_friend_shares_a_place_tip_or_entity_with_me_for_mail = "0"
      @user.any_one_shares_a_place_tip_or_entity_with_me_for_pn = "1"
      @user.any_one_shares_a_place_tip_or_entity_with_me_for_mail = "1"
      @user.i_receive_a_friend_request_of_friend_confirmation_for_pn = "1"
      @user.i_receive_a_friend_request_of_friend_confirmation_for_mail = "1"
      @user.a_new_friend_from_facebook_join_we_like_for_pn = "1"
      @user.keep_me_up_to_date_with_welike_news_and_update_for_pn = "0"
      @user.keep_me_up_to_date_with_welike_news_and_update_for_mail ="1"
      @user.send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn = "0"
      @user.send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail = "1"
      @user.save_photo_phone = "1"
      @user.geotag_post ="1"
      @user.post_are_private = "0"
   
    ## notification.save
      respond_to do |format|
    if @user.save

#        d = APN::Device.create(:udid => "1a2b3c4d")
#   a = APN::Application.create(:name => "welike")
#   s = d.subscriptions.create(:application => a, :token => "15dee137 86c5d1a2 cd5b919e 383bb69c 803e933a a12164a5 820302f7 daf4797a")
#   n = APN::Notification.new
#  # n.device = d
#   n.alert = "G'day from APN on Mongoid"
#   n.sound = "default"
#   n.badge = 1337
   #n.deliver
   
#      device = APN::Device.create(:token => "15dee137 86c5d1a2 cd5b919e 383bb69c 803e933a a12164a5 820302f7 daf4797a")
#     notification = APN::Notification.new
#    # notification.device = device
#     notification.badge = 5
#     notification.sound = true
#     notification.alert = "My first push"

      format.json {render :json => @user}
    else
      format.json {render :json => @user.errors}
     end

    end
  end

  def update
    @user = User.where(:id => params[:user][:user_id]).first
    @user.update_attributes(params[:user])
     if params[:cover_photo]
      cover_photo = (params[:cover_photo]).gsub(" ", "+")
      data = StringIO.new(Base64.decode64(cover_photo))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "cover photo.jpg"
      data.content_type = "image/jpg"
      @user.cover_photo = data
    end
    if params[:profile_picture]
      pic = (params[:profile_picture]).gsub(" ", "+")
      data = StringIO.new(Base64.decode64(pic))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "profile photo.jpg"
      data.content_type = "image/jpg"
      @user.profile_picture = data
    end
    respond_to do |format|
    if @user.save
      format.json {render :json => @user}
    else
      format.json {render :json => @user.errors}
    end
    end
  end

  
  def update_notifications
    @user = User.where(:id => params[:user][:user_id]).first
    @user.update_attributes(params[:user])
    respond_to do |format|
    if @user.save
      format.json {render :json => @user}
    else
      format.json {render :json => @user.errors}
    end
    end
  end
  def change_password
    user = User.authenticate_password(params[:email], params[:password])
    respond_to do |format|
      if user.present?
       user.update_attributes(params[:change])
      if user.save
        
        format.json {render :json => {:message => "Your Password is successfully Updated"}}
      end
    else
      format.json {render :json => {:message => "Your Password does not match"}}
      end
    end
  end



 
end
#curl -X POST -d "email=yogesh.waghmare@techvalens.com&password=12345" http://localhost:3000/user/change_password.json