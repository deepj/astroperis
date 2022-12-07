# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include AdditionalFlashTypes

  layout "landing"

  def destroy
    super do
      flash.clear
      flash[:success] = "Signed out successfully."
    end
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
