# frozen_string_literal: true

module ApplicationHelper
  include ActiveSupport::NumberHelper
  include Pagy::Frontend

  def datetime_format(datetime)
    return "" if datetime.blank?

    datetime.strftime("%d %b %Y %H:%M")
  end
end
