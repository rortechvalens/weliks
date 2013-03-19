class TagController < ApplicationController
  def post_tag
    @post_tag = Tag.new(params[:tag])
    respond_to do |format|
      if @post_tag.save
        format.json {render :json => {:message=> "Successfully Tag"}}
      else
        format.json {render :json => {:message=> "some error during tag"}}
      end
    end
  end
end
