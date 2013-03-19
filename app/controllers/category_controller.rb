class CategoryController < ApplicationController
  respond_to :html , :json, :xml

  # Controller & Method Name : Category controller Create method
  # Summary : This method was used to add master category in database.
  # Status :  NOT IN USED (Master Categories Added database Manually )
  def create
   @category = MasterCategory.new
   @category.category_name = params[:category][:category_name]
   @category.category_image = params[:category][:category_image]
   @category.is_active = "1"
#    data = StringIO.new(Base64.decode64(params[:category][:category_image]))
#    data.class.class_eval { attr_accessor :original_filename, :content_type }
#    data.original_filename = "category_image.jpg"
#    data.content_type = "image/jpg"
#    @category.category_image = data
#    @category.category_name = params[:category][:category_name]

    if @category.save
      redirect_to category_list_path
      flash[:notice] = "Category add Successfully"
    else
      render "new"
    end
  end
  # Controller & Method Name : Category controller category_list method
  # Summary : This method is used to list all  master categories exist in weliike database.
  # Status :  Active.
  # Parameters : Not Used
  # Output : List of Master Categories in json
  # Sample Output {"_id":"51064648f7e4f33e2c000001","category_image":"/system/master_categories/category_images/5106/4648/f7e4/f33e/2c00/0001/original/Book_Stack_Icon.jpg?1359365704","category_image_content_type":"image/jpeg","category_image_file_name":"Book_Stack_Icon.jpg","category_image_file_size":112491,"category_image_updated_at":"2013-01-28T09:35:04+00:00","category_name":"Books","created_at":null,"created_time":null,"entity_name_obligatory":null,"is_active":null,"modified_time":null,"updated_at":null,"user_id":null},
  def category_list
    puts".............................>>>>#{params.inspect}"
    @category_list = MasterCategory.all
    puts".............................>>>>#{@category_list.inspect}"
    respond_to do |format|
      format.json {render :json => @category_list}
    end
  end
end
