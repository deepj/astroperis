# frozen_literal_string: true

class ApplicationController < ActionController::Base
  include AdditionalFlashTypes
  include Pagy::Backend

  before_action :authenticate_user!
end
