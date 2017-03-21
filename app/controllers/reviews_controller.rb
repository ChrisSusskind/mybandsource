class ReviewsController < ApplicationController
  def create
    @artist = Artist.find(params[:artist_id])
    @review = @artist.reviews.create({user_id: current_user.id, comment: params[:review][:comment], rating: params[:review][:rating]})
    redirect_to artist_path(@artist)
  end

  def update
    @artist = Artist.find(params[:artist_id])
    @review = @artist.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to @artist
    else
      flash[:alert] = "Review update failed"
      redirect_to @artist
    end
  end

  private
  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end