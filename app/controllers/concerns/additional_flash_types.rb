# frozen_string_literal: true

module AdditionalFlashTypes
  extend ActiveSupport::Concern

  included do
    add_flash_types :success, :error
  end
end
