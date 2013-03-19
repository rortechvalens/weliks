class FriendsController < ApplicationController
  # Controller & Method Name : Friends  Controller create method
  # Summary : This method used to Add friend by facebook_id. This method also create Relationship between user & Friends via user_id & feiends_id and status.
  # Status : Active.
  # Parameters :friends[friends_id] = User Id of User table , friends[provider] = facebook , friends[facebook_id] =  facebook_ids comma saperated
  # Output : Add Your Friens
  def create #<---------comment----create method use for find friend by facebook_id........
    respond_to do |format|
    if params[:friends][:provider]== "facebook"
      friends = params[:friends][:friends_id].split(",")
        @user = User.where(:facebook_id => params[:friends][:facbook_id_id] ).first
        @friends = friends.collect { |f| User.where(:provider => 'facebook',:facebook_id => f).first }.compact
        @friends.each do |i|
            @friend = Relatoinship.new #.......create the relation between two users relesionship model contain user_id, friends_id, status.
            @friend.user_id = @user.id
            @friend.friend_user_id = i.id
            @friend.status = "follow"
            @friend.save
        end
      format.json {render :json => @friend, :status => "Add Your Friens"}
    end
    end
  end

    # Controller & Method Name : Friends  Controller create method
    # Summary : This method used to Add friend by email_friends. This method also create Relationship between user & Friends via user_id & feiends_id and status.
    # Status : Active.
    # Parameters : friends[email] = User Email  of User table , friends[provider] = email , friends[friends_email] = List of Email ids comma saperated.
    # Output : Add Your Friens in json
    def email_friends  #<---------comment----email_friends method use for find friend by email........
     respond_to do |format|
    if params[:friends][:provider] == "email"
      email_friend = params[:friends][:friends_email].split(",")
      @user = User.where(:email => params[:friends][:email] ).first
      @friends_email = email_friend.collect { |f| User.where(:provider => 'email',:email => f).first }.compact
      @friends_email.each do |i|
            @email_friend = Relatoinship.new #.......create the relation between two users relesionship model contain user_id, friends_id, status.
            @email_friend.update_attributes(:friend_user_id => i.id,:user_id => @user.id,:status => "1",:is_active => "1")
            if @email_friend.save
               format.json {render :json => {:status => "Add Your Friens"} }
            else
              format.json {render :json => @email_friend.errors }
            end
     
    end
    end
end
end

    # Controller & Method Name : Friends  Controller category_friends method
    # Summary : This method used to follow Master categories automatically when user add friend by email_id.
    # Status : Active.
    # Parameters : friends[email] = User Email  of User table , friends[provider] = email , friends[friends_email] = List of Email ids comma saperated.
    # Output :  Add Friend Successfully in json
    def category_friends
      user_cat = params[:user_category_id].split(",")
      respond_to do |format|
         user_cat.each do |cat|
           @category_friends = UserCategoryRelation.create
           @category_friends.update_attributes(:is_active => "1", :friend_user_id => params[:friend_user_id],:user_id => params[:user_id],:user_category_id => cat)
           if @category_friends.save
            
             format.json {render :json => {:message => "Add Friend Successfully"}}
           else
             format.json {render :json => @category_friends.errors}
           end
         end
          @user_relation = Relatoinship.create
           @user_relation.update_attributes(:status => "1", :is_active => "1",:user_id =>  params[:user_id], :friend_user_id => params[:friend_user_id] )
           if @user_relation.save
             format.json {render :json => {:message => "Add Friend Successfully"}}
           else
             format.json {render :json => @user_relation.errors}
             
           end
         
      end
    end


    def all_friends
      @users = Array.new
      user_friends = {}
      @user = User.excludes(:id => params[:user_id])
      @user.each do |user|
        puts"::::::::::::::::::::::USER:::::::::::::::::::::#{user.inspect}"
        users = user_friends.merge(:user_id => user.id, :profile_picture => user.profile_picture, :first_name => user.first_name)
        @users << users
      end
      respond_to do |format|
        format.json {render :json => @users}
      end
    end

    def following
       @followors = Array.new
      @followor = UserCategoryRelation.where(:user_id => params[:user_id], :user_category_id => params[:user_category_id])
      @followor.each do |follo|
        @followors << follo
         UserMailer.welcome_email(@followors).deliver
      end
      respond_to do |format|
        format.json {render :json => @followors.count}
      end
  end


     def friend_clouds
    @followors = Array.new
      @followor = UserCategoryRelation.where(:user_id => params[:user_id]).uniq {|p| p.user_id}
      @followor.each do |follo|
         @cm = follo
     end
   @friend_clouds = Array.new
   friend = {}
   @cd = Array.new
   user_cat = (params[:user_category_list]).split(",")
   user_cat.each do |cat|
     @user_cat = UserCategory.where(:id => cat)
     @user_cat.each do |us_ct|
       @cd << us_ct.master_category_id
     end
   end
    @cd.each do |mac|
      @user_category = UserCategory.where(:master_category_id => mac)#.excludes(:user_id =>params[:user_id])#.uniq {|p| p.user_id}
      @user_category.each do |category|
        @user_cat_relation = UserCategoryRelation.where(:user_category_id => category.id).excludes(:user_id =>@cm.friend_user_id).uniq {|p| p.user_id}
        @user_cat_relation.each do |relation|
          @user_entitiess = UserEntity.where(:user_category_id => relation.user_category_id)
          @users = User.where(:id => relation.user_id)
          @users.each do |user|
          fr = friend.merge(:user_category_id =>  relation.user_category_id,:user_name => user.first_name,:user_id => user.id, :profile_picture => user.profile_picture, :entity_count => @user_entitiess.count)
          @friend_clouds << fr
          end
        end
        end
     end
     respond_to do |format|
       format.json {render :json => @friend_clouds}
     end
     end

  def  following_data
     @cm = Array.new
    follow = {}
    @followors = Array.new
      @followor = UserCategoryRelation.where(:user_id => params[:user_id],:user_category_id => params[:user_category_id])
      @followor.each do |follo|
          @cm << follo.friend_user_id 
         # @cm.push(params[:user_id])
         @user_entity = UserEntity.where(:user_id => follo.user_id, :user_category_id => params[:user_category_id])
        @users = User.where(:id => follo.friend_user_id )
        @users.each do |users|
          fl = follow.merge(:user_name => users.first_name,:user_id => users.id, :profile_picture => users.profile_picture, :entity_count => @user_entity.count, :status => "YES")
      @followors << fl
        end
      end

#       @cm.push(params[:user_id])
#       @cm.each do |cm|
#      puts"::::::::::::::::::::::::::::::::::DSSSSSSSSSSSSSSSSS::::::::::::::::::#{cm.inspect}"
#      @friends_rels = Relatoinship.excludes(:user_id => cm).uniq {|p| p.friend_user_id}
#       end
#      @friends_rels.each do |rels|
#        puts"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#{rels.inspect}"
#        @user_category = UserCategory.where(:master_category_id => params[:master_category_id]).in(:user_id => [rels.user_id , rels.friend_user_id] )
#      end
#       @user_category.each do |cat_user|
#
#         @user_cat_relations = UserCategoryRelation.where(:user_category_id => cat_user.id)
#
#       @user_cat_relations.each do |ect_rel|
#
#           @user_entity_count = UserEntity.where(:user_category_id =>  ect_rel.user_id)#.uniq {|p| p.user_id}
#           @users = User.where(:id => ect_rel.user_id).uniq {|p| p.id}
#           @users.each do |users|
#
#             fl = follow.merge(:user_name => users.first_name,:user_id => users.id, :profile_picture => users.profile_picture, :entity_count => @user_entity.count, :status => "NO")
#             @followors << fl
#           end
##
##         end
##       end
#      end
      # end
#      @user_category = UserCategory.excludes(:user_id =>cm).where(:master_category_id => params[:master_category_id])# [cm.user_id,cm.friend_user_id]).uniq {|p| p.user_id}
#      @user_category.each do |category|
#        @suggested = UserCategoryRelation.where(:user_category_id => category.id).excludes(:user_id =>cm, :friend_user_id=>cm).uniq {|p| p.user_id && p.friend_user_id}
#       @suggested.each do |suggest|
#         @user_enti = UserEntity.where(:user_category_id => suggest.user_category_id)
#         @user = User.where(:id => suggest.user_id ).uniq {|p| p.user_id}
#        @user.each do |users|
#          fl = follow.merge(:user_name => users.first_name,:user_id => users.id, :profile_picture => users.profile_picture, :entity_count => @user_entity.count, :status => "NO")
#      @followors << fl
   

#

         respond_to do |format|
        format.json {render :json => @followors}
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
         user_entity = master_category.merge(:master_category_id => cat.id, :status => "YES" , :master_category_name => cat.category_name, :master_category_image => cat.category_image)
         @master << user_entity
        end
    end
      format.json {render :json => @master}
    end
 end

    def followers
       @followors = Array.new
        user_cate = UserCategory.where(:master_category_id => params[:master_category_id])
        user_cate.each do |us|
          @followings = UserCategoryRelation.where(:friend_user_id => params[:user_id], :user_category_id => us.id)
          @followings.each do |follow|
             @followors << follow
          end
        end
      respond_to do |format|
        format.json {render :json => @followors.count}
      end
    end


   def followers_data
       @followors = Array.new
       follows = {}
        user_cate = UserCategory.where(:master_category_id => params[:master_category_id])
        user_cate.each do |us|
          @followings = UserCategoryRelation.where(:friend_user_id => params[:user_id], :user_category_id => us.id)
          @followings.each do |follow|
            @user_entity = UserEntity.where(:user_category_id => follow.user_category_id)
           @users = User.where(:id => follow.user_id ).first
               fl = follows.merge(:user_name => @users.first_name,:user_id => @users.id, :profile_picture => @users.profile_picture, :entity_count => @user_entity.count)
             @followors << fl
          end
        end
      respond_to do |format|
        format.json {render :json => @followors}
      end
    end

 def traids
  @traids = Array.new
  weliike ={}
  user_category = UserCategory.where(:master_category_id => params[:master_category_id])
  user_category.each do |category|
    @user_relations = UserCategoryRelation.where(:user_category_id => category.id)
    @user_relations.each do |user_relation|
      @user_entity = UserEntity.where(:user_category_id => user_relation.user_category_id)
        @user_entity.each do |user_entity|
          @user = User.where(:id => user_entity.user_id)
          @user.each do |user|
          we = weliike.merge(:user_id => user.id,:user_name => user.first_name, :entity_address => user_entity.address, :profile_picture => user.profile_picture, :master_category_id => params[:master_category_id], :entity_name => user_entity.entity_name, :entity_image => user_entity.entity_image, :rating_count => user_entity.rating_count)
          @traids << we
          end
        end
 end
  end
    respond_to do |format|
      format.json {render :json => @traids}
    end
  end

 def all_friend_for_welike
   @friend = Array.new
   friend = {}
   @user_category = UserCategory.where(:master_category_id => params[:master_category_id])
   @user_category.each do |category|
  @friend_relation = UserCategoryRelation.where(:friend_user_id => params[:user_id], :user_category_id => category.id)
  @friend_relation.each do |relation|
    @friend_entity = UserEntity.where(:user_category_id => relation.user_category_id)
    @friend_entity.each do |entity|
      @users = User.where(:id => entity.user_id).all
      @users.each do |user|
        fr = friend.merge(:user_id => user.id,:user_name => user.first_name, :entity_address => entity.address, :profile_picture => user.profile_picture, :master_category_id => params[:master_category_id], :entity_name => entity.entity_name, :entity_image => entity.entity_image, :rating_count => entity.rating_count)
        @friend << fr
       end
    end
    end
  end
   respond_to do |format|
     format.json {render :json => @friend}
   end
 end

 def group_friend
   use = {}
   @user = Array.new
   @friends1 = Relatoinship.where(:user_id => params[:user_id])
   @friends1.each do |f|
     @users = User.where(:id => f.friend_user_id)
     @users.each do |users|
       us = use.merge(:user_id => users.id, :user_name => users.first_name, :profile_picture => users.profile_picture)
       @user << us
     end
   end
     respond_to do |format|
      if @user.present?
        format.json {render :json => @user}
      else
        format.json {render :json => {:message => "There is no friend"}}
      end
    end
end





end

