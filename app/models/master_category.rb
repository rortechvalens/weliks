class MasterCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  #has_many :master_categories , :dependent => :destroy
  has_many :user_categories , :dependent => :destroy
  belongs_to :user


  has_mongoid_attached_file :category_image

  field :category_name, :type => String
  field :category_image, :type => String
  field :entity_name_obligatory, :type => Boolean
  field :is_active, :type => Boolean

end
