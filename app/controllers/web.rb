
1# Sign-up by Eamil

##    curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[user_name]=yogesh.waghmare&user[email]=yogesh.waghmare@techvalens.com&user[password]=12345&user[website]=www.google.com&profile_picture=&cover_photo=&user[privacy]=0" http://localhost:3000/user/create.json


2##  login with facebook
#  curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogeshwaghmare0gmail.com&user[fb_token]=AAABiLW4ZCpgEBAMGzZAVYKR1EZCI0IEliM6iQblRZBnDEx22ngIhRQSi5IRAy4ZAZBIoLYeCaTJSALXfES3jZAZAmracO978hsAicsXvSRk9nQZDZD&user[facebook_id]=100000716266389&user[gender]=male&user[provider]=facebook&user[name]=YogeshWaghmare" http://localhost:3000/facebook/create.json


3#  login with twitter

#  curl -X POST -d "user[twitter_id]=100001112611740&user[provider]=twitter&user[screen_name]=ywaghmare5203&user[name]=Yogesh Waghmare" http://localhost:3000/twitter/create.json

 4#  lgoin with email
# curl -X POST -d "login[email]=yogesh480@gmail.com&login[password]=12345" http://localhost:3000/login/create.json

5# update password

#####    curl -X POST -d "email=yogesh.waghmare@techvalens.com&password=12345&change[password]=yogesh" http://localhost:3000/user/change_password.json
6 # for facebook friend count

## curl -X POST -d "friends_id="558682946,751223367,1068275487,100001776478329,"&provider=facebook&facebook_id=100000056252703&" http://localhost:3000/facebook/facebook_friend_counts.json

7#update user with user id

#curl -X POST -d "user_id=51222d11236f17800a000001&user[first_name]=Yogesh&user[bio]=Waghmare&user[email]=yogesh480@gmail.com&user[phone]=8109481001&user[gender]=male&user[birthday]=24-08-1985&user[save_photo_phone]=&user[geotag_post]=&user[post_are_private]=&profile_picture=&cover_photo="  http://localhost:3000/user/update.json

8# Upadet user notifictions
#
# curl -X POST -d "user_id=5121d24d236f170886000002&user[friend_like_my_activity_for_pn]=&user[friend_like_my_activity_for_mail]=&user[any_one_like_my_activity_for_pn]=&user[any_one_like_my_activity_for_mail]=&user[friend_mention_me_in_comment_for_pn]=&user[friend_mention_me_in_comment_for_mail]=&user[any_one_mention_me_in_comment_for_pn]=&user[any_one_mention_me_in_comment_for_mail]=&user[a_friend_follow_my_category_for_pn]=&user[a_friend_follow_my_category_for_mail]=&user[any_one_friend_follow_my_category_for_pn]=&user[any_one_friend_follow_my_category_for_mail]=&user[a_friend_shares_a_place_tip_or_entity_with_me_for_pn]=&user[a_friend_shares_a_place_tip_or_entity_with_me_for_mail]=&user[any_one_shares_a_place_tip_or_entity_with_me_for_pn]=&user[any_one_shares_a_place_tip_or_entity_with_me_for_mail]=&user[i_receive_a_friend_request_of_friend_confirmation_for_pn]=&user[i_receive_a_friend_request_of_friend_confirmation_for_mail]=&user[a_new_friend_from_facebook_join_we_like_for_pn]=&user[fkeep_me_up_to_date_with_welike_news_and_update_for_pn]=&user[keep_me_up_to_date_with_welike_news_and_update_for_mail]=&user[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_pn]=&user[send_me_weekly_updates_about_whats_my_friends_are_up_to_for_mail]=" http://localhost:3000/user/update_notifications.json
##  


9#for add friend facebook
#
#  curl -X POST -d "friends[friends_id]=&friends[provider]=facebook&friends[facebook_id]=100001112611740&" http://localhost:3000/friends/create.json
#
#
10#Add freind form email
#curl -X POST -d "friends[email]=yogesh@gmail.com&friends[provider]=email&friends[friends_email]="ashvin@gmail.com,deepak@gmail.com"&" http://localhost:3000/friends/email_friends.json

11# All Categories

##      curl -X GET  http://localhost:3000/category/category_list.json

12# get all entity by category id
#curl -X GET  "entity[master_category_id]=510646adf7e4f33e2c000005" http://localhost:3000/master_entity/master_entity_list.json


13# Add Category by User Id

##  curl -X POST -d "user_category[master_category_id]=5130ad0df7e4f30efe000001,5130b527f7e4f34f9d000001&user_category[user_id]=51318e38f7e4f32854000003" http://localhost:3000/user_category/create.json

14# Add entity by user_id And user_Category_id

##   curl -X POST -d "entity[user_id]=510f5cd5f7e4f33070000026&entity[user_category_id]=510f638df7e4f33070000029&entity[master_entity_id]="510a772af7e4f3488c000001,510a77b3f7e4f3488c000002,510a7858f7e4f3488c000003"" http://localhost:3000/user_entity/create.json

15#  get friends by category id
## curl -X POST -d "category[master_category_id]=510646adf7e4f33e2c000005&category[user_id]=511255a7f7e4f39ab3000023" http://localhost:3000/user_category/get_friend.json


16# arrigrator Screem

#curl -X GET -d "category[user_id]=511251f8f7e4f39ab3000008" http://localhost:3000/user_category/aggrigrator.json


17# add_friend_by_category_id

#### curl -X POST -d "category_friends[user_id]=category_friends[friend_user_id]=&category_friends[user_category_id]=" http://localhost:3000/friends/category_friends.json


# add_friend_by_category_id

## curl -X POST -d "friend[user_id]=511251f8f7e4f39ab3000008&friend[user_category_id]=5112529bf7e4f39ab3000010" http://localhost:3000/user_category/add_friend_by_category_id.json

18# get entity by user_id  ---I LIKE


# curl -X POST -d "user_id=51134f8af7e4f352c7000020&user_category_id=511351dff7e4f352c7000023" http://localhost:3000/user_entity/get_entity_by_user_id_cat_id.json


19# get entity details

##   curl -X POST -d "user_id=51134f8af7e4f352c7000020&user_entity_id=511356d4f7e4f352c7000029" http://localhost:3000/user_entity/entity_info.json


20# post_comment

## curl -X POST -d "comment[post_id]=&comment[comment_text]=&comment[user_id]=&user[is_public]=&comment[all_tag]=&comment[all_user_name_tag]=" http://localhost:3000/comment/post_comment.json
  #post tag

##  curl -X POST -d "tag[comment_id]=&tag[tag_name]=&tag[post_id]=" http://localhost:3000/tag/post_tag.json

21## all category by user_id
#curl -X POST -d "user_id=51134f8af7e4f352c7000020" http://localhost:3000/user_category/all_category.json



22#save media

#  curl -X POST -d "category=5130ad0df7e4f30efe000001&entity_name=Yogesh&information=&comment=&address=1224&lat=22.12548&longitude=72.12489&master_category_id=510646adf7e4f33e2c000005&entity_image=&user_id=51134f8af7e4f352c7000020&user_category_id=511351dff7e4f352c7000024&user_id=513459a9f7e4f330e900006d" http://localhost:3000/user_entity/save_media.json


23# welike

## curl -X GET -d "user_entity[user_id]=51134f8af7e4f352c7000020&user_entity[master_cat_id]=51064670f7e4f33e2c000003" http://localhost:3000/user_entity/welike.json



#curl -X POST -d "user_id=51160e28f7e4f35e27000010&user_entity_id=51160e32f7e4f35e27000017" http://localhost:3000/user_entity/entity_info.json


24# get all friends for sign up

##      curl -X POST -d "user_id=51189602f7e4f3602f000010" http://localhost:3000/friends/all_friends.json

25#   for search master category

###   curl -X POST -d "entity[char]=a" http://localhost:3000/post_entity/entity_search.json


26## for post_ entity

######    curl -X POST -d "post[user_id]=&post[user_entity_id]=&post[lat]=&post[longitude]=&post[post_video]=&post[pin_url]=&post[is_public]=&post[post_comment]=&post[post_image]=&post[is_active]=" http://localhost:3000/post_entity/post_create.json

27#### post comment

##    curl -X POST -d "post_id=5118e7e6f7e4f3899a00004c&comment[comment_text]=xyz&comment[user_id]=123&comment[all_tag]=&comment[all_user_name_tag]=&comment[is_new_comment]=&comment[is_active]=1#"

