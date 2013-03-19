class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :tag_name, :type => String
  field :comment_id, :type => Integer
  field :post_id, :type => Integer
end
#curl -X GET http://localhost:3000/user_category/all_category.json