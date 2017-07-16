class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
     super
  end

  # POST /resource
   def create
     # Checks done for missing parameters, password length, password/password confirmation match, and email not already existing in database
     return render :action => 'signup_failure.js.erb', :locals => {message: missing_params_error} if params[:user][:name] == "" || params[:user][:email] == "" || params[:user][:password] == "" || params[:user][:password_confirmation] == ""
     return render :action => 'signup_failure.js.erb', :locals => {message: password_length_error} if params[:user][:password].length < 6
     return render :action => 'signup_failure.js.erb', :locals => {message: password_confirmation_error} if params[:user][:password] != params[:user][:password_confirmation]
     return render :action => 'signup_failure.js.erb', :locals => {message: existing_email_error} if User.find_by(email: params[:user][:email]) != nil

     if params[:commit] == "Add Artist Profile"
       build_resource(artist_params)
     else
       build_resource(sign_up_params)
     end

     if resource.save
       if resource.active_for_authentication?
         set_flash_message :notice, :signed_up
         sign_up(resource_name, resource)
         redirect_to root_path
       else
         set_flash_message :notice, :signed_up_but_unconfirmed
         redirect_to root_path
       end
     else
       clean_up_passwords resource
       render :action => 'signup_failure.js.erb', :locals => {message: server_error}
     end
   end

  # GET /resource/edit
   def edit
     super
   end

  #PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
     super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :location, :bio, :facebook_url, :itunes_url, :soundcloud_url, :spotify_url, :twitter_url, :genres_list => []])
  end

 def update_resource(resource, params)
   if params.has_key?(:genre)
     params["genre"] = Genre.find(params[:genre].to_i)
   end
   if params.has_key?(:genres_list)
     params["genres_list"].pop(1)
   end
   resource.update_with_password(params)
 end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

 def after_update_path_for(resource)
   user_path(resource)
 end

 def user_params
   params.fetch(:user, {})
   params.require(:user).permit(:name, :email, :location, :bio, :password, :password_confirmation)
 end

 def signup_params
   devise_parameter_sanitizer.sanitize(:sign_up)
 end

 def artist_params
   artist_params = params.require(:user).permit(:name, :email, :location, :label, :password, :password_confirmation, :is_artist).to_hash
   artist_params["genre"] = Genre.find(params[:user][:genre].to_i)
   artist_params[:is_artist] = true
   artist_params
 end

 def missing_params_error
   "Please make sure you enter all required information."
 end

 def password_length_error
   "Please choose a password that is at least 6 characters long."
 end

 def password_confirmation_error
   "Make sure your password and password confirmation match exactly."
 end

 def existing_email_error
   "Email already exists."
 end

 def server_error
   "Please try again later."
 end
end

