class MessageReceiver
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message_id, :type=>String
  field :sender_id, :type=>String
  field :user_id, :type=>String
  field :read_status, :type=> Boolean
  field :is_active, :type=> Boolean
end
