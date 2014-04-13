class Api::V1::BaseController < ActionController::Base
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_filter :authenticate_user!
 
  respond_to :json

  private
  
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    #puts "@@@@@@@@@@@@@@ :user_email is #{user_email}"
    user       = user_email && User.find_by_email(user_email)
    #puts "@@@@@@@@@@@@@@ user: #{user.name}"
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:token])
      sign_in user, store: false
    end
  end
end

