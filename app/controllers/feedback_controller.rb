class FeedbackController < ApplicationController


   def feedback_user
     puts"params<><><><><><><><<><><><><><><><><><><><><><><><><<<><><><><><><><><><><><><><><><><><>#{params.inspect}"
     @feed_back = UserFeedback.feedback(params[:feedback][:user_id],params[:feedback][:message],params[:feedback][:subject],params[:feedback][:user_name])
     @feed_back.deliver
     respond_to do |format|
       format.html {redirect_to :action => "show", :controller => "feedback"}
         format.json {render :json => {:message => "Feedback"}}
    end

    
  end

   def show
     
   end
end
