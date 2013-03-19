class UserFeedback < ActionMailer::Base
  #default from: "from@example.com"

  def feedback(username, subject,message,name)
   @user = username
    @url = $URL
    mail(:from => "ywaghmare5203@gmail.com", :to => "weliike.feedback@gmail.com",:subject => "Welcome user")
end

end
