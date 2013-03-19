class RatingController < ApplicationController
  def post_rating
    @rating = Raiting.new(params[:rating])
    respond_to do |format|
    if @rating.save
      format.json {render :json => {:message => "Ratting Suceesfully"}}
    else
      format.json {render :json => {:message => "Some Errors"}}
    end
    end
  end
end
