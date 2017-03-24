class ReviewsController < ApplicationController
  before_action :set_artist
  before_action :set_review, only: [:update, :destroy, :upvote, :remove_upvote]

  def create
    @review = @artist.reviews.create({user_id: current_user.id, comment: params[:review][:comment], rating: params[:review][:rating]})
    unless @review.valid?
      flash[:alert] = "Review creation failed"
    end
    redirect_to @artist
  end

  def update
    unless @review.update(review_params)
      flash[:alert] = "Review update failed"
    end
    redirect_to @artist
  end

  def destroy
    if @review.destroy
      redirect_to @artist
    else
      flash[:alert] = "Review deletion failed"
      redirect_to @artist
    end
  end

  def upvote
    @review.upvotes+=1
    @review.upvotes_userlist+=[current_user.id]
    unless @review.save
      flash[:alert] = "Review upvote failed"
    end
    redirect_to @artist
  end

  def remove_upvote
    @review.upvotes-=1
    @review.upvotes_userlist-=[current_user.id.to_s]
    unless @review.save
      flash[:alert] = "Review remove upvote failed"
    end
    redirect_to @artist
  end

  def reorder
    (params[:recent_order] == "false") ?
      @reviews = @artist.reviews.page(params[:page]).order('upvotes DESC').per(25) :
      @reviews = @artist.reviews.page(params[:page]).order('created_at DESC').per(25)
    if params[:show_responses] == "false"
      render :action => 'show.js'
    else
      render :action => 'show_with_responses.js'
    end
  end

  def show_responses
    @reviews = @artist.reviews.page(params[:page]).order('upvotes DESC').per(25)
    render :action => 'show_with_responses.js'
  end

  def hide_responses
    @reviews = @artist.reviews.page(params[:page]).order('upvotes DESC').per(25)
    render :action => 'show.js'
  end

  private
  def review_params
    params.require(:review).permit(:comment, :rating)
  end

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def set_review
    @review = @artist.find(params[:id])
  end
end