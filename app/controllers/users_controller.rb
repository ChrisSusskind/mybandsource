class UsersController < ApplicationController
  before_action :set_user, only: [:show, :upload_avatar, :upload_banner]

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
      @artist.view_count.present? ? @artist.view_count += 1 : @artist.view_count = 0
      @artist.save
    else
      @reviews = @user.left_reviews.page(params[:page]).order('updated_at DESC').per(25)
    end
    if params[:review].present?
      top_review = Review.find(params[:review])
      if params[:response_link].present?
        render 'show', locals: {top_review: top_review, response_link: true}
      else
        render 'show', locals: {top_review: top_review}
      end
    else
      respond_to do |format|
        format.html { render 'show' }
        format.js { render action: 'paginate_reviews' }
      end
    end
  end

  def create_artist
    render 'artist_signup'
  end

  def upload_avatar
    @user.update_attributes({ picture: params[:user][:picture] })
    redirect_to user_path(@user)
  end

  def upload_banner
    @user.update_attributes({ banner_picture: params[:user][:banner_picture] })
    redirect_to user_path(@user)
  end

  def search_artists
    @artists = User.where("is_artist = ? and name ILIKE ?", true, "%#{params[:query]}%")
    respond_to do |format|
      format.json {render json: @artists.to_json}
    end
  end

  def get_artist
    redirect_to "/search_results?query="+params[:query]
  end

  def render_search_page
    @artists = User.where("is_artist = ? and name ILIKE ?", true, "%#{params[:query]}%")
    render 'search_results', locals: { query: params[:query] }
  end

  def claim_artist
    ClaimMailer.claim_email(params[:artist], params[:email]).deliver_later
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end

