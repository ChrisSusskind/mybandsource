class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.where(viewed: false).order('created_at DESC')
  end

  def mark_viewed_user
    @notifications = Notification.where(receiving_user_id: current_user.id, viewed: false)
    @notifications.each do |notification|
      notification.update(viewed: true)
    end
    render action: 'mark_read_user'
  end

  def retrieve_notifications
    if current_user
      @notifications = Notification.where(receiving_user_id: current_user.id, viewed: false)
      render json: @notifications.to_json
    end
  end
end
