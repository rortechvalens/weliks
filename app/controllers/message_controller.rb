class MessageController < ApplicationController
  def create
    @message = Message.new(params[:message])
     if params[:message_image]
      message_picture = (params[:message_image]).gsub(" ","+")
      data = StringIO.new(Base64.decode64(message_picture))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "#{@message.parent_message_id}.jpg"
      data.content_type = "image/jpg"
      @message.message_image = data
       end
     respond_to do |format|
       if @message.save
         if (@message.receiver_type =='single' )
          @message_receiver = MessageReceiver.create
          @message_receiver.update_attribute(:message_id => @message.id,sender_id =>params[:message][:sender_id],:user_id =>params[:message][:receiver_id],:is_active =>params[:message][:is_active] )
          @message_receiver.save
          if !@message_receiver.blank?
            format.json{render :json =>{:message =>"Data Saved."} }
          end
        else#Receiver type is group
          @group_members=GroupMembers.new
          @group_members=GroupMembers.where(:group_id => params[:message][:receiver_id])
          if !@group_members.blank?
            @group_members.each do |f|
              @message_receiver = MessageReceiver.new
              @message_receiver.update_attribute(:message_id => @message.id,sender_id =>params[:message][:sender_id],:user_id =>params[:message][:receiver_id],:is_active =>params[:message][:is_active] )
              @message_receiver.save
            end
          end
        end
        format.json{render :json =>{:message =>"Data Saved."} }
       else
        format.json{render :json =>{:message =>"Data Not Saved."} }
       end
     end
  end
end
