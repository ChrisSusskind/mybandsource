class ReviewsController < ApplicationController
  before_action :set_artist
  before_action :set_review, only: [:update, :destroy]

  def create
    @review = @artist.reviews.create({user_id: current_user.id, comment: params[:review][:comment], rating: params[:review][:rating]})
    unless @review.valid?
      flash[:alert] = "Review creation failed"
    end
    create_review_display(@review)
  end

  def update
    unless @review.update(review_params)
      flash[:alert] = "Review update failed"
    end
    update_review_display
  end

  def destroy
    unless @review.destroy
      flash[:alert] = "Review deletion failed"
    end
    destroy_review_display
  end

  def upvote
    @review = @artist.reviews.find(params[:id])
    @review.upvotes+=1
    @review.upvotes_userlist.nil? ?
      @review.upvotes_userlist = [current_user.id] :
      @review.upvotes_userlist += [current_user.id]
    unless @review.save(touch: false)
      flash[:alert] = "Review upvote failed"
    end
    render :action => 'upvote_display.js.erb'
  end

  def remove_upvote
    @review = @artist.reviews.find(params[:id])
    @review.upvotes-=1
    @review.upvotes_userlist-=[current_user.id.to_s]

    unless @review.save(touch: false)
      flash[:alert] = "Review remove upvote failed"
    end
    render :action => 'upvote_display.js.erb'
  end

  def reorder
    (params[:recent_order] == "false") ?
      @reviews = @artist.reviews.page(params[:page]).order('upvotes DESC').per(25) :
      @reviews = @artist.reviews.page(params[:page]).order('updated_at DESC').per(25)
    if params[:show_responses] == "false"
      render :action => 'show.js'
    else
      render :action => 'show_with_responses.js'
    end
  end

  def show_responses
    @reviews = @artist.reviews.page(params[:page]).order('updated_at DESC').per(25)
    render :action => 'show_with_responses.js'
  end

  def hide_responses
    @reviews = @artist.reviews.page(params[:page]).order('updated_at DESC').per(25)
    render :action => 'show.js'
  end

  def create_review_display (review)
    @reviews = @artist.reviews.page(params[:page]).order('updated_at DESC').per(25)
    render :action => 'create_review_display.js.erb', locals: {artist: @artist, review: review}
  end

  def update_review_display
    @reviews = @artist.reviews.page(params[:page]).order('updated_at DESC').per(25)
    render :action => 'update_review_display.js.erb'
  end

  def destroy_review_display
    @reviews = @artist.reviews.page(params[:page]).order('updated_at DESC').per(25)
    @review = Review.new
    render :action => 'destroy_review_display.js.erb', locals: {artist: @artist, review: @review}
  end

  private
  def review_params
    params.require(:review).permit(:comment, :rating)
  end

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def set_review
    @review = @artist.reviews.find(params[:id])
  end
end