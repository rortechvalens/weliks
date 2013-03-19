class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

   has_mongoid_attached_file :post_image

  belongs_to :user
  belongs_to :user_entities
  has_many :comments 
  has_many :ratings
  
  

  field :user_id, :type => String
  field :user_entity_id, :type => String
  field :lat, :type => String
  field :longitude, :type => String
  field :post_video, :type => String
  field :pin_url, :type => String
  field :is_public, :type => Boolean
  field :post_comment, :type => String
  field :post_image, :type => String
  field :is_active, :type => Boolean


end
