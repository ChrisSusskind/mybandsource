class ResponsesController < ApplicationController
  before_action :set_review
  before_action :set_response, only: [:destroy, :upvote, :remove_upvote]
  def create
    @response = @review.responses.create({user_id: current_user.id, comment: params[:comment]})
    unless @response.valid?
      flash[:alert] = "Response creation failed"
    end
    render :action => 'response_display' if params[:user_profile] == "false"
    render :action => 'user_profile/response_display'
  end

  def destroy
    unless @response.destroy
      flash[:alert] = "Response deletion failed"
    end
    render :action => 'response_display' if params[:user_profile] == "false"
    render :action => 'user_profile/response_display'
  end

  def upvote
    @response.upvotes+=1
    @response.upvotes_userlist.nil? ?
    @response.upvotes_userlist = [current_user.id] :
    @response.upvotes_userlist += [current_user.id]
    unless @response.save
      flash[:alert] = "Response upvote failed"
    end
    render :action => 'response_display' if params[:user_profile] == "false"
    render :action => 'user_profile/response_display'
  end

  def remove_upvote
    @response.upvotes-=1
    @response.upvotes_userlist-=[current_user.id.to_s]
    unless @response.save
      flash[:alert] = "Response upvote failed"
    end
    render :action => 'response_display' if params[:user_profile] == "false"
    render :action => 'user_profile/response_display'
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def set_response
    @response = @review.responses.find(params[:id])
  end
end