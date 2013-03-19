class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post
  belongs_to :user_entities

  field :post_id, :type=> String

  field :comment_text, :type=> String
  field :user_id, :type=> String
  field :self_user_id, :type=> String
  field :is_public, :type =>  Boolean
  field :all_tag, :type=> String
  field :all_user_name_tag, :type=> String
  field :is_new_comment, :type =>  Boolean
  field :is_active, :type =>  Boolean
  field :user_entity_id , :type => String

end

