class ReviewsController < ApplicationController
  def create
    artist = Artist.find(params[:artist_id])
    @review = artist.reviews.create({user_id: current_user.id, comment: params[:review][:comment], rating: params[:review][:rating]})
    redirect_to artist
  end

  def update
    artist = Artist.find(params[:artist_id])
    @review = artist.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to artist
    else
      flash[:alert] = "Review update failed"
      redirect_to artist
    end
  end

  def destroy
    artist = Artist.find(params[:artist_id])
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to artist
    else
      flash[:alert] = "Review deletion failed"
      redirect_to artist
    end
  end

  def upvote
    artist = Artist.find(params[:artist_id])
    @review = Review.find(params[:id])
    @review.upvotes+=1
    @review.upvotes_userlist+=[current_user.id]
    @review.save
    redirect_to artist
  end

  def remove_upvote
    artist = Artist.find(params[:artist_id])
    @review = Review.find(params[:id])
    @review.upvotes-=1
    @review.upvotes_userlist-=[current_user.id.to_s]
    @review.save
    redirect_to artist
  end

  def reorder
    (params[:recent_order] == "false") ?
        @reviews = Review.where('artist_id = ?', params[:artist_id]).page(params[:page]).order('upvotes DESC').per(25) :
    @reviews = Review.where('artist_id = ?', params[:artist_id]).page(params[:page]).order('created_at DESC').per(25)

        render :action => 'show_reviews'
  end

  private
  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end