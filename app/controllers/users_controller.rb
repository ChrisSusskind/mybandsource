class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :upload_avatar]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user.is_artist
      @artist = @user
      if user_signed_in?
        @review = Review.find_by(receiving_user_id: @artist.id, leaving_user_id: current_user.id)
        @review.nil? ? @review = Review.new : @review
      end
      @reviews = @artist.received_reviews.page(params[:page]).order('updated_at DESC').per(25)
    else
      @reviews = @user.left_reviews.page(params[:page]).order('updated_at DESC').per(25)
    end
    respond_to do |format|
      format.html
      format.js {render :action => '../reviews/user_profile/show.js'}
    end
  end

  def upload_avatar
    @user.update_attributes({picture: params[:picture]})
    redirect_to user_path(@user)
  end

  def search_artists
    @artists = User.where("is_artist = ? and name ILIKE ?", true, "%#{params[:query]}%")
    respond_to do |format|
      format.json {render json: @artists.to_json}
    end
  end

  def get_artist
    @artist = User.artists.find_by({name: params[:query]})
    return redirect_to user_path(@artist) if @artist
    flash[:alert] = "No artist found by that name" unless @artist
    redirect_to root_path unless @artist
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end

