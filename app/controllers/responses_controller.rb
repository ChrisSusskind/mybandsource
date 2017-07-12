class ResponsesController < ApplicationController
  before_action :set_user, except: [:report]
  before_action :set_review, except: [:report]
  before_action :set_response, only: [:destroy, :upvote, :remove_upvote]

  def create
    @response = @review.responses.create({user_id: current_user.id, comment: params[:comment]})
    if !@response.valid?
      flash[:alert] = "Response creation failed"
    else
      @user.increment_response_count
      if current_user != @user
        create_notification(current_user, @review.leaving_user_id, @response)
      end
    end
    render :action => 'response_display', locals: {is_artist: @user.is_artist}
  end

  def destroy
    destroy_notification(current_user, @review.leaving_user_id, @response)
    if !@response.destroy
      flash[:alert] = "Response deletion failed"
    else
      @user.decrement_response_count
    end
    render :action => 'response_display', locals: {is_artist: @user.is_artist}
  end

  def upvote
    @response.upvotes+=1
    @response.upvotes_userlist.nil? ?
    @response.upvotes_userlist = [current_user.id] :
    @response.upvotes_userlist += [current_user.id]
    unless @response.save
      flash[:alert] = "Response upvote failed"
    end
    render :action => 'response_display', locals: {is_artist: @user.is_artist}
  end

  def remove_upvote
    @response.upvotes-=1
    @response.upvotes_userlist-=[current_user.id.to_s]
    unless @response.save
      flash[:alert] = "Response upvote failed"
    end
    render :action => 'response_display', locals: {is_artist: @user.is_artist}
  end

  def share
    link = root_url[0...-1] + user_path(@user) + "?review=" + params[:review_id] + "%26response_link=true" + "%23review" + params[:review_id]
    render :action => 'share_response.js.erb', locals: {link: link}
  end

  def report
    @response = Response.find(params[:id])

  end

  private

  def set_user
    @user = User.find(params[:user_id]);
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def set_response
    @response = @review.responses.find(params[:id])
  end

  def create_notification(generating_user, receiving_user_id, response)
    Notification.create(generating_user_id: generating_user.id, receiving_user_id: receiving_user_id, response_id: response.id, notification_type: 'response', generating_user_name: generating_user.name, generating_user_picture: generating_user.picture)
  end

  def destroy_notification(generating_user, receiving_user_id, response)
    Notification.where(generating_user_id: generating_user.id, receiving_user_id: receiving_user_id, response_id: response.id, notification_type: 'response').destroy_all
  end
end