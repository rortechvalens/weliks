class UserCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :master_category

  
  field :user_id, :type=> String
  field :master_category_id, :type => String
  field :is_active, :type => Boolean
end
