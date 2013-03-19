class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :message_image,:default =>'public/images/missing.jpg'

  field :parent_message_id, :type => String
  field :receiver_type, :type => String
  field :receiver_id, :type => String
  field :message_text, :type => String
  field :message_image, :type => String
  field :owner_id, :type => String
  field :sender_id, :type => String
  field :is_active,:type=>Boolean
end
