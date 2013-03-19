## Sign up With Email

## curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogesh480@gmail.com&user[password]=12345&user[profile_picture]=" http://localhost:3000/user/create.json

#login with facebook
#    curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogeshwaghmare0gmail.com&&user[facebook_id]=100000716266389&user[gender]=male&user[provider]=facebook&user[name]=YogeshWaghmare" http://localhost:3000/facebook/create.json


## Get entity_vy category_id

## curl -X POST -d "master_category_id=5121d8d7236f175488000001"  http://localhost:3000/user_entity/get_entity_by_category_id.json


#for Category list

#    curl -X GET  http://localhost:3000/category/category_list.json


# get all entity by category id
#curl -X GET  "entity[master_category_id]=510646adf7e4f33e2c000005" http://localhost:3000/master_entity/master_entity_list.json


### For suggested_entity

#curl -X POST -d "user_id=5126079d236f17c4bc000014&master_category_id=5125fdec236f17c4bc000001&entity_name=Surya Hotel&address=M.G. Road Indore&lat=20.3436&longitude=78.25424&sub_category=&entity_image=&comment=nice one&rating_count=4&information=" http://localhost:3000/user_entities/suggested_entity.json


## For I Like

# curl -X POST -d "user_id=5126079d236f17c4bc000014&user_category_id=5126110e236f17c4bc000018" http://localhost:3080/user_entities/get_entity_by_user_id_cat_id.json

## get entity info

# curl -X POST -d "user_id=5126079d236f17c4bc000014&user_entity_id=51266846236f17605f000011" http://localhost:3080/user_entities/entity_info.json

## followings

## curl -X POST -d "user_id=512e2424236f17169700003c&user_category_id=512e2428236f17169700003d" http://localhost:3000/friends/following.json


## followers

#

# post comment----

 ## curl -X POST -d "comment_text=This is Nice for all Users&user_id=513471b2f7e4f330e9000097&user_entity_id=513b0785f7e4f35187000018&rating_count=5&self_user_id=513471b2f7e4f330e9000097" http://localhost:3000/comment/entity_comment.json


# entity comment

## curl -X POST -d "post_id=513dab7ff7e4f3b1dd000003&comment_text=This is Nice for all Users&user_id=513471b2f7e4f330e9000097&user_entity_id=513b0785f7e4f35187000018&rating_count=5&self_user_id=513471b2f7e4f330e9000097" http://localhost:3000/comment/post_comment.json

# entity_info

## curl -X POST -d "user_id=513471b2f7e4f330e9000097&user_entity_id=513b0785f7e4f35187000018" http://localhost:3000/user_entity/entity_info.json


#email friends

## curl -X POST -d "friends[email]=yogesh@gmail.com&friends[provider]=email&friends[friends_email]="ashvin@gmail.com,deepak@gmail.com"&" http://localhost:3000/friends/email_friends.json

# create group
# curl -X POST -d "group_name=Hi Hello&group_owner_id=514063a6f7e4f34bd1000031&status=1&is_active=1&member_user_id=514062b4f7e4f34bd1000030,51405518f7e4f34bd100002f&notification=1&group_image=" http://localhost:3000/group/group_create.json 


# edit group
# curl -X POST -d "group_id=514195cdf7e4f31bea000005&group_name=UP&member_id=514062b4f7e4f34bd1000030&group_name=Hi Hello&group_owner_id=&notification=1&group_image=" http://localhost:3000/group/edit_group.json


# group details
# curl -X POST -d "group_id=5141a08ff7e4f31bea000045" http://localhost:3000/group/group_details.json


# get group by owner_id


