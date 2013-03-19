class MessageDetail
  include Mongoid::Document
  include Mongoid::Timestamps
  field :message_id, :type => Integer
  field :receiver_id, :type => Integer
  field :receiver_text, :type => String
  field :read_status, :type => Boolean
  field :delete_status, :type => Boolean
end
