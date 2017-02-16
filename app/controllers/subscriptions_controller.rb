class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new({user_id: current_user.id, artist_id: params[:artist_id]})

    if @subscription.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Subscription failed"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @subscription = Subscription.find_by({user_id: current_user.id, artist_id: params[:artist_id]})
    @subscription.destroy
    redirect_back(fallback_location: root_path)
  end

  def artist_subscriptions
    subscriptions = Subscription.where({artist_id: params[:artist_id]})
    @users = []
    subscriptions.each do |subscription|
      @users.append(subscription.user)
    end
    render :action => 'index'
  end

  def user_subscriptions
    subscriptions = Subscription.where({user_id: params[:user_id]})
    @artists = []
    subscriptions.each do |subscription|
      @artists.append(subscription.artist)
    end
    render :action => 'index'
  end
end