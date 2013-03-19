class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Hierarchy


  
  has_many :user_categories
  has_many :user_category_relation
  has_many :user_entities
  has_many :ratings
  has_many :comments
#  has_many :relationshipss

#  has_many :posts
  

  attr_accessor :password
  before_save :encrypt_password
  has_mongoid_attached_file :profile_picture, :default_url => '/images/missing.jpg'
  has_mongoid_attached_file :cover_photo, :default_url => '/images/missing.jpg'
   validates_uniqueness_of :email,  :message => "Email Already Exists"

    field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  field :name, :type => String
  field :phone, :type => String
  field :fb_token, :type => String
  field :provider, :type => String
  field :profile_picture, :type => String
  field :cover_photo, :type => String
  field :is_suggessted, :type => Boolean
  field :facebook_id, :type => String
  field :bio, :type => String
  field :city, :type => String
  field :country, :type => String
  field :currunt_lat, :type => String
  field :current_long, :type => String
  field :gender, :type => String
  field :birthday, :type => Time
  field :website, :type => String
  field :mobile_no, :type => String
  field :twitter_id,:type => String
  field :is_active, :type => Boolean
  field :registration_id, :type => String
  field :last_login_time, :type => Time
  field :created_time, :type => Time
  field :deleted_time, :type => Time
  field :password_salt, :type => String
  field :password_hash, :type => String
  field :screen_name, :type => String
  field :privacy, :type => Boolean
  field :friend_like_my_activity_for_pn, :type => Boolean
  field :friend_like_my_activity_for_mail, :type => Boolean
  field :any_one_like_my_activity_for_pn, :type => Boolean
  field :any_one_like_my_activity_for_mail, :type => Boolean
  field :friend_mention_me_in_comment_for_pn, :type => Boolean
  field :friend_mention_me_in_comment_for_mail, :type => Boolean
  field :any_one_mention_me_in_comment_for_pn, :type => Boolean
  field :any_one_mention_me_in_comment_for_mail, :type => Boolean
  field :a_friend_follow_my_category_for_pn, :type => Boolean
  field :a_friend_follow_my_category_for_mail, :type => Boolean
  field :any_one_friend_follow_my_category_for_pn, :type => Boolean
  field :any_one_friend_follow_my_category_for_mail, :type => Boolean
  field :a_friend_shares_a_place_tip_or_entity_with_me_for_pn, :type => Boolean
  field :a_friend_shares_a_place_tip_or_entity_with_me_for_mail, :type => Boolean
  field :any_one_shares_a_place_tip_or_entity_with_me_for_pn, :type => Boolean
  field :any_one_shares_a_place_tip_or_entity_with_me_for_mail, :type => Boolean
  field :i_receive_a_friend_request_of_friend_confirmation_for_pn, :type => Boolean
  field :i_receive_a_friend_request_of_friend_confirmation_for_mail, :type => Boolean
  field :a_new_friend_from_facebook_join_we_like_for_pn, :type => Boolean
  field :keep_me_up_to_date_with_welike_news_and_update_for_pn, :type => Boolean
  field :keep_me_up_to_date_with_welike_news_and_update_for_mail, :type => Boolean
  field :send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn, :type => Boolean
  field :send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail, :type => Boolean
  field :save_photo_phone, :type =>Boolean
  field :geotag_post, :type => Boolean
  field :post_are_private,:type => Boolean

  def encrypt_password
    if password.present?
     self.password_salt = BCrypt::Engine.generate_salt
     self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    end
  end
   def self.authenticate(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
   end

   def self.authenticate_password(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
   end

end

 #
 