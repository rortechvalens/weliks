class FacebookController < ApplicationController

  # Controller & Method Name : Facebook  Controller create method
  # Summary : This method is used to create(Register/login) welike user via facebook A/c.
  # If user not exist in weliike then it will register automatically else its record updated according to latest facebook details.
  # Status : Active.
  # Parameters : user[first_name]= First Name , user[last_name]=Last Name , user[email]= User Email , user[fb_token]= Facebook token, user[facebook_id] = Facebook Id , user[gender] = Gender , user[provider] = facebook , user[name] = Full Name
  # Output : Details of Registered user.
  def create 
    if params[:user][:provider]
        @authhash = Hash.new #<..........Comment..... {"email" => '', "name" => '', "uid" =>'',  "provider" =>''} create hash for contain value in same formate
        @authhash[:provider] = params[:user][:provider] or ''
          if params[:user][:provider] == 'facebook'
            @authhash[:email] = params[:user][:email] or ''
            @authhash[:name] =  params[:user][:name] or ''
            @authhash[:first_name] =  params[:user][:first_name] or ''
            @authhash[:last_name] =  params[:user][:last_name] or ''
            @authhash[:gender] =  params[:user][:gender] or ''
            @authhash[:facebook_id] =  params[:user][:facebook_id].to_s or ''
          end
        if @authhash[:facebook_id] != '' and @authhash[:provider] != ''
            @auth_service = User.where(:facebook_id => @authhash[:facebook_id]).first
           
            if  params[:user][:profile_picture] # <..........Comment..... user have profile picture the responce form the user side is base64 format using this method we convert base64 string into image.
             pics = (params[:user][:profile_picture]).gsub(" ", "+")
            @data = StringIO.new(Base64.decode64(pics))
            @data.class.class_eval { attr_accessor :original_filename, :content_type }
            @data.original_filename = "#{@auth_service.first_name}.jpg"
            @data.content_type = "image/jpg"
             end
                respond_to do |format|
                  if @auth_service.present? # <..........Comment.....if user is already registerd then the user profile update only.
                     @auth_service.update_attributes(:profile_picture => @data,:email=>@authhash[:email],:name => @authhash[:name],:first_name => @authhash[:first_name],:last_name => @authhash[:last_name],:facebook_id=>@authhash[:facebook_id],:provider=>@authhash[:provider], :gender => @authhash[:gender], :last_login_time => Time.now)
                    format.json {render :json => @auth_service}
                  else
                    @user = User.create # <..........Comment.....if user does not exist then we will create the user.
                    @user.update_attributes(:profile_picture => @data,:email=>@authhash[:email],:name => @authhash[:name],:first_name => @authhash[:first_name],:last_name => @authhash[:last_name],:facebook_id=>@authhash[:facebook_id],:provider=>@authhash[:provider], :gender => @authhash[:gender],:last_login_time => Time.now)
                    @user.save
                    format.json {render :json => @user}
                     end
               end
         end
      end
   end

 def facebook_friend_counts
    respond_to do |format|
    if params[:provider]== "facebook"
      friends = params[:friends_id].split(",")
      puts"........................................#{friends.inspect}"
        @user = User.where(:facebook_id => params[:facebook_id] ).first
        @friends = friends.collect { |f| User.where(:provider => 'facebook',:facebook_id => f).first }.compact
        format.json {render :json => @friends}
    end
  end
 end
end

#curl -X POST -d "friends_id="558682946,751223367,1068275487,100001776478329,"&provider=facebook&facebook_id=100000056252703&" http://localhost:3000/facebook/facebook_friend_counts.json