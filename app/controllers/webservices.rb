

1 # sign-up with email

#   curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogesh480@gmail.com&user[password]=12345&user[profile_picture]=" http://localhost:3000/user/create.json



2 #for Category list

#    curl -X GET  http://localhost:3000/category/category_list.json

# get all entity by category id
#curl -X GET  "entity[master_category_id]=510646adf7e4f33e2c000005" http://localhost:3000/master_entity/master_entity_list.json



3 #login with facebook
#    curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogeshwaghmare0gmail.com&&user[facebook_id]=100000716266389&user[gender]=male&user[provider]=facebook&user[name]=YogeshWaghmare" http://localhost:3000/facebook/create.json




4 #  lgoin with email
# curl -X POST -d "login[email]=yogesh480@gmail.com&login[password]=12345" http://localhost:3000/login/create.json

5 #  login with twitter

#  curl -X POST -d "user[twitter_id]=100001112611740&user[provider]=twitter&user[screen_name]=ywaghmare5203&user[name]=Yogesh Waghmare" http://localhost:3000/twitter/create.json



6 #for add friend
#
#  curl -X POST -d "friends[friends_id]=&friends[provider]=facebook&friends[facebook_id]=100001112611740&" http://localhost:3000/friends/create.json
#
7 #Add freind form email
#curl -X POST -d "friends[email]=yogesh@gmail.com&friends[provider]=email&friends[friends_email]="ashvin@gmail.com,deepak@gmail.com"&" http://localhost:3000/friends/email_friends.json

#
8 #for user category
#   curl -X POST -d "user_category[user_id]=2&user_category[master_category_id]=5" http://localhost:3000/user_category/create.json

9 # For master Entity
#curl -X GET -d "entity[master_category_id]=510646adf7e4f33e2c000005" http://localhost:3000/master_entity/show.json



10 #add Categories by user id
# curl -X POST -d "user_category[master_category_id]=510647a7f7e4f33e2c000006,5106467ff7e4f33e2c000004&user_category[user_id]=510cbe6bf7e4f3af88000001" http://localhost:3000/user_category/create.json

11 #get categories by user id
# curl -X GET -d "category[user_id]=510b81adf7e4f36ef2000002" http://localhost:3000/user_category/show.json

12 #aggrigate friends

curl -X POST -d "user_category[user_id]=2" http://localhost:3000/user_category/aggrigrator_friends.json

add category_by_master_category_id and_user_id
curl -X POST -d "entity[:user_id]=1&entity[:user_category_id]=4&entity[:master_entity_name]=Asian Sports&entity[:master_entity_info]=It's Good&entity[:master_entity_address]=Address of Master Entity&entity[master_entity_lat]=Master entity latitude&entity[master_entity_log]=Master entity Longitude" http://localhost:3000/user_entity/create.json

get user_category_by user_id

curl -X GET -d "user[user_id]=510bc6aff7e4f373ed000001" http://localhost:3000/user_category/aggrigrator_friends.json


#Web service to get all users
# curl -X GET  http://localhost:3000/user/all.json