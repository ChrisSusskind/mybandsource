class UserRelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    create_notification(current_user, @user)
    redirect_to @user
  end

  def destroy
    current_user.unfollow(@user)
    destroy_notification(current_user, @user)
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_notification(generating_user, receiving_user)
    Notification.create(generating_user_id: generating_user.id, receiving_user_id: receiving_user.id, notification_type: 'follow')
  end

  def destroy_notification(generating_user, receiving_user)
    Notification.where(generating_user_id: generating_user.id, receiving_user_id: receiving_user.id, notification_type: 'follow').destroy_all
  end
end
