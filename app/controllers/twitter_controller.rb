class TwitterController < ApplicationController
  def create  # <..........Comment.....the create method create user using Twitter account.
     if params[:user][:provider]
        @authhash = Hash.new #<..........Comment..... {"name" => '', "screen_name" => '', "twitter_id" =>'',  "provider" =>''} create hash for contain value in same formate
        @authhash[:provider] = params[:user][:provider] or ''
          if params[:user][:provider] == 'twitter'
            @authhash[:name] =  params[:user][:name] or ''
            @authhash[:screen_name] =  params[:user][:screen_name] or ''
           @authhash[:twitter_id] =  params[:user][:twitter_id].to_s or ''
            @authhash[:fb_token] = params[:user][:fb_token] or nil
          end

          if @authhash[:twitter_id] != '' and @authhash[:provider] != ''
            @auth_service = User.where(:twitter_id => @authhash[:twitter_id]).first
            pics = (params[:user][:profile_picture]).gsub(" ", "+")
            if  params[:user][:profile_picture] # <..........Comment..... user have profile picture the responce form the user side is base64 format using this method we convert base64 string into image.
            @data = StringIO.new(Base64.decode64(pics))
            @data.class.class_eval { attr_accessor :original_filename, :content_type }
            @data.original_filename = "#{@auth_service.screen_name}.jpg"
            @data.content_type = "image/jpg"
            end
                respond_to do |format|
                  if @auth_service.present? # <..........Comment.....if user is already registerd then the user profile update only.
                    @auth_service.update_attributes(:last_login_time => Time.now,:screen_name => @authhash[:screen_name],:profile_picture => @data,:name => @authhash[:name],:twitter_id=>@authhash[:twitter_id],:provider=>@authhash[:provider])
                    format.json {render  :json => @auth_service}
                  else
                    @user = User.create # <..........Comment.....if user does not exist then we will create the user.
                    @user.update_attributes(:last_login_time => Time.now,:screen_name => @authhash[:screen_name],:profile_picture => @data,:name => @authhash[:name],:twitter_id=>@authhash[:twitter_id],:provider=>@authhash[:provider])
                    @user.save!
                    format.json {render :json => @user}
                   end
               end
       end


    end
end

end
