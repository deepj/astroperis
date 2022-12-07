# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  %i[github gitlab].each do |provider|
    define_method provider do
      handle_omniauth(request.env["omniauth.auth"])
    end
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  private

  def handle_omniauth(omniauth_data)
    user = Users::UserFromOmniauthEvaluator.call(omniauth_data)

    if user.persisted?
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect user, event: :authentication
    else
      flash[:error] = "Try to sign in again. Something went wrong."
      redirect_to root_url
    end
  end

  def after_omniauth_failure_path_for(scope)
    new_user_session_path(scope)
  end
end
