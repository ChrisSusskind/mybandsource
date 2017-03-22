class ReviewsController < ApplicationController
  def create
    artist = Artist.find(params[:artist_id])
    @review = artist.reviews.create({user_id: current_user.id, comment: params[:review][:comment], rating: params[:review][:rating]})
    redirect_to artist_path(artist)
  end

  def update
    artist = Artist.find(params[:artist_id])
    @review = @artist.reviews.find(params[:id])
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

  def get_more_reviews
    number_displayed = params[:number_displayed].to_i

    if number_displayed == -1
      if params[:recent_order] == "true"
        @reviews = Review.where('artist_id = ?', params[:artist_id]).order('created_at DESC').limit(10)
      else
        @reviews = Review.where('artist_id = ?', params[:artist_id]).order('upvotes DESC').limit(10)
      end
    else
      if params[:recent_order] == "true"
        temp = Review.where('artist_id = ?', params[:artist_id]).order('created_at DESC').to_a
      else
        temp = Review.where('artist_id = ?', params[:artist_id]).order('upvotes DESC').to_a
      end
      if temp.length < number_displayed + 10
        @reviews = temp.slice(number_displayed, 10)
      else
        @reviews = temp.slice(number_displayed, temp.length-number_displayed)
      end
    end

    respond_to do |format|
      format.js {render :action => "show_reviews"}
    end
  end

  def get_all_reviews
    number_displayed = params[:number_displayed].to_i

    if params[:recent_order] == "true"
      temp = Review.where('artist_id = ?', params[:artist_id]).order('created_at DESC').to_a
    else
      temp = Review.where('artist_id = ?', params[:artist_id]).order('upvotes DESC').to_a
    end
    @reviews = temp.slice(number_displayed, temp.length-number_displayed)
    respond_to do |format|
      format.js {render :action => "show_reviews"}
    end
  end

  def get_number_of_artists_reviews
    reviews = Artist.find(params[:artist_id]).reviews
    respond_to do |format|
      format.json {render json: {number_of_reviews: reviews.size}}
    end
  end

  private
  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end