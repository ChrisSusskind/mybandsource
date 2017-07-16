class UserRelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    create_notification(current_user, @user)

    ActionCable.server.broadcast(
      "notification_center_channel_#{@user.id}",
      sender_name: current_user.name,
      sender_id: current_user.id,
      type: "follow"
    )

    respond_to do |format|
      format.html { redirect_to @user }
      format.js { render action: 'follow.js.erb', locals: {id: params[:id]} }
    end
  end

  def destroy
    current_user.unfollow(@user)
    destroy_notification(current_user, @user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js { render action: 'unfollow.js.erb', locals: {id: params[:id]} }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_notification(generating_user, receiving_user)
    Notification.create(generating_user_id: generating_user.id, receiving_user_id: receiving_user.id, notification_type: 'follow', generating_user_name: generating_user.name, generating_user_picture: generating_user.picture)
  end

  def destroy_notification(generating_user, receiving_user)
    Notification.where(generating_user_id: generating_user.id, receiving_user_id: receiving_user.id, notification_type: 'follow').destroy_all
  end
end