class UserEntityController < ApplicationController
  def new
    @user_entity = UserEntity.new
    @master_entity = MasterEntity.all
    @user = User.all
  end

  def create
    user_entity = params[:"user_entity_id"].split(",")
   user_entity.each do |entity|
     @user_entity = UserEntity.where(:id => entity).all
     @user_entity.each do |entities_us|
       @user_entity = UserEntity.create
       @user_entity.update_attributes(:user_id =>params[:user_id], :user_category_id =>params[:user_category_id]  ,:is_active => "1",:entity_image => entities_us.entity_image, :entity_name => entities_us.entity_name,:information=>entities_us.information, :lat=> entities_us.lat, :longitude => entities_us.longitude )
       @user_entity.save
      end
      end
     respond_to do |format|
        format.json {render :json => {:message => "Add User Entity Successfully"}}
   end
  end

  def save_media
    cat = {}
    en = {}
    @entitys = Array.new
    @cat = Array.new
    category = params[:master_category_id].split(",")
    respond_to do |format|
    @master_category_check = category.collect { |f| MasterCategory.where(:id  => f).first}.compact
    @master_category_check.each do |master_category_check|
    if params[:api_id].nil?
       @user_categories = UserCategory.where(:user_id => params[:user_id], :master_category_id => params[:master_category_id]).first
       if @user_categories.present?
         @user_entities = UserEntity.where(:user_id => @user_categories.user_id, :user_category_id => @user_categories.id)
         if @user_entities.present?
          @post_create = Post.create
          if params[:post_image]
              post_image = (params[:post_image]).gsub(" ", "+")
              @post_image = StringIO.new(Base64.decode64(post_image))
              @post_image.class.class_eval { attr_accessor :original_filename, :content_type }
              @post_image.original_filename = "post_image.jpg"
              @post_image.content_type = "image/jpg"
          end
          @post_create.update_attributes(:user_entity_id => @user_entities.id, :comment_text => params[:comment_text],:user_id => params[:post][:user_id],:is_public => "1", :all_tag => "ok", :all_user_name_tag => ".........OK",:is_new_comment => "1",:is_active => "1" , :post_image => @post_image)
          @post_create.save
          format.json {render :json => @post_create}
         else
            @user_entities_create = UserEntity.create
            @user_entities_create.update_attributes(:user_id =>@user_categories.user_id, :user_category_id => @user_categories.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
            @user_entities_create.save
            format.json {render :json => @user_entities_create}
         end
       else
         @user_category_create = UserCategory.create
         @user_category_create.update_attributes(:user_id => params[:user_id],:master_category_id => params[:master_category_id], :is_active => "1")
         @user_category_create.save
         @user_entity_create = UserEntity.create
         @user_entity_create.update_attributes(:user_id =>@user_category.user_id, :user_category_id => @user_category.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
         @user_entity_create.save
         ct = cat.merge(:user_id =>@user_entity_create.user_id, :user_category_id => @user_entity_create.id,:entity_name => @user_entity_create.entity_name,:address => @user_entity_create.entity_name,:lat => @user_entity_create.lat, :longitude => @user_entity_create.longitude,:sub_category => @user_entity_create.sub_category,:entity_image => @entity_image, :is_active => "1",:comment => @user_entity_create.comment,:rating_count => @user_entity_create.rating_count,:is_public => "1")
         @cat << ct
      end
    else
      @user_category = UserCategory.where(:master_category_id => master_category_check.id, :user_id => params[:user_id]).first# ,:user_id =>params[:user_id])
      if @user_category.present?
        @api_entity = UserEntity.where(:api_id => params[:api_id], :user_id => params[:user_id])
         if @api_entity.present?
           @api_entity.each do |en|
             puts":::::::::::::::::::::::::::::::::::::::::::#{en.inspect}"
         @post_create = Post.create
          if params[:entity_image]
              post_image = (params[:entity_image]).gsub(" ", "+")
              @post_image = StringIO.new(Base64.decode64(post_image))
              @post_image.class.class_eval { attr_accessor :original_filename, :content_type }
              @post_image.original_filename = "post_image.jpg"
              @post_image.content_type = "image/jpg"
          end
         @post_create.update_attributes(:user_entity_id =>en.id, :comment_text => params[:comment_text],:user_id => params[:user_id],:is_public => "1", :all_tag => "ok", :all_user_name_tag => ".........OK",:is_new_comment => "1",:is_active => "1" , :post_image => @post_image)
         @post_create.save
           end
         format.json {render :json =>@post_create }
        else
          @api_entity_create = UserEntity.create
          if params[:entity_image]
              entity_image = (params[:entity_image]).gsub(" ", "+")
              @entity_image = StringIO.new(Base64.decode64(entity_image))
              @entity_image.class.class_eval { attr_accessor :original_filename, :content_type }
              @entity_image.original_filename = "entity_image.jpg"
              @entity_image.content_type = "image/jpg"
          end
         @api_entity_create.update_attributes(:api_id => params[:api_id],:user_id =>@user_category.user_id, :user_category_id => @user_category.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
         @api_entity_create.save
         format.json {render :json => @api_entity_create}
       end
     else
      @user_category_create = UserCategory.create
      @user_category_create.update_attributes(:user_id => params[:user_id],:master_category_id => params[:master_category_id], :is_active => "1")
      @user_category_create.save
      @user_entity_create = UserEntity.create
      @user_entity_create.update_attributes(:api_id => params[:api_id],:user_id =>@user_category.user_id, :user_category_id => @user_category.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
      @user_entity_create.save
      enti = en.merge(:user_id =>@user_entity_create.user_id, :user_category_id => @user_entity_create.id,:entity_name => @user_entity_create.entity_name,:address => @user_entity_create.entity_name,:lat => @user_entity_create.lat, :longitude => @user_entity_create.longitude,:sub_category => @user_entity_create.sub_category,:entity_image => @entity_image, :is_active => "1",:comment => @user_entity_create.comment,:rating_count => @user_entity_create.rating_count,:is_public => "1")
      @entitys << enti
            format.json {render :json => @entitys}
      end
          format.json {render :json => @cat}
     end
   end
  end
 end

  def show
      @id = params[:id]
      @master_entity = MasterEntity.find(@id)
  end

  def entity_list
    @entity_list = UserEntity.where(:user_id => params[:entity][:user_id]).first
    respond_to do |format|
      format.json {render :json => @entity_list}
    end
  end


 def get_entity_by_category_id
   @entity = Array.new
    entity = {}
   @user_categ = UserCategory.where(:master_category_id => params[:master_category_id])
   @user_categ.each do |cat|
    @get_entity = UserEntity.where(:user_category_id => cat.id)
   @get_entity.each do |entities|
     @user = User.where(:id => entities.user_id)
     @user.each do |user|
       en = entity.merge(:master_category_id=>params[:master_category_id],:user_category_id => entities.user_category_id, :entity_name=> entities.entity_name, :address => entities.address,:entity_id => entities.id,:entity_image => entities.entity_image, :user_id => entities.user_id, :user_name => user.first_name, :user_profile_picture => user.profile_picture)
   @entity << en
   end
   end
   end
   respond_to do |format|
     if @entity.empty?
       format.json {render :json =>{:message => "This category does't have any entity"}}
     else
       format.json {render :json => @entity}
     end
     
   end

 end

 def get_entity_by_user_id_cat_id
     user_entity = {}
     @entity = Array.new
  respond_to do |format|
   @get_entity_user =  UserEntity.where(:user_category_id => params[:user_category_id], :user_id => params[:user_id])  #
   @get_entity_user.each do |entity|
     @user = User.where(:id => entity.user_id)
      @user.each do |user|
       us = user_entity.merge(:user_id => user.id, :profile_picture => user.profile_picture,:user_name => user.first_name, :user_category_id =>entity.user_category_id, :entity_name => entity.entity_name,:entity_image => entity.entity_image, :entity_id =>entity.id )
       @entity << us
       end
 end

     format.json {render :json => @entity}
   end
 end
  def get_entity_by_user_id_cat_ids
     user_entity = {}
     @entity = Array.new
      @get_entity_user =  UserEntity.where(:user_id => params[:user_id],:user_category_id => params[:user_category_id]).all
      @get_entity_user.each do |i|             
        ch = user_entity.merge(:user_entity_id => i.id, :created_at => i.created_at, :updated_at => i.updated_at, :user_id => i.user_id,:user_category_id => i.user_category_id)
        @master_entity = MasterEntity.where(:id => i.master_entity_id).all
        @master_entity.each do |image|        
        pb = ch.merge(:entity_name =>image.entity_name,:entity_image => image.entity_image)
        @user = User.where(:id => i.user_id).first
        user = pb.merge(:profile_picture => @user.profile_picture, :name => @user.first_name)
        @entity << user
      end
    end
    respond_to do |format|
      format.json {render :json=> @entity }
    end
 end
#
#     def entity_info
#     @entity_user =  UserEntity.where(:id => params[:user_entity_id])
#      respond_to do |format|
#        format.json {render :json=> @entity_user }
#      end
#   end
  def entity_info
    @comments = Array.new
    coome = {}
    en_po = {}
    @en_po = Array.new
    user_entity = {}
     @entity_info = Array.new
     @entity_user =  UserEntity.where(:id => params[:user_entity_id], :user_id => params[:user_id]).first
     @comment = Comment.where(:user_entity_id => @entity_user.id)
     @comment.each do |comm|
       coomes = coome.merge(:comment_text => comm.comment_text)
       @ratings = Rating.where(:comment_id =>  comm.id )
       @ratings.each do |ratings|
          coomes = coomes.merge(:rating_count => ratings.rating_count)
       end
      @user = User.where(:id => comm.self_user_id)
      @user.each do |user|
        coomes = coomes.merge(:user_name => user.first_name,:profile_picture => user.profile_picture)
        @comments << coomes
      end
    end
   ch = user_entity.merge(:user_entity_id => @entity_user.id, :user_id => @entity_user.user_id,:user_entity_name => @entity_user.entity_name,:user_entity_image => @entity_user.entity_image,:latitute => @entity_user.lat, :longitude => @entity_user.longitude, :information => @entity_user.information, :address => @entity_user.address, :comment =>@comments)
   @entity_info << ch
   post_info = {}
   @post_info = Array.new
   @entity_post = Post.where(:user_entity_id => @entity_user.id)
   @entity_post.each do |post|
      @comments_post = Comment.where(:post_id => post.id)
      @comments_post.each do |post_comments|
         post_info_comment = post_info.merge(:comment_text => post_comments.comment_text)
         @rating_post = Rating.where(:comment_id => post_comments.id)
         @rating_post.each do |rat_post|
            post_info_comment = post_info_comment.merge(:rating_count => rat_post.rating_count)
         end
         @comment_user = User.where(:id =>post_comments.self_user_id )
         @comment_user.each do |user|
            post_info_comment = post_info_comment.merge(:user_name => user.first_name,:profile_picture => user.profile_picture)
            @post_info << post_info_comment
         end
      end
      post_en = en_po.merge(:user_entity_id => post.user_entity_id, :user_id => post.user_id,:user_entity_name => @entity_user.entity_name,:post_image => post.post_image,:latitute => post.lat, :longitude => post.longitude, :address => @entity_user.address, :comment => @post_info)
      @en_po << post_en
   end
      respond_to do |format|
        format.json {render :json=> {:entity_info => @entity_info , :post_info => @en_po}}
      end
end

  def welike
  @welike = Array.new
  weliike ={}
    @user_relations = UserCategoryRelation.where(:user_id => params[:user_id], :user_category_id => params[:user_category_id])
    @user_relations.each do |user_relation|
            @user_entity = UserEntity.where(:user_category_id => user_relation.user_category_id)
        @user_entity.each do |user_entity|
          @user = User.in(:id => [params[:user_id], user_relation.friend_user_id]).all
          @user.each do |user|
          we = weliike.merge(:user_id => user.id,:user_name => user.first_name, :entity_address => user_entity.address, :profile_picture => user.profile_picture, :master_category_id => params[:master_category_id], :entity_name => user_entity.entity_name, :entity_image => user_entity.entity_image, :rating_count => user_entity.rating_count, :entity_id =>user_entity.id)
          @welike << we
          end
      end
     end
    respond_to do |format|
      format.json {render :json => @welike}
    end
  end

  
end
