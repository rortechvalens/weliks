class UserEntitiesController < ApplicationController

def save_media
   respond_to do |format|
    midea = {}
    @media = Array.new
    if params[:is_user_category] == "0" && params[:api_id] == "0"
      @user_category = UserCategory.create
      @user_entity_create = UserEntity.create
      @user_category.update_attributes(:user_id => params[:user_id],:master_category_id => params[:master_category_id], :is_active => "1")
      @user_entity_create.update_attributes( :is_user_category=> params[:is_user_category], :user_id => @user_category.user_id, :user_category_id => @user_category.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
      @user_category.save
      @user_entity_create.save
      md = midea.merge(:is_user_category=> params[:is_user_category], :user_id => @user_category.user_id, :user_category_id => @user_category.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
      @media << md
      format.json {render :json => @media}
    elsif params[:is_user_category]== "0" && params[:api_id] != "0"
      @user_category_check = UserCategory.where(:user_id => params[:user_id], :master_category_id => params[:master_category_id])
      if @user_category_check.present?
        @user_entity_is_entity = UserEntity.create
          if params[:entity_image]
              entity_image = (params[:entity_image]).gsub(" ", "+")
              @entity_image = StringIO.new(Base64.decode64(entity_image))
              @entity_image.class.class_eval { attr_accessor :original_filename, :content_type }
              @entity_image.original_filename = "entity_image.jpg"
              @entity_image.content_type = "image/jpg"
          end
          @user_entity_is_entity.update_attributes( :api_id => params[:api_id], :user_id => params[:user_id], :user_category_id => params[:user_category_id],:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
          @user_entity_is_entity.save
      else
        @user_category_is_category = UserCategory.create
        @user_category_is_category.update_attributes( :user_id => params[:user_id],:master_category_id => params[:master_category_id], :is_active => "1")
        @user_category_is_category.save
        @user_entity_is_entity = UserEntity.create
          if params[:entity_image]
              entity_image = (params[:entity_image]).gsub(" ", "+")
              @entity_image = StringIO.new(Base64.decode64(entity_image))
              @entity_image.class.class_eval { attr_accessor :original_filename, :content_type }
              @entity_image.original_filename = "entity_image.jpg"
              @entity_image.content_type = "image/jpg"
          end
          @user_entity_is_entity.update_attributes( :api_id => params[:api_id], :user_id => @user_category_is_category.user_id, :user_category_id => params[:user_category_id],:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
          @user_entity_is_entity.save
      end
     
      format.json {render :json => @user_entity_is_entity}
      elsif params[:is_user_category]== "1" && params[:api_id] != "0"
        @user_cat = UserCategory.where(:user_id => params[:user_id], :master_category_id => params[:master_category_id]).first
        @user_entity = UserEntity.where(:user_category_id => params[:user_category_id],:user_id => params[:user_id]).first
        puts"///////////////////////////////////////outside#{@user_entity.inspect}"
      if @user_entity.present?
          puts"..............................@user_entity"
          @post = Post.where(:user_entity_id => @user_entity.id)
          if @post.present?
            @comment = Comment.create
            @rating = Rating.create
            @comment.update_attributes(:post_id => @post.id,:user_entity_id =>"0", :comment_text => params[:comment_text],:user_id => @post.user_id,:is_public => "1", :all_tag => "ok", :all_user_name_tag => ".........OK",:is_new_comment => "1",:is_active => "1" )
            @rating.update_attributes(:user_id => @post.user_id,:post_id => @post.id, :rating_count => params[:rating_count])
            @comment.save
            @rating.save
            format.json {render :json => @comment}
          else
             @post_media = Post.create
            if params[:post_image]
              post_image = (params[:post_image]).gsub(" ", "+")
              @post_image = StringIO.new(Base64.decode64(post_image))
              @post_image.class.class_eval { attr_accessor :original_filename, :content_type }
              @post_image.original_filename = "post_image.jpg"
              @post_image.content_type = "image/jpg"
             end
             @post_media.update_attributes(:user_id => @user_entity.id,:user_entity_id => @user_entity.id,:lat => params[:lat], :longitude => params[:longitude],:post_video => params[:post_video],:pin_url => params[:pin_url],:is_public => "1", :post_comment => params[:post_comment],:post_image => @post_image,:is_active => "1")
            @post_media.save
            format.json {render :json => @post_media}
          end
        else
          @user_entity_created = UserEntity.create
          @user_entity_created.update_attributes(:user_id => params[:user_id], :user_category_id => params[:user_category_id],:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
          @user_entity_created.save
          format.json {render :json => @user_entity_created}
        end
    end
   end
end

  def get_entity_by_user_id_cat_id
      @get_entity_user =  UserEntity.where(:user_id => params[:user_id],:user_category_id => params[:user_category_id]).all
      respond_to do |format|
      format.json {render :json=> @get_entity_user }
    end
  end

   def entity_info
     @entity_user =  UserEntity.where(:id => params[:user_entity_id]).first
      respond_to do |format|
        format.json {render :json=> @entity_user }
      end
   end

    def suggested_entity
      @cat = {}
      @cati = Array.new
      @user_category_check = UserCategory.where(:user_id => params[:user_id], :master_category_id => params[:master_category_id]).first
     respond_to do |format|
      if @user_category_check.present?
        @user_entity_suggested = UserEntity.create
        if params[:entity_image]
              entity_image_suggested = (params[:entity_image]).gsub(" ", "+")
              @entity_image_suggested = StringIO.new(Base64.decode64(entity_image_suggested))
              @entity_image_suggested.class.class_eval { attr_accessor :original_filename, :content_type }
              @entity_image_suggested.original_filename = "entity_image.jpg"
              @entity_image_suggested.content_type = "image/jpg"
             # @user_entity_suggested.entity_image = @entity_image_suggested
        end
        @user_entity_suggested.update_attributes(:information => params[:information],:user_id => params[:user_id], :user_category_id => @user_category_check.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1", :entity_image => @entity_image_suggested)
        @user_entity_suggested.save
        cl = @cat.merge(:entity_image =>@user_entity_suggested.entity_image ,:master_category_id => params[:master_category_id],:information =>@user_entity_suggested.information,:user_id => params[:user_id], :user_category_id => @user_category_check.id,:entity_name => @user_entity_suggested.entity_name,:address => @user_entity_suggested.address,:lat => @user_entity_suggested.lat, :longitude => @user_entity_suggested.longitude,:sub_category => params[:sub_category], :is_active => "1",:comment => @user_entity_suggested.comment,:rating_count => @user_entity_suggested.rating_count,:is_public => "1")
        @cati << cl
          format.json {render :json => @cati }
      else
        sugg= {}
        @sugg = Array.new
        @user_category = UserCategory.create
        @user_category.update_attributes(:user_id => params[:user_id],:master_category_id => params[:master_category_id], :is_active => "1")
        if @user_category.save
           @user_entity_suggested = UserEntity.create
           if params[:entity_image]
              entity_image_suggested = (params[:entity_image]).gsub(" ", "+")
              @entity_image_suggested = StringIO.new(Base64.decode64(entity_image_suggested))
              @entity_image_suggested.class.class_eval { attr_accessor :original_filename, :content_type }
              @entity_image_suggested.original_filename = "entity_image.jpg"
              @entity_image_suggested.content_type = "image/jpg"
           end
         @user_entity_suggested.update_attributes(:information => params[:information],:user_id => params[:user_id], :user_category_id => @user_category.id,:entity_name => params[:entity_name],:address => params[:address],:lat => params[:lat], :longitude => params[:longitude],:sub_category => params[:sub_category],:entity_image => @entity_image_suggested, :is_active => "1",:comment => params[:comment],:rating_count => params[:rating_count],:is_public => "1")
         @user_entity_suggested.save
         su = sugg.merge(:user_id => @user_category.user_id, :user_category_id => @user_category.id, :entity_image => @user_entity_suggested.entity_image,:entity_name => @user_entity_suggested.entity_name,:longitude => @user_entity_suggested.longitude, :lat => @user_entity_suggested.lat, :address => @user_entity_suggested.address, :rating_count =>@user_entity_suggested.rating_count, :comment => @user_entity_suggested.comment,:information => @user_entity_suggested.information)
        @sugg << su
        format.json {render :json => @sugg}
          end

        end
     end
       
      end

    end

 

#
