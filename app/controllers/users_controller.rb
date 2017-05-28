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
    @reviews = @user.reviews.page(params[:page]).order('updated_at DESC').per(25)
    respond_to do |format|
      format.html
      format.js {render :action => '../reviews/user_profile/show.js'}
    end
  end

  def upload_avatar
    @user.update_attributes({picture: params[:picture]})
    redirect_to user_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
