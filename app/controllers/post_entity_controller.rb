class PostEntityController < ApplicationController
   # Controller & Method Name : MasterEntity Controller entity_by_char Method
  # Summary : This method is Used to List all Master Entities by three characters givan by Device.
  # Status : Active
  # Parameters : entity[master_entity_char]= characters by which entity name will be searched.
  # Output : Master Eitities List
def entity_search
 @entity = MasterEntity.where(:entity_name => /.*#{params[:entity][:char]}*./).all
    respond_to do |format|
      if @entity.present?
        format.json {render :json => @entity}
      else
        
      end
  end
end

def post_create
  @master_entity = MasterEntity.where(:id => params[:mster_entity_id])
 x = (params[:post][:post_comment])
 y = x.excludes("@")
  @post = Post.new(params[:post])
   post_images = (params[:post_image]).gsub(" ", "+")
    if params[:post_image]
      data = StringIO.new(Base64.decode64(post_images))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "post_image.jpg"
      data.content_type = "image/jpg"
      @post.post_image = data
    end
    @array = Array.new
  respond_to do |format|
    if @post.save
    if params[:post][:post_comment].include? "@"
      @tag = Tag.new
        @tag.post_id = @post.id
        ch = x.each do |i|
        @tag.tag_name = x[/[@].+?[" "]/]
        end
        @tag.save
    end
    format.json {render :json => {:message => "You have successfully posted"}}
    else
      format.json {render :json => {:errors => "Some errors during Post"}}
    end
  end
end

def post_comment
    @id = params[:post_id]
    @posts = Post.find(@id)
    ch = "Melanie is a noob".scan(/a/)
    puts"...............................>#{ch.inspect}"
    if @post.present?
      @comment = Comment.new(params[:comment])
      respond_to do |format|
        if @comment.save
          format.json {render :json => {:message => "You have successfully Commented"}}
        else
          format.json {render :json => {:errors => "Some error during commenting"}}
        end
      end
    end
end

end
