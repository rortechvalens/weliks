class Rating
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post
  belongs_to :user_entities
  
  field :user_id, :type => String
  field :self_user_id, :type => String
  field :post_id, :type => String
  field :user_entity_id => String
  field :rating_count, :type => Integer
  field :comment_id, :type => String

end
