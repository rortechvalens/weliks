class CommentController < ApplicationController

  def post_comment
    @comment = Comment.new
    @rating = Rating.new
    @post = Post.where(:user_entity_id => params[:user_entity_id], :user_id => params[:user_id]).first
    respond_to do |format|

        @comment.update_attributes(:self_user_id => params[:self_user_id],:post_id => @post.id,:user_id => params[:user_id], :all_tag => params[:all_tag], :all_user_name_tag => params[:all_user_name_tag], :is_new_comment=> "1",:is_active => "1",:comment_text => params[:comment_text])
         if @comment.save
         if params[:rating_count]
             @rating.update_attributes(:comment_id => @comment.id ,:self_user_id => params[:self_user_id],:user_id => params[:user_id], :post_id => @post.id,  :rating_count => params[:rating_count])
             @rating.save
         end
         format.json {render :json => {:message => "comment_successfully"}}
         else
           format.json {render :json => {:error => "error during comment"}}
         end
      end
   end

  def entity_comment
    @comment = Comment.new
    @rating = Rating.new
           @entity = UserEntity.where(:id => params[:user_entity_id], :user_id => params[:user_id]).first
       @comment.update_attributes(:self_user_id => params[:self_user_id],:user_entity_id =>@entity.id, :user_id => @entity.user_id, :all_tag => params[:all_tag], :all_user_name_tag => params[:all_user_name_tag], :is_new_comment=> "1",:is_active => "1",:comment_text => params[:comment_text])
    respond_to do |format|
    if @comment.save
         if params[:rating_count]
           @rating.update_attributes(:comment_id => @comment.id ,:self_user_id => params[:self_user_id],:user_id => params[:user_id], :user_entity_id => params[:user_entity_id], :rating_count => params[:rating_count])
             @rating.save
         end
          format.json {render :json => {:message => "comment_successfully"}}
         else
           format.json {render :json => {:error => "comment_successfully"}}
         end

    end
  end



 def comment_text
    @arr =Array.new
    arr1 = {}
    @arr1 = Array.new
    @comment_get = Comment.where(:post_id => params[:post_id], :user_id => params[:user_id]).last
    puts">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{@comment_get.inspect}"
    #x = @comment_get.comment_text
    #y = @comment_get.comment_text
    x = "This is @ashvin Gargav Using @yogesh Code."
    y = "This is @ashvin Gargav Using @yogesh Code."

    c = x.split(" ")
    c.each do |i|
      if i.include? "@"
       cd = i.slice!(1..-1)
        @arr << cd
      else
    end
    end
   puts":::::::::::::::::::::::::::::::::::::::::::#{@arr.inspect}"
   @arr.each do |op|
      final= y.gsub("@#{op}","<b><a href ='' style = 'color:blue; text-decoration: none' >#{op}<a></b>")
      y=final
      puts"\n\n+++++++++++++++++++++++++final++++++++++++++++++\n\n#{final.inspect}"
   end
  # @comment_get.comment_text = y
   respond_to do |format|
        if !@comment_get.blank?

          format.json{render :json => @comment_get}         
        else
          format.json{render :json => "ERROR"}
        end
      end   
  end
  end
