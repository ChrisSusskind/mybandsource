class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => 'users/sessions#failure')
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    redirect_to root_path
  end

  def failure
    # Checks done for missing parameters, email exists in database, correct password entered
    return render :action => 'login_failure.js.erb', :locals => {message: missing_params} if params[:user][:email] == "" || params[:user][:password] == ""
    user = User.find_by(email: params[:user][:email])
    return render :action => 'login_failure.js.erb', :locals => {message: incorrect_email} if user == nil
    return render :action => 'login_failure.js.erb', :locals => {message: incorrect_password} if user.password != params[:user][:password]
    render :action => 'login_failure.js.erb', :locals => {message: server_error}
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def missing_params
    "Please make sure you enter all required information."
  end

  def incorrect_email
    "No account exists under the provided email address."
  end

  def incorrect_password
    "Incorrect password."
  end

  def server_error
    "Please try again later."
  end
end
