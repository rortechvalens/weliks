class MasterEntity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip


  has_mongoid_attached_file :entity_image

  belongs_to :master_category
  has_many :user_entities


  field :master_category_id, :type => String
  field :entity_name, :type => String
  field :information, :type => String
  field :address,:type => String
  field :sub_category, :type => String
  field :lat, :type => String
  field :longitude, :type => String
  field :entity_image, :type => String
  field :is_active, :type => Boolean



#curl -X POST -d "entity[entity_name]=&entity[:master_category_id]=510646adf7e4f33e2c000005=510f5d16f7e4f33070000028" http://localhost:3000/user_category/create.json

  
end
