class UserEntity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip


  has_mongoid_attached_file :entity_image

  belongs_to :user
  has_many :comments
  has_many :posts
  has_many :ratings

  field :api_id, :type => String
  field :user_category_id, :type => String
  field :entity_name, :type => String
  field :information, :type => String
  field :user_id, :type => String
  field :address, :type => String
  field :lat, :type => String
  field :longitude, :type => String
  field :sub_category, :type => String
  field :entity_image, :type => String
  field :is_active, :type => Boolean
  field :comment, :type => String
  field :rating_count, :type => String
  field :is_public, :type => Boolean
end
